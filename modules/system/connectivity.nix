{ pkgs, config, lib, ... }:
{
  # see: nixos.wiki/wiki/WireGuard
  networking.firewall = {
    # if packets are still dropped, they will show up in dmesg
    logReversePathDrops = true;
    # wireguard trips rpfilter up
    extraCommands = ''
      ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --sport 3389 -j RETURN
      ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --dport 3389 -j RETURN
    '';
    extraStopCommands = ''
      ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --sport 3389 -j RETURN || true
      ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --dport 3389 -j RETURN || true
    '';
  };

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    hsphfpd.enable = true;
  };

  services.blueman.enable = true;

  programs.ssh.startAgent = true;
}

