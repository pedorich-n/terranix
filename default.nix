{ stdenv, lib, jq, nix, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "terranix";
  version = "2.8.0";

  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/{bin,core,modules,lib}
    mv bin core modules lib share $out/

    wrapProgram $out/bin/terranix-doc-json \
      --prefix PATH : ${lib.makeBinPath [ jq nix ]}
  '';

  meta = with lib; {
    description = "A NixOS like terraform-json generator";
    homepage = "https://terranix.org";
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = with maintainers; [ mrVanDalo ];
  };
}
