//@ pragma UseQApplication
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    // theme colours
    property color col_bg: "#1a1b26"
    property color col_fg: "#a9b1d6"
    property color col_muted: "#444b6a"
    property color col_cyan: "#0db9d7"
    property color col_purple: "#ad8ee6"
    property color col_red: "#f7768e"
    property color col_yellow: "#e0af68"
    property color col_blue: "#7aa2f7"

    // tray icon order, left to right (by item id); unlisted items go last
    property var trayOrder: ["chrome_status_icon_1", "steam", "proton.vpn.app.gtk"]
    property var trayItems: SystemTray.items.values.slice().sort((a, b) => {
        const rank = i => {
            const n = trayOrder.indexOf(i.id);
            return n === -1 ? trayOrder.length : n;
        };
        return rank(a) - rank(b);
    })

    // font
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 14

    // system info
    property int cpu_usage: 0
    property var last_cpu_idle: 0
    property var last_cpu_total: 0

    Process {
        id: cpu_proc
        command: ["sh", "-c", "head -1 /proc/stat"]

        stdout: SplitParser {
            onRead: data => {
                var p = data.trim().split(/\s+/);
                var idle = parseInt(p[4]) + parseInt(p[5]);
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);
                if (last_cpu_total > 0) {
                    cpu_usage = Math.round(100 * (1 - (idle - last_cpu_idle) / (total - last_cpu_total)));
                }
                last_cpu_total = total;
                last_cpu_idle = idle;
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 5000
        running: true
        repeat: true

        onTriggered: cpu_proc.running = true
    }

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: root.col_bg
    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "HH:mm:ss - ddd d MMM")
        color: root.col_fg
        font {
            family: root.fontFamily
            pixelSize: root.fontSize
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        anchors.topMargin: 4
        anchors.bottomMargin: 4

        Repeater {
            model: 5

            Text {
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                text: index + 1
                color: isActive ? root.col_cyan : (ws ? root.col_blue : root.col_muted)
                font {
                    pixelSize: 14
                    bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.rightMargin: 8
            visible: SystemTray.items.values.length > 0
            implicitWidth: trayRow.implicitWidth + 16
            implicitHeight: trayRow.implicitHeight + 4
            color: "transparent"
            border.color: root.col_muted
            border.width: 1
            radius: 6

            Row {
                id: trayRow
                anchors.centerIn: parent
                spacing: 8

                Repeater {
                    model: root.trayItems

                    MouseArea {
                        id: trayItem
                        required property SystemTrayItem modelData

                        implicitWidth: 18
                        implicitHeight: 18
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                        onClicked: event => {
                            if (event.button === Qt.MiddleButton)
                                modelData.secondaryActivate();
                            else if (event.button === Qt.RightButton || modelData.onlyMenu) {
                                if (modelData.hasMenu)
                                    menu.open();
                            } else
                                modelData.activate();
                        }

                        IconImage {
                            anchors.fill: parent
                            source: trayItem.modelData.icon
                        }

                        QsMenuAnchor {
                            id: menu
                            menu: trayItem.modelData.menu
                            anchor.item: trayItem
                            anchor.edges: Edges.Bottom | Edges.Left
                        }
                    }
                }
            }
        }

        Text {
            text: "CPU: " + cpu_usage + "%"
            color: root.col_yellow
            font {
                family: root.fontFamily
                pixelSize: root.fontSize
                bold: true
            }
        }
    }
}
