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
    
    static testmethod void testGeneratedUrls() {
        //arrange
        PageReference pr = new PageReference('/url');
        List<PageReference> pages = new List<PageReference>{pr};
        
        //act
        Site.UrlRewriter rewriter = new QueryStringUrlRewriter();
        List<PageReference> urls = rewriter.generateUrlFor(pages);
        
        //assert
        System.assertEquals(1, urls.size(), 'Wrong size.');
        System.assertEquals('/url', urls[0].getUrl(), 'Wrong url.');
    }
    
}