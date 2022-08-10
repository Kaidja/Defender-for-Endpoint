#You need to import the Configuration Manager PowerShell module before you can create the Queries and Collections

#Queries
$AzureConnectedMachineAgent = 'select SMS_R_System.Name, SMS_G_System_ADD_REMOVE_PROGRAMS_64.DisplayName, SMS_G_System_ADD_REMOVE_PROGRAMS_64.Version from  SMS_R_System inner join SMS_G_System_ADD_REMOVE_PROGRAMS_64 on SMS_G_System_ADD_REMOVE_PROGRAMS_64.ResourceId = SMS_R_System.ResourceId where SMS_G_System_ADD_REMOVE_PROGRAMS_64.DisplayName = "Azure Connected Machine Agent"'
$MicrosoftDefenderforEndpoint = 'select SMS_R_System.Name, SMS_G_System_ADD_REMOVE_PROGRAMS_64.DisplayName, SMS_G_System_ADD_REMOVE_PROGRAMS_64.Version from  SMS_R_System inner join SMS_G_System_ADD_REMOVE_PROGRAMS_64 on SMS_G_System_ADD_REMOVE_PROGRAMS_64.ResourceID = SMS_R_System.ResourceId where SMS_G_System_ADD_REMOVE_PROGRAMS_64.DisplayName = "Microsoft Defender for Endpoint"'
$MicrosoftMonitoringAgent = 'select SMS_R_System.Name, SMS_G_System_ADD_REMOVE_PROGRAMS_64.Version, SMS_G_System_ADD_REMOVE_PROGRAMS_64.DisplayName from  SMS_R_System inner join SMS_G_System_ADD_REMOVE_PROGRAMS_64 on SMS_G_System_ADD_REMOVE_PROGRAMS_64.ResourceID = SMS_R_System.ResourceId where SMS_G_System_ADD_REMOVE_PROGRAMS_64.DisplayName = "Microsoft Monitoring Agent"'
$SystemCenterEndpointProtection = 'select SMS_R_System.Name, SMS_G_System_ADD_REMOVE_PROGRAMS_64.DisplayName, SMS_G_System_ADD_REMOVE_PROGRAMS_64.Version from  SMS_R_System inner join SMS_G_System_ADD_REMOVE_PROGRAMS_64 on SMS_G_System_ADD_REMOVE_PROGRAMS_64.ResourceId = SMS_R_System.ResourceId where SMS_G_System_ADD_REMOVE_PROGRAMS_64.DisplayName = "System Center Endpoint Protection"'

New-CMQuery -Name "Azure Connected Machine Agent" -Expression $AzureConnectedMachineAgent -TargetClassName "SMS_R_System"
New-CMQuery -Name "Microsoft Defender for Endpoint" -Expression $MicrosoftDefenderforEndpoint -TargetClassName "SMS_R_System"
New-CMQuery -Name "Microsoft Monitoring Agent" -Expression $MicrosoftMonitoringAgent -TargetClassName "SMS_R_System"
New-CMQuery -Name "System Center Endpoint Protection" -Expression $SystemCenterEndpointProtection -TargetClassName "SMS_R_System"

#Device Collections
$LimitingCollectionName = "All Systems"
New-CMCollection -Name "Azure Connected Machine Agent" -LimitingCollectionName $LimitingCollectionName -CollectionType Device
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Azure Connected Machine Agent" -QueryExpression $AzureConnectedMachineAgent -RuleName "AzureConnectedMachineAgent"

New-CMCollection -Name "Microsoft Defender for Endpoint" -LimitingCollectionName $LimitingCollectionName -CollectionType Device
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Microsoft Defender for Endpoint" -QueryExpression $MicrosoftDefenderforEndpoint -RuleName "MicrosoftDefenderforEndpoint"

New-CMCollection -Name "Microsoft Monitoring Agent" -LimitingCollectionName $LimitingCollectionName -CollectionType Device
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Microsoft Monitoring Agent" -QueryExpression $MicrosoftMonitoringAgent -RuleName "MicrosoftMonitoringAgent"

New-CMCollection -Name "System Center Endpoint Protection" -LimitingCollectionName $LimitingCollectionName -CollectionType Device
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "System Center Endpoint Protection" -QueryExpression $SystemCenterEndpointProtection -RuleName "SystemCenterEndpointProtection"
