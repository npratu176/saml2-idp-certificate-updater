#!/bin/bash
#Creates new self-signed cert and imports into AM JCEKS keystore
#04/05/17
#Simon.Moffatt@ForgeRock.Com

clear
JAVE_HOME="/usr/java/jdk1.8.0_102"

#Creates new key with 1 year validity
$JAVE_HOME/jre/bin/keytool -genkey -keyalg RSA -alias my-test-cert -keystore my-test-cert.jks -storepass password -validity 360 -keysize 2048

#Adds existing jks stored private key into the existing AM jcecks keystore so you can sign SAML2 assertions etc
$JAVE_HOME/jre/bin/keytool -importkeystore -srckeystore my-test-cert.jks -destkeystore ~/am5/openam/keystore.jceks -storetype jceks

