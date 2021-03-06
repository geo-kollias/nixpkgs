{ cabal, blazeBuilder, blazeBuilderConduit, caseInsensitive
, conduit, conduitExtra, doctest, hashable, hspec, HTTP, httpDate
, httpTypes, HUnit, liftedBase, network, networkConduit, QuickCheck
, simpleSendfile, streamingCommons, text, time, transformers
, unixCompat, void, wai
}:

cabal.mkDerivation (self: {
  pname = "warp";
  version = "2.1.3.3";
  sha256 = "1dbarrjb6y4cbc1dc265b008b6d5qziqnikdbnbdlrwfzr97cz23";
  buildDepends = [
    blazeBuilder blazeBuilderConduit caseInsensitive conduit
    conduitExtra hashable httpDate httpTypes liftedBase network
    networkConduit simpleSendfile streamingCommons text transformers
    unixCompat void wai
  ];
  testDepends = [
    blazeBuilder blazeBuilderConduit caseInsensitive conduit
    conduitExtra doctest hashable hspec HTTP httpDate httpTypes HUnit
    liftedBase network networkConduit QuickCheck simpleSendfile
    streamingCommons text time transformers unixCompat void wai
  ];
  doCheck = false;
  meta = {
    homepage = "http://github.com/yesodweb/wai";
    description = "A fast, light-weight web server for WAI applications";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
