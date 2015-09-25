/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
public without sharing class PostInstallHandler implements InstallHandler {
    
    /**
     * Assigns permissions to the Webhooks Site Guest User
     */
    public void onInstall(InstallContext context) {
        
        Site site = [
            SELECT GuestUserId
            FROM Site
            WHERE Name = 'Webhooks'
        ];
        
        PermissionSet permissionSet = [
            SELECT Id
            FROM PermissionSet
            WHERE Name = 'Handle'
        ];
        
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = site.GuestUserId,
            PermissionSetId = permissionSet.Id
        );
        
        //quietly, in case it exists
        Database.insert(psa, false);
    }
    
}