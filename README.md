<b>saml2-idp-certificate-updater</b>
<br/>
<br/>
Scripted example utility to add a new certificate alias to an existing SAML2 IDP entity within ForgeRock Access Management 5.0, that use Amster.
<br/>
<br/>
<b>Running: </b>
<br/>
1 - clone/download, chmod +x on saml2-idp-certificate-updater.sh if necessary <br/>
2 - edit the global variables in the script for things like Amster home, keys location, AM instance URL etc <br/>
3 - run the script - ./saml2-idp-certiciate-updater.sh <br/>
<br/>
<b>Limitations</b><br/>
1 - only works on root realm - to use in sub realms edit the necessary paths <br/>
2 - there is assumption that the certificate alias already exists in the AM keystore.  If you want to create a self-signed certificate and import see ./test-cert-creator.sh <br/>
3 - the tool adds the alias as the first cert against the IDP entity config - this means future assertions will use this cert first. See https://backstage.forgerock.com/docs/am/5/saml2-guide#sec-saml2-hosted-idp-configuration for further details on certificate management<br/>
<br/>
<br/>
Use as-is.  Note this utility is a community contribution only and is not supported by ForgeRock.
<br/>


