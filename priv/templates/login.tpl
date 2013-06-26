<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
  <command>
    <login>
       <clID>{{username}}</clID>
	  <pw>{{password}}</pw>
	  <options>
		<version>1.0</version>
		<lang>en</lang>
	  </options>
	  <svcs>
		<objURI>urn:ietf:params:xml:ns:domain-1.0</objURI>
		<objURI>urn:ietf:params:xml:ns:contact-1.0</objURI>
	  </svcs>
    </login>
    <clTRID>{{sessionId}}</clTRID>
  </command>
</epp>
