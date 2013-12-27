<epp:epp xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:epp="urn:ietf:params:xml:ns:epp-1.0" 
xmlns:contact="urn:ietf:params:xml:ns:contact-1.0" xsi:schemaLocation="urn:ietf:params:xml:ns:epp-1.0 epp-1.0.xsd">
  <epp:command>
    <epp:create>
      <contact:create xsi:schemaLocation="urn:ietf:params:xml:ns:contact-1.0 contact-1.0.xsd">
        <contact:id>{{id}}</contact:id>
        <contact:postalInfo type="{{type}}">
          <contact:name>{{name}}</contact:name>
          <contact:addr>
            <contact:street>{{street}}</contact:street>
            <contact:street>{{suburb}}</contact:street>
            <contact:city>{{city}}</contact:city>
            <contact:sp>{{province}}</contact:sp>
            <contact:pc>{{postcode}}</contact:pc>
            <contact:cc>{{countryCode}}</contact:cc>
          </contact:addr>
        </contact:postalInfo>
        <contact:voice>{{voice}}</contact:voice>
        <contact:fax>{{fax}}</contact:fax>
        <contact:email>{{email}}</contact:email>
        <contact:authInfo>
          <contact:pw>{{password}}</contact:pw>
        </contact:authInfo>
      </contact:create>
    </epp:create>
  </epp:command>
</epp:epp>
