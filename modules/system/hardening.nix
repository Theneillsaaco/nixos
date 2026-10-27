{
  boot.kernelParams = [
    "slab_nomerge"
    "init_on_alloc=1"
    "randomize_kstack_offset=on"
    "vsyscall=none"
  ];
  
  boot.blacklistedKernelModules = [
    "dccp" "sctp" "rds" "tipc" "ax25" "netrom" "rose"
    "cramfs" "freevxfs" "jffs2" "hfs" "hfsplus"
  ];
  
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 1;
    "net.core.bpf_jit_harden" = 1;
    "kernel.unprivileged_bpf_disabled" = 1;

    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.tcp_rfc1337" = 1;
  };
}