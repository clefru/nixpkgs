{ stdenv, openssl, fetchurl }:
let
  pname = "open-isns-0.95";
in stdenv.mkDerivation {
  name = "${pname}";

  src = fetchurl {
    url = "https://github.com/gonzoleeman/open-isns/archive/v0.95.tar.gz";
    sha256 = "0anv1jl2swfbird5gzxdhdxfxp9gza8w8lpc04lhnpklzngyh21m";
  };

  propagatedBuildInputs = [ openssl ];
  outputs = ["out" "lib" ];

  prefix = "/";

  installPhase = ''
    make install DESTDIR="$out"
    make install_hdrs DESTDIR="$lib"
    make install_lib DESTDIR="$lib"
  '';

  meta = {
    description = "iSNS server and client for Linux";
    license = stdenv.lib.licenses.lgpl21;
    homepage = https://github.com/gonzoleeman/open-isns;
  };
}
