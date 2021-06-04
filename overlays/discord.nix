self: super: {
  discord-canary = super.discord-canary.overrideAttrs
  (oa: rec {
    version = "0.0.123";
    src = super.fetchurl {
      url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
      sha256 = "0bijwfsd9s4awqkgxd9c2cxh7y5r06vix98qjp0dkv63r6jig8ch";
    };
  });
  discord-ptb = super.discord-ptb.overrideAttrs
  (oa: rec {
    version = "0.0.25";
    src = super.fetchurl {
      url = "https://dl-ptb.discordapp.net/apps/linux/${version}/discord-ptb-${version}.tar.gz";
      sha256 = "082ygmsycicddpkv5s03vw3rjkrk4lgprq29z8b1hdjifvw93b21";
    };
  });
  discord = super.discord.overrideAttrs
  (oa: rec {
    version = "0.0.15";
    src = super.fetchurl {
      url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "0pn2qczim79hqk2limgh88fsn93sa8wvana74mpdk5n6x5afkvdd";
    };
  });
}
