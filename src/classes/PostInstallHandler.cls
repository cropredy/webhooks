/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
public without sharing class PostInstallHandler implements InstallHandler {
    
    class PostInstallException extends Exception {}
    
    /**
     * Assigns permissions to the Webhooks Site Guest User
     */
    public void onInstall(InstallContext context) {
        
        Site site;
        String namespacePrefix = PostInstallHandler.class.getName().substringBefore('PostInstallHandler').substringBefore('.');
        
        try {
            site = [
                SELECT GuestUserId
                FROM Site
                WHERE Name = 'Webhooks'
            ];
        } catch (QueryException e) {
            //failure when site is missing
            throw new PostInstallException('You must create a Force.com Site called "Webhooks"');
        }
        
        PermissionSet permissionSet = [
            SELECT Id
            FROM PermissionSet
            WHERE Name = 'Handle'
            AND NamespacePrefix = :namespacePrefix
        ];
        
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = site.GuestUserId,
            PermissionSetId = permissionSet.Id
        );
        
        //quietly, in case it exists
        Database.insert(psa, false);
    }
    
}