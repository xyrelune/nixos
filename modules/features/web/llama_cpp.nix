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
        hf-repo = "unsloth/Llama-3.2-3B-Instruct-GGUF";
        hf-file = "Llama-3.2-3B-Instruct-UD-Q6_K_XL.gguf";
        alias = "unsloth/Llama-3.2-3B-Instruct-GGUF";
        port = 3434;
        host = "0.0.0.0";
        c = 32768;
      };
    };
  };
}
