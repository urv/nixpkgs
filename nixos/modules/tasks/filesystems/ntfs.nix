{ config, lib, pkgs, ... }:

with lib;

let

  inInitrd = any (fs: fs == "ntfs") config.boot.initrd.supportedFilesystems;

in

{
  config = mkIf (any (fs: fs == "ntfs" || fs == "ntfs-3g") config.boot.supportedFilesystems) {

    system.fsPackages = [ pkgs.ntfs3g ];

    boot.initrd.kernelModules = mkIf inInitrd [ "jfs" ];

    boot.initrd.extraUtilsCommands = mkIf inInitrd ''
      copy_bin_and_libs ${pkgs.jfsutils}/sbin/fsck.jfs
    '';
  };
}
