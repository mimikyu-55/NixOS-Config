-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")

-- NVIDIA
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- Hardware video decoding via nvidia-vaapi-driver
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
