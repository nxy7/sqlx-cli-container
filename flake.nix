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
        config = { Entrypoint = [ "${pkgs.sqlx-cli}/bin/sqlx" ]; };
      };

    };
}
