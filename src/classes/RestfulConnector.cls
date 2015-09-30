/**
 * Webhooks
 * @see https://github.com/bigassforce/webhooks
 * @author <webmaster@bigass.engineering>
 */
global class RestfulConnector extends Abstract.Service {
    
    global class Summary extends Abstract.Service.Summary {
        
        //groups services together
        String Tag = 'Webhooks';
        
        //user friendly name
        String Label = 'Restful Webhook';
        
        //silk library icon displayed on each step
        String Icon = 'lightning';
        
        //user friendly explanation of what this service does
        String Description = 'Handles HTTP method with raw body and spawns event.';
        
        //handles this many events in one execution context
        Integer Limits = 200;
        
        //indicates ratio of output to input events
        String Cardinality = 'One';
        
        //custom object API name used for step specific configuration
        String StepConfig = RestfulEndpoint__c.class.getName();
        
        //friendly description of the input event parameters
        Map<String,String> Inputs = new Map<String,String>{};
        
        //friendly descriptions of the output event parameters
        Map<String,String> Outputs = new Map<String,String>{
            'webhook:Path' => 'STRING of the webhook path.',
            'webhook:Headers' => 'MAP of HTTP headers on the request.'
        };
    }
    
    /**
     * This is a connector service that emits an event for each
     * HTTP request. Later steps perform processing on the event.
     */
    override public List<Map<String,Object>> execute(Map<String,Object> inputEvent) {
        
        //pass-through service
        return new List<Map<String,Object>>{inputEvent};
        
    }
    
}