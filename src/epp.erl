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
