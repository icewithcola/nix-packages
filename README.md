# Kagura's Nixpkgs Repo

## Setup
### nix flake
In `flake.nix`, add this in `inputs` section
```nix
kaguraRepo = {
   url = "github:icewithcola/nix-packages";
   inputs.nixpkgs.follows = "nixpkgs";
};
```
And in `outputs.modules`, inside `[ ... ]`, add
```nix
({
   nixpkgs.overlays = [
   (final: prev: {
      kaguraRepo = inputs.kaguraRepo.packages."${prev.system}";
   })
   ];
})
```
### nix-channel
In `configuration.nix`, add
```nix
nixpkgs.config.packageOverrides = pkgs: {
  kaguraRepo = import (builtins.fetchTarball "https://github.com/icewithcola/nix-packages/archive/master.tar.gz") {
    inherit pkgs;
  };
};
```
Then you can use `pkgs.kaguraRepo.<package>`
