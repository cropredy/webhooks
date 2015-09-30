/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
@RestResource(UrlMapping='/responder/*') global class RestfulResponder {
    
    @TestVisible static RestfulEndpoint__c Config;
    @TestVisible static Map<String,Object> Event;
    
    /**
     * Locates the endpoint defined by any service instance or "step"
     * and dispatches an asynchronous event to the "config" as a destination
     */
    @HttpGet @HttpPost @HttpPut @HttpPatch @HttpDelete static global void handle() {
        RestContext.Response.addHeader('Content-Type', 'text/plain');
        String path = RestContext.Request.RequestUri.substringAfter('/webhook/responder');
        String method = RestContext.Request.HttpMethod;

        try {
            Config = Database.query(''
                + 'SELECT Id, Name, Response__c '
                + 'FROM RestfulEndpoint__c '
                + 'WHERE Path__c = :path '
                + 'AND Http' + method + '__c = true '
            );
        } catch (QueryException e) {
            //failure, nothing to do
            RestContext.Response.StatusCode = 404;
            RestContext.Response.ResponseBody = Blob.valueOf('No ' + method + ' endpoint for path: ' + path);
            return;
        }
        
        //success, dynamic event enqueue
        Event = new Map<String,Object>();
        Event.put('ToConfig', Config.Id);
        Event.put('webhook:Path', path);
        Event.put('webhook:Headers', RestContext.Request.Headers);
        
        for (String key : RestContext.Request.Params.keySet()) {
            //avail request parameters with namespace prefix
            Event.put('webhook:' + key, RestContext.Request.Params.get(key));
        }
        
        Process.Plugin job = (Process.Plugin)Type.forName('ServiceBus.Job').newInstance();
        job.invoke(new Process.PluginRequest(Event));
        if (Config.Response__c != null) RestContext.Response.ResponseBody = Blob.valueOf(Config.Response__c);
    }
    
}