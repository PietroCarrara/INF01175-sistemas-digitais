{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/d8fe5e6c92d0d190646fb9f1056741a229980089.tar.gz") { }
}:

with pkgs;
mkShell rec {
  name = "INF01175";

  nativeBuildInputs = [
    ghdl-llvm
    (callPackage ./ghdl-ls.nix { ghdl = ghdl-llvm; })

    # VSCode pre-configured with good VHDL extensions
    (vscode-with-extensions.override {
      vscode = pkgs.vscode.fhsWithPackages (ps: [ ]);
      vscodeExtensions = with vscode-extensions; [
        jnoortheen.nix-ide
      ];
    })
  ];
}
