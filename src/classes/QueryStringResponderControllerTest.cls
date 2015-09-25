/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
@IsTest class QueryStringResponderControllerTest {
    
    static testmethod void testBadEndpointHasMessages() {
        //arrange
        PageReference currentPage = Page.QueryStringResponder;
        currentPage.getParameters().put('path', '/test');
        
        //act
        Test.setCurrentPage(currentPage);
        QueryStringResponderController controller = new QueryStringResponderController();
        controller.doHandle();
        
        //assert
        System.assert(ApexPages.hasMessages());
        String expectedResponse = 'No endpoint step for path: /test';
        String actualResponse = controller.getResponse();
        System.assertEquals(expectedResponse, actualResponse, 'Wrong response.');
    }
    
    static testmethod void testGoodEndpointServesResponse() {
        //arrange
        insert new QueryStringEndpoint__c(
            Name = 'Test',
            Path__c = '/test',
            Response__c = 'OK'
        );
        
        PageReference currentPage = Page.QueryStringResponder;
        currentPage.getParameters().put('path', '/test');
        
        //act
        Test.setCurrentPage(currentPage);
        QueryStringResponderController controller = new QueryStringResponderController();
        controller.doHandle();
        
        //assert
        String expectedResponse = 'OK';
        String actualResponse = controller.getResponse();
        System.assertEquals(expectedResponse, actualResponse, 'Wrong response.');
    }
    
    static testmethod void testEventParametersPopulated() {
        //arrange
        insert new QueryStringEndpoint__c(
            Name = 'Test',
            Path__c = '/test'
        );
        
        PageReference currentPage = Page.QueryStringResponder;
        currentPage.getParameters().put('path', '/test');
        
        //act
        Test.setCurrentPage(currentPage);
        QueryStringResponderController controller = new QueryStringResponderController();
        controller.doHandle();
        
        //assert
        String expectedId = QueryStringEndpoint__c.getValues('Test').Id;
        String actualId = (String)controller.Event.get('ToConfig');
        System.assertEquals(expectedId, actualId, 'Wrong config id.');
        
        String expectedPath = '/test';
        String actualPath = (String)controller.Event.get('webhook:Path');
        System.assertEquals(expectedPath, actualPath, 'Wrong path.');
    }
    
}