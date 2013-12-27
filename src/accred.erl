-module(accred).
-export([go/0, clearQueue/0]).
-include_lib("xmerl/include/xmerl.hrl").



go() ->
    io:format("Accreditation"),
    
    io:format("***** start"),
    epp:start(),

    io:format("***** login"),
    epp:login(),

    %io:format("***** Clear Poll Queue"),
    %clearQueue(),

    io:format("***** contact_create"),
    epp:contact_create("DNR2-0001", "loc", "TestName", "TestStreet", "TestSuburb", "TestCity", "TestProvince", 
    "TestPostcode", "ZA", "+27.123", "+49.999", "hc+dnr006@vst.io", "TestPassword"),


    epp:contact_update("DNR-0006", "int", "TestNameUpdatedInt", "TestStreet", "TestSuburb", "TestCity", "TestProvince", 
    "TestPostcode", "ZA", "+27.123", "+49.999", "hc+dnr006@vst.io", "TestPassword"),

    io:format("***** contact_create"),
    epp:contact_create("DNR-0007", "TestName", "TestStreet", "TestSuburb", "TestCity", "TestProvince", 
    "TestPostcode", "ZA", "+27.123", "+49.999", "hc+dnr007@vst.io", "TestPassword"),

    io:format("***** contact_info"),
    epp:contact_info("DNR-0001"),

    io:format("***** domain_check"),
    epp:domain_check("dnrtest0001.test.dnservices.co.za"),

    io:format("***** domain_create_delegate"),
    epp:domain_create_delegate("dnrtest1111.test.dnservices.co.za", "ns-1659.awsdns-15.co.uk", "ns-938.awsdns-53.net", "DNR-0006", "coza"),

    io:format("***** domain_check"),
    epp:domain_check("dnrtest0001.test.dnservices.co.za"),

    io:format("***** domain_check"),
    epp:domain_check("dnrtest0002.test.dnservices.co.za"),

    io:format("***** domain_create_subordinate"),
    epp:domain_create_subordinate("dnrtest0007.test.dnservices.co.za", 
        "ns1.dnrtest0007.test.dnservices.co.za", "79.125.12.109", 
    	"ns2.dnrtest0007.test.dnservices.co.za", "79.125.107.174", 
        "DNR-0007", "coza"),

    io:format("***** domain_info"),
    epp:domain_info("dnrtest0001.test.dnservices.co.za"),

    io:format("***** domain_renew"),
    epp:domain_renew("dnrtest0001.test.dnservices.co.za", "2014-07-14"),

    io:format("***** domain_change_registrant"),
    epp:domain_change_registrant("dnrtest1111.test.dnservices.co.za", "DNR-0002"),

    io:format("***** domain_add_status"),
    epp:domain_add_status("dnrtest0001.test.dnservices.co.za", "clientHold"),

    io:format("***** domain_change_registrant"),
    epp:domain_change_registrant("dnrtest0001.test.dnservices.co.za", "DNR-0002"),

    io:format("***** domain_delete"),
    epp:domain_delete("dnrtest0001.test.dnservices.co.za"),

    io:format("***** domain_delete"),
    epp:domain_delete("dnrtest0002.test.dnservices.co.za"),

    io:format("***** domain_remove_status"),
    epp:domain_remove_status("dnrtest0001.test.dnservices.co.za", "clientHold"),

    io:format("***** domain_change_registrant"),
    epp:domain_change_registrant("dnrtest0001.test.dnservices.co.za", "DNR-0002"),

    io:format("***** domain_delete"),
    epp:domain_delete("dnrtest0001.test.dnservices.co.za"),

    io:format("***** domain_delete"),
    epp:domain_delete("dnrtest0002.test.dnservices.co.za"),

    io:format("***** poll"),
    epp:poll(),

    io:format("***** ack"),
    epp:ack("123435"),

    io:format("***** contact_delete"),
    epp:contact_delete("DNR-0001"),

    io:format("***** contact_delete"),
    epp:contact_delete("DNR-0002"),

    io:format("***** logout"),
    epp:logout(),

    io:format("***** stop"),
    epp:stop().

clearQueue() -> % Note 1300 No Messages, 1301 Messages
    Response = epp:poll(),
    {Parsed, _Misc} = xmerl_scan:string(binary_to_list(Response)),
    [#xmlAttribute{value=Count}] = xmerl_xpath:string("//epp:msgQ/@count", Parsed),
    case string:to_integer(Count) of
        {X, _} when X > 0 -> 
            io:format("Count: ~p~n", [Count]), 
            [#xmlAttribute{value=Id}] = xmerl_xpath:string("//epp:msgQ/@id", Parsed),
            epp:ack(Id),
            clearQueue();
        _ -> io:format("Queue cleared")
    end.


