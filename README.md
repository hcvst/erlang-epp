.co.za EPP Client
=================

An Erlang Extensible Provisioning Protocol (EPP) client for the .co.za domain name registration system.
http://whois.co.za

I wrote the client for my site http://domain-name-registration.co.za. I haven't changed the site to use 
the client fully yet but I used it to get accredited (look for domain-name-registration.co.za at 
https://www.registry.net.za/accredited_registrars.php). 


BUILD
-----
`rebar compile`

RUN
---
`erl -pa ebin/ -s eepp`
