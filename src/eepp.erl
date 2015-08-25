-module(eepp).
-compile(export_all).
%-export([start/0, delme/0]).
-include("eepp.hrl").


start() ->
    application:start(sasl),
    ssl:start(),
    application:start(eepp).

stop() ->
    application:stop(eepp).

login() ->
    Record = #login{
        username=eepp_config:get(username),
        password=eepp_config:get(password)
        },
    eepp_server:command(login, Record).

logout() ->
    Record = #logout{},
    eepp_server:command(logout, Record).

contact_create(Id, Type, Name, Street, Suburb, City, Province,
    Postcode, CountryCode, Voice, Fax, Email, Password) ->
    Record = #contact_create{
        id=Id,
        type=Type, % "loc" or "int"
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
    eepp_server:command(contact_create, Record).

contact_update(Id, Type, Name, Street, Suburb, City, Province,
    Postcode, CountryCode, Voice, Fax, Email, Password) ->
    Record = #contact_update{
        id=Id,
        type=Type, % "loc" or "int"
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
    eepp_server:command(contact_update, Record).

contact_delete(Id) ->
    Record = #contact_delete{id=Id},
    eepp_server:command(contact_delete, Record).

contact_info(Id) ->
    contact_info(Id, false, false).

contact_info(Id, IncludeDomainListing, IncludeBalance)
    when is_boolean(IncludeDomainListing)
    and is_boolean(IncludeBalance) ->
    Record = #contact_info{
        id=Id,
        includeDomainListing=atom_to_list(IncludeDomainListing),
        includeBalance=atom_to_list(IncludeBalance)},
    eepp_server:command(contact_info, Record).

domain_check(Name) ->
    Record = #domain_check{name=Name},
    eepp_server:command(domain_check, Record).

domain_create_delegate(Name, Ns1, Ns2,
    RegistrantId, Password, Autorenew) when is_boolean(Autorenew)->
    Record = #domain_create_delegate{
        name=Name,
        ns1=Ns1,
        ns2=Ns2,
        registrantId=RegistrantId,
        password=Password,
        autorenew=atom_to_list(Autorenew)},
    eepp_server:command(domain_create_delegate, Record).

domain_create_subordinate(Name, Ns1, Ns1Ip, Ns2, Ns2Ip,
    RegistrantId, Password, Autorenew) when is_boolean(Autorenew) ->
    Record = #domain_create_subordinate{
        name=Name,
        ns1=Ns1,
        ns1Ip=Ns1Ip,
        ns2=Ns2,
        ns2Ip=Ns2Ip,
        registrantId=RegistrantId,
        password=Password,
        autorenew=atom_to_list(Autorenew)},
    eepp_server:command(domain_create_subordinate,
        Record).

domain_info(Name) ->
    Record = #domain_info{name=Name},
    eepp_server:command(domain_info, Record).

domain_add_status(Name, Status) ->
    % currently only clientHold supported by registry
    Record = #domain_add_status{
        name=Name,
        status=Status},
    eepp_server:command(domain_add_status, Record).

domain_remove_status(Name, Status) ->
    Record = #domain_remove_status{
        name=Name,
        status=Status},
    eepp_server:command(domain_remove_status, Record).

domain_change_registrant(Name, RegistrantId) ->
    Record = #domain_change_registrant{
        name=Name,
        registrantId=RegistrantId},
    eepp_server:command(domain_change_registrant, Record).


domain_add_host_delegate(Name, Ns) ->
    Record = #domain_add_host_delegate{
        name=Name,
        ns=Ns
    },
    eepp_server:command(domain_add_host_delegate, Record).

domain_add_host_subordinate(Name, Ns, NsIp) ->
    Record = #domain_add_host_subordinate{
        name=Name,
        ns=Ns,
        nsIp=NsIp
    },
    eepp_server:command(domain_add_host_subordinate, Record).

domain_remove_host(Name, Ns) ->
    Record = #domain_remove_host{
        name=Name,
        ns=Ns
    },
    eepp_server:command(domain_remove_host, Record).

domain_delete(Name) ->
    Record = #domain_delete{name=Name},
    eepp_server:command(domain_delete, Record).

domain_renew(Name, CurExpDate) ->
    Record = #domain_renew{name=Name, curExpDate=CurExpDate},
    eepp_server:command(domain_renew, Record).

domain_autorenew(Name, Autorenew) when is_boolean(Autorenew) ->
    Record = #domain_autorenew{name=Name, autorenew=atom_to_list(Autorenew)},
    eepp_server:command(domain_autorenew, Record).

domain_transfer_request(Name) ->
    Record = #domain_transfer{name=Name, operation="request"},
    eepp_server:command(domain_transfer, Record).

domain_transfer_cancel(Name) ->
    Record = #domain_transfer{name=Name, operation="cancel"},
    eepp_server:command(domain_transfer, Record).

domain_transfer_query(Name) ->
    Record = #domain_transfer{name=Name, operation="query"},
    eepp_server:command(domain_transfer, Record).

domain_transfer_approve(Name) ->
    Record = #domain_transfer{name=Name, operation="approve"},
    eepp_server:command(domain_transfer, Record).

domain_transfer_reject(Name) ->
    Record = #domain_transfer{name=Name, operation="reject"},
    eepp_server:command(domain_transfer, Record).

poll() ->
    eepp_server:command(poll, #poll{}).

ack(MessageId) ->
    eepp_server:command(ack, #ack{messageId=MessageId}).
