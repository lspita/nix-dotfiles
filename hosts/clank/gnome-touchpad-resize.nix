{ ... }:
{
  # Resize touchpad to contrast gnome scrolling speed.
  # https://wayland.freedesktop.org/libinput/doc/latest/absolute-coordinate-ranges.html
  # Original size: 134.6x82.6mm
  # nix-shell -p libinput --run "sudo libinput measure touchpad-size WxH"
  services.udev.extraHwdb = ''
    # HP OmniBook Ultra Flip 14 (134.6x82.6 * 0.4 = 54x33)
    evdev:name:SYNA3580:00 06CB:CFD2 Touchpad:dmi:*svnHP:*pnHPOmniBookUltraFlipLaptop14-fh0xxx**
     EVDEV_ABS_00=::30
     EVDEV_ABS_01=::30
     EVDEV_ABS_35=::30
     EVDEV_ABS_36=::30
  '';
}
