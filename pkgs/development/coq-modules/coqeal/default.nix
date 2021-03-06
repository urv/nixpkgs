{stdenv, fetchgit, coq, ssreflect, mathcomp}:

stdenv.mkDerivation rec {

  name = "coq-coqeal-${coq.coq-version}-${version}";
  version = "7522037d";

  src = fetchgit {
    url = git://github.com/CoqEAL/CoqEAL.git;
    rev = "7522037d5e01e651e705d782f4f91fc68c46866e";
    sha256 = "1cvjz0yyqihdx1hp1h9x5x14kv9qf3rjhgqq4f7rv8bxcv9p1gv3";
  };

  buildInputs = [ coq.ocaml coq.camlp5 ssreflect mathcomp ];
  propagatedBuildInputs = [ coq ];

  preConfigure = "cd theory";

  installFlags = "COQLIB=$(out)/lib/coq/${coq.coq-version}/";

  meta = with stdenv.lib; {
    homepage = http://www.maximedenes.fr/content/coqeal-coq-effective-algebra-library;
    description = "A Coq library for effective algebra, by which is meant formally verified computer algebra algorithms that can be run inside Coq on concrete inputs";
    maintainers = with maintainers; [ jwiegley ];
    platforms = coq.meta.platforms;
  };

}
