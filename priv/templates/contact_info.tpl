<epp:epp xmlns:epp="urn:ietf:params:xml:ns:epp-1.0" 
xmlns:contact="urn:ietf:params:xml:ns:contact-1.0" 
xmlns:cozacontact="http://co.za/epp/extensions/cozacontact-1-0">
  <epp:command>
    <epp:info>
      <contact:info>
        <contact:id>{{id}}</contact:id>
      </contact:info>
    </epp:info>
    <epp:extension>
      <cozacontact:info>
        <cozacontact:domainListing>{{includeDomainListing}}</cozacontact:domainListing>
        <cozacontact:balance>{{includeBalance}}</cozacontact:balance>
      </cozacontact:info>
    </epp:extension>
  </epp:command>
</epp:epp>
