final: prev: {
  discord-canary = prev.discord-canary.overrideAttrs (oa: rec {
    version = "0.0.126";
    src = prev.fetchurl {
      url =
        "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
      sha256 = "0apj1c4my17ca452wdga2zb82iqsbljbbg2fylfdvslx286r7dhj";
    };
  });
  discord-ptb = prev.discord-ptb.overrideAttrs (oa: rec {
    version = "0.0.25";
    src = prev.fetchurl {
      url =
        "https://dl-ptb.discordapp.net/apps/linux/${version}/discord-ptb-${version}.tar.gz";
      sha256 = "082ygmsycicddpkv5s03vw3rjkrk4lgprq29z8b1hdjifvw93b21";
    };
  });
  discord = prev.discord.overrideAttrs (oa: rec {
    version = "0.0.15";
    src = prev.fetchurl {
      url =
        "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "0pn2qczim79hqk2limgh88fsn93sa8wvana74mpdk5n6x5afkvdd";
    };
  });
}
