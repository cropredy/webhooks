/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
public with sharing class QueryStringResponderController {
    
    @TestVisible QueryStringEndpoint__c Config;
    @TestVisible Map<String,Object> Event;
    
    /**
     * Locates the endpoint defined by any service instance or "step"
     * and dispatches an asynchronous event to the "config" as a destination
     */
    public void doHandle() {
        PageReference currentPage = ApexPages.currentPage();
        Map<String,String> parameters = currentPage.getParameters();
        String path = currentPage.getParameters().get('path');
        
        try {
            this.Config = [
                SELECT Id, Name, Response__c
                FROM QueryStringEndpoint__c
                WHERE Path__c = :path
            ];
        } catch (QueryException e) {
            this.Config = new QueryStringEndpoint__c(Response__c = 'No endpoint step for path: ' + path);
            ApexPages.addMessages(e);
            return;
        }
        
        this.Event = new Map<String,Object>();
        for (String key : parameters.keySet()) this.Event.put('webhook:' + key, parameters.get(key));
        this.Event.put('ToConfig', this.Config.Id);
        this.Event.put('webhook:Path', path);
        this.Event.put('webhook:Headers', currentPage.getHeaders());
        
        Process.Plugin job = (Process.Plugin)Type.forName('ServiceBus.Job').newInstance();
        job.invoke(new Process.PluginRequest(this.Event));
    }
    
    public String getResponse() {
        return this.Config.Response__c;
    }
    
}