-module(epp).

-export([start/0]).

start() ->
    application:start(sasl),
    ssl:start(),
    application:start(epp).
