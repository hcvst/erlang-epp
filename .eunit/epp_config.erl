-module(epp_config).
-behaviour(gen_server).
-define(SERVER, ?MODULE).
-define(CONFIG_FILE, "epp.conf").
-record(state, {config}).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0, get/1]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

get(Key) ->
    gen_server:call(?SERVER, {get, Key}).
%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init([]) ->
    {ok, Terms} = file:consult(?CONFIG_FILE),
    Config = dict:from_list(Terms),
    {ok, #state{config=Config}}.

handle_call({get, Key}, _From, State) ->
    Value = dict:fetch(Key, State#state.config),
    {reply, Value, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

