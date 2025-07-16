# Run the following PowerShell script to assign permissions to your managed identity 
# https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-grant-access#configure-a-managed-identity


Install-Module Microsoft.Graph -Scope CurrentUser  #install Graph PowerShell module if not already
#Login to your tenant
Connect-MgGraph -Scopes “Application.Read.All”,”AppRoleAssignment.ReadWrite.All,RoleManagement.ReadWrite.Directory”

$managedIdentityName = "CSV2SCIMBulkUpload"  #Name used to get the managed identity App ID
$managedIdentityObjectID = "9e9330da-65f3-49a5-83d3-6be319cdaaaf"  #Unique ObjectID for CSV2SCIMBulkUpload
# $managedID = Get-MgServicePrincipal -Filter "DisplayName eq '$($managedIdentityName)'"  #getting SP ObjectID via name can cause issues if there are duplicate names (can happen during testing)
# $managedIdentityObjectID = $managedID.Id  #only needed if not setting "managedIdentityObjectID" diectly 

$graphApp = Get-MgServicePrincipal -Filter "AppId eq '00000003-0000-0000-c000-000000000000'" #App ID for MS Graph

$PermissionName1 = "SynchronizationData-User.Upload"
$PermissionName2 = "AuditLog.Read.All"

$AppRole1 = $graphApp.AppRoles | Where-Object {$_.Value -eq $PermissionName1 -and $_.AllowedMemberTypes -contains "Application"}
$AppRole2 = $graphApp.AppRoles | Where-Object {$_.Value -eq $PermissionName2 -and $_.AllowedMemberTypes -contains "Application"}

New-MgServicePrincipalAppRoleAssignment -PrincipalId $managedIdentityObjectID -ServicePrincipalId $managedIdentityObjectID -ResourceId $graphApp.Id -AppRoleId $AppRole1.Id
New-MgServicePrincipalAppRoleAssignment -PrincipalId $managedIdentityObjectID -ServicePrincipalId $managedIdentityObjectID -ResourceId $graphApp.Id -AppRoleId $AppRole2.Id

<#   # To remove use this
Connect-MgGraph

# Get Service Principal using objectId
$sp = Get-MgServicePrincipal -ServicePrincipalId 9e9330da-65f3-49a5-83d3-6be319cdaaaf

# Get MS Graph App role assignments using objectId of the Service Principal
$assignments = Get-MgServicePrincipalAppRoleAssignedTo -ServicePrincipalId $sp.Id -All

# Remove all users and groups assigned to the application
$assignments | ForEach-Object {
    if ($_.PrincipalType -eq "User") {
        Remove-MgUserAppRoleAssignment -UserId $_.PrincipalId -AppRoleAssignmentId $_.Id
    } elseif ($_.PrincipalType -eq "Group") {
        Remove-MgGroupAppRoleAssignment -GroupId $_.PrincipalId -AppRoleAssignmentId $_.Id
    }
}
#>
