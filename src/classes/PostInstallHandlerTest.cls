/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
@IsTest class PostInstallHandlerTest {
    
    static testmethod void testPermissionSetGetsAssigned() {
        //act
        InstallHandler handler = new PostInstallHandler();
        handler.onInstall(null);
        
        //arrange
        Integer expectedCount = 1;
        Integer actualCount = [SELECT COUNT() FROM PermissionSetAssignment WHERE PermissionSet.Name = 'Handle'];
        System.assertEquals(expectedCount, actualCount, 'Wrong count.');
    }
    
}