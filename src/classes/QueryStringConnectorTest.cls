/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
@IsTest class QueryStringConnectorTest {
    
    static testmethod void testPassThroughEvent() {
        //arrange
        Map<String,Object> inputEvent = new Map<String,Object>();
        
        //act
        Abstract.Service impl = new QueryStringConnector();
        List<Map<String,Object>> outputevents = impl.handle(inputEvent);
        
        //assert
        Integer expectedSize = 1;
        Integer actualSize = outputEvents.size();
        System.assertEquals(expectedSize, actualSize, 'Wrong size.');
    }
    
}