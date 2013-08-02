-module(checkepp_test).
-include_lib("eunit/include/eunit.hrl").

start_test() -> 
    epp:delme(), 
    ?assertEqual(1,1).
%stop_test() -> epp:stop().
%hans_test() -> ?assertEqual(1,1).