<epp:epp xmlns:epp="urn:ietf:params:xml:ns:epp-1.0" xmlns:domain="urn:ietf:params:xml:ns:domain-1.0">
  <epp:command>
    <epp:renew>
      <domain:renew>
        <domain:name>{{name}}</domain:name>
        <domain:curExpDate>{{curExpDate}}</domain:curExpDate>
      </domain:renew>
    </epp:renew>
  </epp:command>
</epp:epp>