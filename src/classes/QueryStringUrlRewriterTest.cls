/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
@IsTest class QueryStringUrlRewriterTest {
    
    static testmethod void testAllRequestsMappedToEndpoint() {
        //arrange
        PageReference request = new PageReference('/path/to/endpoint');
        
        //act
        Site.UrlRewriter rewriter = new QueryStringUrlRewriter();
        PageReference response = rewriter.mapRequestUrl(request);
        
        //assert
        String expectedUrl = Page.QueryStringResponder.getUrl() + '?path=%2Fpath%2Fto%2Fendpoint';
        String actualUrl = response.getUrl();
        System.assertEquals(expectedUrl, actualUrl, 'Wrong url.');
    }
    
}