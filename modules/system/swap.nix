{
  zramSwap = {
    enable = true;
    memoryPercent = 75;
    algorithm = "zstd";
  };
  
  boot.kernel.sysctl = {
    "vm.swappiness" = 100;
    "vm.vfs_cache_pressure" = 50;
  };
}