{ den, ... }: {
  den.aspects.host = { host, ... }: {
    includes = [ den.batteries.hostname ];

    os.system.stateVersion = host.stateVersion;
    provides.to-users.homeManager.home.stateVersion = host.stateVersion;
  };
}
