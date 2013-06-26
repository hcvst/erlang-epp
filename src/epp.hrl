-record(login, {username, password}).
-record(logout, {}).
-record(contact_create, {id, name, street, suburb="", city, province="", 
        postcode, countryCode, voice, fax="", email, password}).
-record(contact_delete, {id}).
-record(contact_info, {id}).
-record(domain_check ,{name}).
