-record(login, {username, password}).
-record(logout, {}).
-record(contact_create, {id, name, street, suburb="", city, province="", 
        postcode, countryCode, voice, fax="", email, password}).
-record(contact_delete, {id}).
-record(contact_info, {id}).
-record(domain_check, {name}).
-record(domain_create_delegate, {name, ns1, ns2, registrantId, password}). 
-record(domain_create_subordinate, {name, ns1, ns1Ip, ns2, ns2Ip, 
        registrantId, password}).
-record(domain_info, {name}).
-record(domain_add_status, {name, status}).
-record(domain_remove_status, {name, status}).
-record(domain_change_registrant, {name, registrantId}).
-record(domain_delete, {name}).
-record(poll, {}).
-record(ack, {messageId}).
