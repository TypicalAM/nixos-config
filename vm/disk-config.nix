{
  disko.devices = {
    disk.home = {
      type = "disk";
      device = "/dev/vdb";
      content = {
        type = "gpt";
        partitions = {
          home = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
              extraArgs = ["-L" "home"];
            };
          };
        };
      };
    };
  };
}
