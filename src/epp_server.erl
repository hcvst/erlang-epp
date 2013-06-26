-module(epp_server).
-behaviour(gen_server).
-define(SERVER, ?MODULE).
-record(state, {sessionId}).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0, command/2]).

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

command(Action, Record) ->
    gen_server:call(?SERVER, {command, Action, Record}).
%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init([]) ->
    SessionId = generate_session_id(),
    {ok, #state{sessionId=SessionId}}.

handle_call({command, Action, Record}, _From, State) ->
    TemplateName = template_for_action(Action), 
    {ok, Request} = epp_templates:render(TemplateName, Record,
        State#state.sessionId),
    {ok, Response} = epp_transport:post(Request),    
    {reply, Response, State}.

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

generate_session_id() ->
    io_lib:format("EPP-~w-~w-~w", tuple_to_list(os:timestamp())).

template_for_action(Action) ->
    lists:flatten(io_lib:format("~s.tpl", [Action])).
