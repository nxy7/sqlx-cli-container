{
  description = "A very basic flake";

  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {

      packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      packages.x86_64-linux.default = pkgs.dockerTools.buildImage {
        name = "sqlx-cli";
        tag = "latest";
        created = "now";

        copyToRoot = pkgs.buildEnv {
          name = "image-root";
          paths = [ pkgs.bash pkgs.sqlx-cli ];
          pathsToLink = [ "/bin" ];
        };

        config = { Cmd = [ "/bin/sqlx" ]; };
      };

    };
}
