{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./power.nix {
  options = {
    hibernation.enable = modules.mkEnableOption true "hibernation";
  };
  config =
    { self, ... }:
    {
      programs.plasma.powerdevil = rec {
        battery = {
          autoSuspend = {
            action = "sleep";
            idleTimeout = 10 * 60;
          };
          dimDisplay = {
            enable = true;
            idleTimeout = 2 * 60;
          };
          turnOffDisplay = {
            idleTimeout = 5 * 60;
            idleTimeoutWhenLocked = 2 * 60;
          };
          dimKeyboard.enable = false;
          inhibitLidActionWhenExternalMonitorConnected = true;
          powerButtonAction = "showLogoutScreen";
          powerProfile = "balanced";
          whenLaptopLidClosed = "sleep";
          whenSleepingEnter = if self.hibernation.enable then "hybridSleep" else "standby";
        };
        AC = lib.attrsets.recursiveUpdate battery {
          autoSuspend = {
            action = "nothing";
            idleTimeout = null;
          };
          turnOffDisplay = {
            idleTimeout = "never";
            idleTimeoutWhenLocked = null;
          };
          powerProfile = "performance";
        };
        lowBattery = lib.attrsets.recursiveUpdate battery {
          powerProfile = "powerSaving";
        };
        batteryLevels = {
          criticalAction = "hibernate";
          criticalLevel = 5;
          lowLevel = 20;
        };
        general.pausePlayersOnSuspend = true;
      };
    };
}
