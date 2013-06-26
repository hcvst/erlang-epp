-module(epp_templates).
-behaviour(gen_server).
-define(SERVER, ?MODULE).
-include("epp.hrl").
-record(state, {templates}).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0, render/3]).

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

render(TemplateFileName, Record, SessionId) ->
    gen_server:call(?SERVER, {render, TemplateFileName, Record, 
        SessionId}).
%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init([]) ->
    TemplateDir = epp_config:get(template_dir),
    {ok, Filenames} = file:list_dir(TemplateDir),
    FileContents = fun(Filename) ->
        Path = filename:absname(Filename, TemplateDir), 
        {ok, Contents} = file:read_file(Path), 
        Contents
        end,
    Templates = dict:from_list([{Name, FileContents(Name)}
        || Name <- Filenames]),
    {ok, #state{templates=Templates}}.

handle_call({render, Name, Record, SessionId}, _From, State) ->
    Template = dict:fetch(Name, State#state.templates),
    Proplist = record_to_proplist(Record),
    Ctx = Proplist ++ [{sessionId, SessionId}],
    {ok, Rendered} = render_template(Template, Ctx),
    {reply, {ok, Rendered}, State}.

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

render_template(Template, []) -> 
    Rendered = binary_to_list(erlang:iolist_to_binary(Template)),
    {ok, Rendered};
render_template(Template, [{Name, Value}|Rest]) ->
    Pattern = io_lib:format("{{~s}}", [Name]),
    {ok, Re} = re:compile(Pattern),
    PartialRender = re:replace(Template, Re, Value),
    render_template(PartialRender, Rest).


%%% Record to proplist conversion
-define(R2P(Record), record_to_proplist(#Record{} = Rec) -> 
    lists:zip(record_info(fields, Record), tl(tuple_to_list(Rec)))).

?R2P(login);
?R2P(contact_create);
?R2P(contact_delete);
?R2P(contact_info);
?R2P(domain_check);
?R2P(logout).
