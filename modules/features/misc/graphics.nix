{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.graphics = {
    specialisation = {
      nvidia.configuration = {
        hardware = {
          graphics.enable = true;
          nvidia.open = true;
        };
        services.xserver.videoDrivers = [ "nvidia" ];
      };
      amd.configuration = {
        hardware = {
          graphics = {
            enable = true;
            enable32Bit = true;
          };
        };
        services.xserver.videoDrivers = [ "amdgpu" ];
      };
    };
  };
}
