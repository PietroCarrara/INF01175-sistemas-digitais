{ lib
, fetchPypi
, fetchFromGitHub
, python312
, python312Packages
, ghdl
, stdenvNoCC
}:
let
  pythonWithPackages = (python312.withPackages (pkgs:
    let
      pyTooling = (pkgs.buildPythonPackage rec {
        name = "pyTooling";
        version = "4.0.1";
        doCheck = false;
        src = fetchFromGitHub {
          owner = "pyTooling";
          repo = name;
          hash = "sha256-Q9Y9E5KHktdHsrGX2SWHYMrZZOTUam0n8E1PUaPALdY=";
          rev = "v${version}";
        };
      });
      pyAttributes = (pkgs.buildPythonPackage rec {
        name = "pyAttributes";
        version = "2.3.2";
        doCheck = false;
        src = fetchFromGitHub {
          owner = "pyTooling";
          repo = name;
          hash = "sha256-b3HJV/YE/H1pzbGwoveV7tqnL45VoQnm1/pbooRXjF8=";
          rev = "v${version}";
        };
        nativeBuildInputs = [
          pyTooling
        ];
      });
      pyVHDLModel = (pkgs.buildPythonPackage rec {
        name = "pyVHDLModel";
        version = "0.25.1";
        doCheck = false;
        src = fetchFromGitHub {
          owner = "VHDL";
          repo = name;
          hash = "sha256-1x8q0DIxG+usr5JK2ZADYmOpE7yenOFuF4BCu/oficM=";
          rev = "v${version}";
        };
        nativeBuildInputs = [
          pyTooling
        ];
      });
    in
    [
      pyTooling
      pyAttributes
      pyVHDLModel
    ]));
in
pythonWithPackages.pkgs.buildPythonApplication rec {
  pname = "ghdl-ls";
  version = "4.0.0";

  src = fetchFromGitHub {
    owner = "ghdl";
    repo = "ghdl";
    rev = "v${version}";
    hash = "sha256-KQwesrj2g8cDCyiEb5j4bkM5O3fGPuXzGUOEEGw6zRI=";
  };

  propagatedBuildInputs = [
    pythonWithPackages
  ];

  pyproject = true;
  build-system = [
    pythonWithPackages.pkgs.setuptools
    pythonWithPackages.pkgs.wheel
  ];

  patchPhase = ''
    substituteInPlace ./pyGHDL/libghdl/__init__.py \
      --replace 'r = os_environ.get("GHDL_PREFIX")' 'r = "${ghdl}/lib"'
  '';

  configurePhase = ''
    true # Do not run ./configure, which is the default behaviour
  '';
}
