<epp:epp xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
  xmlns:epp="urn:ietf:params:xml:ns:epp-1.0" 
  xmlns:domain="urn:ietf:params:xml:ns:domain-1.0" 
  xmlns:cozadomain="http://co.za/epp/extensions/cozadomain-1-0" 
  xsi:schemaLocation="urn:ietf:params:xml:ns:epp-1.0 epp-1.0.xsd">
  <epp:command>
    <epp:update>
      <domain:update xsi:schemaLocation="urn:ietf:params:xml:ns:domain-1.0 domain-1.0.xsd">
        <domain:name>{{name}}</domain:name>
      </domain:update>
    </epp:update>
    <epp:extension>
      <cozadomain:update 
        xsi:schemaLocation="http://co.za/epp/extensions/cozadomain-1-0 coza-domain-1.0.xsd">
        <cozadomain:chg>
          <cozadomain:autorenew>{{autorenew}}</cozadomain:autorenew>
        </cozadomain:chg>
      </cozadomain:update>
    </epp:extension>
  </epp:command>
</epp:epp>