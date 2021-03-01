self: super: {
  haskellPackages = super.haskellPackages.extend
  (super.haskell.lib.packageSourceOverrides {
    xmonad = super.fetchFromGitHub {
      owner = "xmonad";
      repo = "xmonad";
      rev = "a90558c07e3108ec2304cac40e5d66f74f52b803";
      sha256 = "1swn4lfdvbancc2vqlidprr8lnllq9cwqiknri5q9ikg4n2clc7r";
    };

    xmonad-contrib = super.fetchFromGitHub {
      owner = "xmonad";
      repo = "xmonad-contrib";
      rev = "ebf9561d762051b7f82b47242d7b30337662dc37";
      sha256 = "11p3x469yy2c9q3vir600s21lmb1vaki1qc9pgb7vm900l0cr3ym";
    };
  });
}
