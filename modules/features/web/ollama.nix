{
  self,
  input,
  ...
}: {
  flake.nixosModules.ollama = {
    pkgs,
    ...
  }: {
    services = {
      ollama = {
        enable = true;
        host = "0.0.0.0";
        package = pkgs.ollama-cuda;
        loadModels = [
          "qwen3:8b"
          "qwen3.5:4b"
        ];
      };
      open-webui = {
        enable = true;
        port = 3344;
        host = "0.0.0.0";
        environment = {
          OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
          WEBUI_AUTH = "False";
        };
      };
    };
  };
}
