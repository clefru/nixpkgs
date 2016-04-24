{ stdenv, fetchgit, nukeReferences, automake, autoconf, libtool, gettext, utillinux, openisns, openssl }:
let
  pname = "open-iscsi-2.0-873";
in stdenv.mkDerivation {
  name = "${pname}";
  outputs = [ "out" "iscsistart" ];

  buildInputs = [ nukeReferences automake autoconf libtool gettext utillinux openisns.lib openssl ];
  
  src = fetchgit {
    url = "https://github.com/open-iscsi/open-iscsi";
    rev = "4c1f2d90ef1c73e33d9f1e4ae9c206ffe015a8f9";
    sha256 = "09j4jap98zv4lb4xyzasz1jmf5dz52llnhrhmzypqdmd910b75ys";
  };
  
  DESTDIR = "$(out)";
  
  preConfigure = ''
    sed -i 's|/usr/|/|' Makefile
  '';
  
  postInstall = ''
    mkdir -pv $iscsistart/bin/
    cp -v usr/iscsistart $iscsistart/bin/
    nuke-refs $iscsistart/bin/iscsistart
  '';

  meta = {
    description = "A high performance, transport independent, multi-platform implementation of RFC3720";
    license = stdenv.lib.licenses.gpl2Plus;
    homepage = http://www.open-iscsi.com;
  };
}
