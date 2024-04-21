{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/d8fe5e6c92d0d190646fb9f1056741a229980089.tar.gz") { }
}:

with pkgs;
mkShell rec {
  name = "INF01175";

  nativeBuildInputs = [
    gtkwave
    ghdl-llvm
    (callPackage ./nix/ghdl-ls.nix { ghdl = ghdl-llvm; })

    # VSCode pre-configured with good VHDL extensions
    (vscode-with-extensions.override {
      vscode = pkgs.vscode.fhsWithPackages (ps: [ ]);
      vscodeExtensions = with vscode-extensions; [
        jnoortheen.nix-ide
        (
          let
            repo = fetchFromGitHub {
              owner = "ghdl";
              repo = "ghdl-language-server";
              rev = "c37639859f4c663f1f8c77ef2c24d0ef3265e3b1";
              hash = "sha256-iuuuYU/lT+IDFYrdIXrp9v+3skdvAfrAacJVIkdgQJU=";
            };
            vhdl-lsp = buildNpmPackage
              rec {
                name = "ghdl-language-server";
                version = "0.1.0-dev";
                src = "${repo}/vscode-client";
                npmDepsHash = "sha256-zRLowgd/hYJ87iEWAPqfU8vJDbUMRaQDWkMnrgu/BuQ=";
                buildPhase = ''
                  vsce package --skip-license
                  mv vhdl-lsp-0.1.0-dev.vsix vhdl-lsp-0.1.0-dev.zip
                '';
                nativeBuildInputs = [
                  vsce
                ];
              };
          in
          vscode-utils.buildVscodeExtension rec {
            name = "ghdl-language-server";
            vscodeExtName = "vhdl-lsp";
            vscodeExtPublisher = "tgingold";
            vscodeExtUniqueId = "${vscodeExtPublisher}.${vscodeExtName}";
            version = "0.1.0-dev";
            src = "${vhdl-lsp}/lib/node_modules/vhdl-lsp/vhdl-lsp-0.1.0-dev.zip";
          }
        )
      ];
    })
  ];
}
