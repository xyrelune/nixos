{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.llamacpp = {
    pkgs,
    ...
  }: {
    services.llama-cpp = {
      enable = true;
      package = (pkgs.llama-cpp.override { cudaSupport = true; });
      settings = {
        hf-repo = "lmstudio-community/Qwen3.5-4B-GGUF";
        hf-file = "Qwen3.5-4B-Q4_K_M.gguf";
        alias = "lmstudio-community/Qwen3.5-4B-GGUF";
        port = 3434;
        host = "0.0.0.0";
      };
    };
  };
}
