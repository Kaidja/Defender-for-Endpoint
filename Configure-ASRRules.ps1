#Attack Surface Reduction Rules JSON File
$URL = "https://raw.githubusercontent.com/Kaidja/Defender-for-Endpoint/main/AttackSurfaceReductionRules.json"
#Convert ASR Rules from JSON
$ASRRules = (Invoke-WebRequest -Uri $URL -UseBasicParsing).Content | ConvertFrom-Json
foreach($Rule in $ASRRules){

    $ASRRuleName = $Rule.Name
    $ASRRuleGUID = $Rule.GUID

    Write-Output -InputObject "Working on $ASRRuleName. Setting the rule to Audit Mode"
    Add-MpPreference -AttackSurfaceReductionRules_Ids $Rule.GUID -AttackSurfaceReductionRules_Actions AuditMode

}
