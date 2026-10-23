import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
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
        text: "My first bar"
        color: root.col_fg
        font.pixelSize: 14
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8

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
