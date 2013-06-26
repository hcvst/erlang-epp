-module(epp).
-compile(export_all).
-export([start/0]).
-include("epp.hrl").

start() ->
    application:start(sasl),
    ssl:start(),
    application:start(epp).

login() ->
    Record = #login{
        username=epp_config:get(username),
        password=epp_config:get(password)
        },
    epp_server:command(login, Record).
    
logout() ->
    Record = #logout{},
    epp_server:command(logout, Record).

contact_create(Id, Name, Street, Suburb, City, Province, 
    Postcode, CountryCode, Voice, Fax, Email, Password) ->
    Record = #contact_create{
        id=Id,
        name=Name,
        street=Street,
        suburb=Suburb,
        city=City,
        province=Province,
        postcode=Postcode,
        countryCode=CountryCode,
        voice=Voice,
        fax=Fax,
        email=Email,
        password=Password
        },
    epp_server:command(contact_create, Record).

contact_delete(Id) ->
    Record = #contact_delete{id=Id},
    epp_server:command(contact_delete, Record).

contact_info(Id) ->
    Record = #contact_info{id=Id},
    epp_server:command(contact_info, Record).

domain_check(Name) ->
    Record = #domain_check{name=Name},
    epp_server:command(domain_check, Record).

domain_create_delegate(Name, Ns1, Ns2, 
    RegistrantId, Password) -> 
    Record = #domain_create_delegate{
        name=Name,
        ns1=Ns1,
        ns2=Ns2,
        registrantId=RegistrantId,
        password=Password},
    epp_server:command(domain_create_delegate, Record).

domain_create_subordinate(Name, Ns1, Ns1Ip, Ns2, Ns2Ip,
    RegistrantId, Password) ->
    Record = #domain_create_subordinate{
        name=Name,
        ns1=Ns1,
        ns1Ip=Ns1Ip,
        ns2=Ns2,
        ns2Ip=Ns2Ip,
        registrantId=RegistrantId,
        password=Password},
    epp_server:command(domain_create_subordinate,
        Record).

domain_info(Name) ->
    Record = #domain_info{name=Name},
    epp_server:command(domain_info, Record).

domain_add_status(Name, Status) ->
    % currently only clientHold supported by registry
    Record = #domain_add_status{
        name=Name,
        status=Status},
    epp_server:command(domain_add_status, Record).

domain_remove_status(Name, Status) ->
    Record = #domain_remove_status{
        name=Name,
        status=Status},
    epp_server:command(domain_remove_status, Record).

domain_change_registrant(Name, RegistrantId) ->
    Record = #domain_change_registrant{
        name=Name,
        registrantId=RegistrantId},
    epp_server:command(domain_change_registrant, Record).

domain_delete(Name) ->
    Record = #domain_delete{name=Name},
    epp_server:command(domain_delete, Record).

poll() ->
    epp_server:command(poll, #poll{}).

ack(MessageId) ->
    epp_server:command(ack, #ack{messageId=MessageId}).
