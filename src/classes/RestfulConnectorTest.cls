/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
@IsTest class RestfulConnectorTest {
    
    static testmethod void testPassThroughEvent() {
        //arrange
        Map<String,Object> inputEvent = new Map<String,Object>();
        
        //act
        RestfulConnector = new RestfulConnector();
        List<Map<String,Object>> outputevents = impl.execute(inputEvent);
        
        //assert
        Integer expectedSize = 1;
        Integer actualSize = outputEvents.size();
        System.assertEquals(expectedSize, actualSize, 'Wrong size.');
    }
    
    static testmethod void testVolumes() {
        //arrange
        RestfulConnector.Definition definition = new RestfulConnector.Definition();
        RestfulConnector impl = new RestfulConnector();
        Integer i = 0;
        
        //act
        for (i = 0; i < 200; i++) impl.execute(new Map<String,Object>());
        
        //assert
        System.assertEquals(200, i, 'Wrong limits.');
    }
    
    
}