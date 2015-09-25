/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
public class QueryStringUrlRewriter implements Site.UrlRewriter {
    
    /**
     * Maps all inbound request paths to the responder
     */
    public PageReference mapRequestUrl(PageReference request) {
        PageReference response = Page.QueryStringResponder;
        response.getParameters().put('path', request.getUrl().substringBefore('?'));
        return response;
    }
    
    public List<PageReference> generateUrlFor(List<PageReference> pages) {
        List<PageReference> urls = new List<PageReference>();
        for (PageReference pr : pages) urls.add(new PageReference(pr.getUrl()));
        return urls;
    }
    
}