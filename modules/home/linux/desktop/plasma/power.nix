{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./power.nix {
  config = {
    programs.plasma.powerdevil = rec {
      battery = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 5 * 60;
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 2 * 60;
        };
        turnOffDisplay = {
          idleTimeout = 3 * 60;
          idleTimeoutWhenLocked = 1 * 60;
        };
        dimKeyboard.enable = false;
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "showLogoutScreen";
        powerProfile = "balanced";
        whenLaptopLidClosed = "sleep";
        whenSleepingEnter = "standby";
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
        criticalAction = "sleep";
        criticalLevel = 2;
        lowLevel = 20;
      };
      general.pausePlayersOnSuspend = true;
    };
  };
}
