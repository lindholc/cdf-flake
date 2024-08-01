{
  description = "C libraries and tools for working with Common Data Format (CDF) files";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;

    cdf = {
      url = "https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf39_1/linux/cdf39_1-dist-cdf.tar.gz";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, cdf }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in rec {
      packages.cdf =
        pkgs.stdenv.mkDerivation {
          name = "cdf";
          version = "3.9.1";
          src = cdf;

          buildInputs = [
            pkgs.ncurses
          ];

          # NOTE: Setting enableParallelBuilding to true will break
          # the install phase. Setting -j here instead.
          buildFlags = [
            "-j"
            "OS=linux"
            "ENV=gnu"
            "all"
          ];

          installFlags = [
            "INSTALLDIR=$(out)"
          ];
        };

      packages.x86_64-linux.default = packages.cdf;

      apps.x86_64-linux = {
        cdfcompare = {
          type = "app";
          program = "${packages.cdf}/bin/cdfcompare";
        };

        cdfconvert = {
          type = "app";
          program = "${packages.cdf}/bin/cdfconvert";
        };

        cdfdir = {
          type = "app";
          program = "${packages.cdf}/bin/cdfdir";
        };

        cdfdump = {
          type = "app";
          program = "${packages.cdf}/bin/cdfdump";
        };

        cdfedit = {
          type = "app";
          program = "${packages.cdf}/bin/cdfedit";
        };

        cdfexport = {
          type = "app";
          program = "${packages.cdf}/bin/cdfexport";
        };

        cdfinquire = {
          type = "app";
          program = "${packages.cdf}/bin/cdfinquire";
        };

        cdfirsdump = {
          type = "app";
          program = "${packages.cdf}/bin/cdfirsdump";
        };

        cdfleapsecondsinfo = {
          type = "app";
          program = "${packages.cdf}/bin/cdfleapsecondsinfo";
        };

        cdfmerge = {
          type = "app";
          program = "${packages.cdf}/bin/cdfmerge";
        };

        cdfstats = {
          type = "app";
          program = "${packages.cdf}/bin/cdfstats";
        };

        cdfvalidate = {
          type = "app";
          program = "${packages.cdf}/bin/cdfvalidate";
        };

        skeletoncdf = {
          type = "app";
          program = "${packages.cdf}/bin/skeletoncdf";
        };

        skeletontable = {
          type = "app";
          program = "${packages.cdf}/bin/skeletontable";
        };
      };
    };
}
