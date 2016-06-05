-module(eepp_server).
-behaviour(gen_server).
-define(SERVER, ?MODULE).
-define(HELLO_INTERVAL, 15000).
-record(state, {sessionId}).
-include("eepp.hrl").

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
    %% lets try exit on close erlang:send_after(?HELLO_INTERVAL, self(), hello),
    {ok, #state{sessionId=SessionId}}.

handle_call({command, Action, Record}, _From, State) ->
    {ok, XmlResponse} = send_command(Action, Record, 
        generate_session_id()), 
    {ok, Response} = eepp_response_parser:parse(Action, XmlResponse),   
    {reply, Response, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(hello, State) ->
    {ok, _} = send_command(hello, #hello{}, State#state.sessionId),
    erlang:send_after(?HELLO_INTERVAL, self(), hello),
    {noreply, State};
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

send_command(Action, Record, SessionId) ->
    TemplateName = template_for_action(Action),
    {ok, Request} = eepp_templates:render(TemplateName, Record,
        SessionId),
    eepp_transport:post(Request).

generate_session_id() ->
    io_lib:format("EPP-~w-~w-~w", tuple_to_list(os:timestamp())).

template_for_action(Action) ->
    lists:flatten(io_lib:format("~s.tpl", [Action])).
