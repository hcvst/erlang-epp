<epp:epp xmlns:epp="urn:ietf:params:xml:ns:epp-1.0" 
xmlns:domain="urn:ietf:params:xml:ns:domain-1.0">
  <epp:command>
    <epp:update>
      <domain:update>
        <domain:name>{{name}}</domain:name>
        <domain:rem>
          <domain:status s="{{status}}"/>
        </domain:rem>
      </domain:update>
    </epp:update>
  </epp:command>
</epp:epp>
