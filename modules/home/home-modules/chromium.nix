{
  self,
  inputs,
  ...
}: {
  flake.homeModules.chromium = {
    pkgs,
    ...
  }: {
    programs.chromium = {
      enable = true;
      package = (pkgs.ungoogled-chromium.override {
        enableWideVine = true;
        commandLineArgs = [
             "--enable-features=AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
          "--enable-features=VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport"
          "--enable-features=UseMultiPlaneFormatForHardwareVideo"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
        ];
      });
    };
  };
}
