% Request records

-record(login, {username, password}).
-record(logout, {}).
-record(contact_create, {id, type="loc", name, street, suburb="", city, province="", 
        postcode, countryCode, voice, fax="", email, password}).
-record(contact_update, {id, type="int", name, street, suburb="", city, province="", 
        postcode, countryCode, voice, fax="", email, password}).
-record(contact_delete, {id}).
-record(contact_info, {id, includeDomainListing, includeBalance}).
-record(domain_check, {name}).
-record(domain_create_delegate, {name, ns1, ns2, registrantId, password, autorenew}). 
-record(domain_create_subordinate, {name, ns1, ns1Ip, ns2, ns2Ip, 
        registrantId, password, autorenew}).
-record(domain_info, {name}).
-record(domain_add_status, {name, status}).
-record(domain_remove_status, {name, status}).
-record(domain_change_registrant, {name, registrantId}).
-record(domain_add_host_delegate, {name, ns}).
-record(domain_add_host_subordinate, {name, ns, nsIp}).
-record(domain_remove_host, {name, ns}).
-record(domain_delete, {name}).
-record(domain_renew, {name, curExpDate}).
-record(domain_autorenew, {name, autorenew="false"}).
-record(domain_transfer, {name, operation}).
-record(poll, {}).
-record(ack, {messageId}).
-record(hello, {}).
