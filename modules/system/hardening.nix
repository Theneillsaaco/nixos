{
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 1;
    "net.core.bpf_jit_harden" = 1;
    "kernel.unprivileged_bpf_disabled" = 1;
  };
}