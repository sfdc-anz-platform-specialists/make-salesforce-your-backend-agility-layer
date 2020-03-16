sfdx force:org:create -f config/project-scratch-def.json -s -d 5 
sfdx force:source:push
sfdx force:user:permset:assign -n CustomerID
sfdx shane:user:password:set -l User -g User -p sfdx1234 --json
sfdx force:apex:execute -f scripts/CustomerIDSetup.cls
sfdx force:org:open
