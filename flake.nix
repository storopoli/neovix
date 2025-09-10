{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks.url = "github:cachix/git-hooks.nix";

  };

  outputs =
    {
      nixvim,
      flake-parts,
      git-hooks,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { self', system, ... }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              # inherit (inputs) foo;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
            pre-commit-check = inputs.git-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                # Nix
                nixfmt-rfc-style.enable = true;

                statix.enable = true;

                flake-checker = {
                  enable = true;
                  args = [
                    "--check-outdated"
                    "false" # don't check for nixpkgs
                  ];
                };

                # Lua
                luacheck.enable = true;

                # GH Action
                zizmor.enable = true;
              };
            };
          };

          # Lets you run `nix run .` to start nixvim
          packages.default = nvim;

          devShells.default = pkgs.mkShell {
            buildInputs = [
              nvim
              pkgs.nil
              pkgs.nixd
            ]
            ++ self'.checks.pre-commit-check.enabledPackages;
            inherit (self'.checks.pre-commit-check) shellHook;
          };
        };

      flake.overlays.default = final: prev: {
        neovix = final.pkgs.neovix or final.pkgs.neovim;
      };
    };
}
