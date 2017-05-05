#!/bin/bash
#SAML2 IDP certificate updater
#Updates an existing SAML2 IDP config with new signing certificate alias
#simon.moffatt@forgerock.com
#04/05/17

clear

#functions and variables below this line #######################################################################################################################################################

AM_URL="https://am5.theidentitycookbook.com:8443/openam"
AMSTER_HOME="/home/smof/amster-5.0"
AM_AMSTER_KEY="/home/smof/am5-aws-amster_rsa"

#reads existing config 
function read_idp_config() {

	echo "Reading existing SAML2 config from $AM_URL in realm $REALM ..."

	#create amster read file
	cat > read-idp.amster <<EOF	
connect "$AM_URL" -k "$AM_AMSTER_KEY"
export-config --realms '/' --realmEntities 'Saml2Entity' --path existing-saml2-config/ 
:exit

EOF
	$AMSTER_HOME/amster read-idp.amster
	echo "Done!"
	echo ""
}

#adds cert aliase to existing config 
function add_cert() {

	
	echo "Enter name of the new certificate alias followed by [Enter]: "
	read alias
	echo ""
	#use sed to add alias entry to existing config at first entry
	echo "Adding alias to exported configuration..."
	sed -i 's/\(<Attribute name=\\\"signingCertAlias\\">\)/\1<Value>'$alias'<\/Value>/' existing-saml2-config/realms/root/Saml2Entity/*.json
	echo "Done!"
	echo ""
}


#This creates an amster script and imports
function import_amster() {

	echo "Creating amster import script..."
	filename=$(ls existing-saml2-config/realms/root/Saml2Entity/)

	#Create amster script
	cat > update-idp.amster <<EOF	
connect "$AM_URL" -k "$AM_AMSTER_KEY"
import-config --path existing-saml2-config/realms/root/Saml2Entity/$filename
:exit

EOF
	echo "Done!"
	echo ""
	echo "Importing into $AM_URL ..."
	echo ""
	$AMSTER_HOME/amster update-idp.amster
	echo "Done!"

}

#functions and variables above this line #######################################################################################################################################################

#Run through
read_idp_config
add_cert
import_amster
