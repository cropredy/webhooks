/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
@IsTest class RestfulResponderTest {
    
    static testmethod void testBadEndpointHasMessages() {
        //arrange
        RestContext.Request = new RestRequest();
        RestContext.Request.HttpMethod = 'POST';
        RestContext.Request.RequestUri = '/webhook/responder/test';
        
        //act
        RestContext.Response = new RestResponse();
        RestfulResponder.handle();
        
        //assert
        String expectedResponse = 'No POST endpoint for path: /test';
        String actualResponse = RestContext.Response.ResponseBody.toString();
        System.assertEquals(expectedResponse, actualResponse, 'Wrong response.');
    }
    
    static testmethod void testGoodEndpointServesResponse() {
        //arrange
        insert new RestfulEndpoint__c(
            Name = 'Test',
            Path__c = '/test',
            HttpPost__c = true,
            Response__c = 'OK'
        );
        
        RestContext.Request = new RestRequest();
        RestContext.Request.HttpMethod = 'POST';
        RestContext.Request.RequestUri = '/webhook/responder/test';
        
        //act
        RestContext.Response = new RestResponse();
        RestfulResponder.handle();
        
        //assert
        String expectedResponse = 'OK';
        String actualResponse = RestContext.Response.ResponseBody.toString();
        System.assertEquals(expectedResponse, actualResponse, 'Wrong response.');
    }
    
    static testmethod void testEventParametersPopulated() {
        //arrange
        insert new RestfulEndpoint__c(
            Name = 'Test',
            HttpPost__c = true,
            Path__c = '/test'
        );
        
        RestContext.Request = new RestRequest();
        RestContext.Request.HttpMethod = 'POST';
        RestContext.Request.RequestUri = '/webhook/responder/test';
        RestContext.Request.RequestBody = Blob.valueOf('{"herp":"derp"}');
        
        //act
        RestContext.Response = new RestResponse();
        RestfulResponder.handle();
        
        //assert
        String expectedId = RestfulEndpoint__c.getValues('Test').Id;
        String actualId = (String)RestfulResponder.Event.get('ToConfig');
        System.assertEquals(expectedId, actualId, 'Wrong config id.');
        
        String expectedPath = '/test';
        String actualPath = (String)RestfulResponder.Event.get('webhook:Path');
        System.assertEquals(expectedPath, actualPath, 'Wrong path.');
        
        String expectedRequestBody = '{"herp":"derp"}';
        String actualRequestBody = ((Blob)RestfulResponder.Event.get('webhook:RequestBody')).toString();
        System.assertEquals(expectedRequestBody, actualRequestBody, 'Wrong request body.');
    }
    
}