<epp:epp xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:epp="urn:ietf:params:xml:ns:epp-1.0" 
xmlns:domain="urn:ietf:params:xml:ns:domain-1.0" xsi:schemaLocation="urn:ietf:params:xml:ns:epp-1.0 epp-1.0.xsd">
  <epp:command>
    <epp:info>
      <domain:info xsi:schemaLocation="urn:ietf:params:xml:ns:domain-1.0 domain-1.0.xsd">
        <domain:name hosts="all">{{name}}</domain:name>
      </domain:info>
    </epp:info>
    <epp:extension>
      <cozadomain:info xmlns:cozadomain="http://co.za/epp/extensions/cozadomain-1-0" xsi:schemaLocation="http://co.za/epp/extensions/cozadomain-1-0 coza-domain-1.0.xsd">
      </cozadomain:info>
    </epp:extension>
  </epp:command>
</epp:epp>
