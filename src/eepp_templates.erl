-module(eepp_templates).
-behaviour(gen_server).
-define(SERVER, ?MODULE).
-include("eepp.hrl").
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
    TemplateDir = eepp_config:get(template_dir),
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
    PartialRender = re:replace(Template, Re, Value, [global]),
    render_template(PartialRender, Rest).


%%% Record to proplist conversion
-define(R2P(Record), record_to_proplist(#Record{} = Rec) ->
    lists:zip(record_info(fields, Record), tl(tuple_to_list(Rec)))).

% Service Login/Logout
?R2P(login);
?R2P(logout);
% Contacts
?R2P(contact_create);
?R2P(contact_update);
?R2P(contact_delete);
?R2P(contact_info);
% Domains
?R2P(domain_check);
?R2P(domain_create_delegate);
?R2P(domain_create_subordinate);
?R2P(domain_info);
?R2P(domain_add_status);
?R2P(domain_remove_status);
?R2P(domain_change_registrant);
?R2P(domain_add_host_delegate);
?R2P(domain_add_host_subordinate);
?R2P(domain_remove_host);
?R2P(domain_delete);
?R2P(domain_renew);
?R2P(domain_autorenew);
?R2P(domain_transfer);
% Polling
?R2P(poll);
?R2P(ack);
% Hello - Keepalive
?R2P(hello).
