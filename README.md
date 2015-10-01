# Webhooks for the rest of us

This is a salesforce connector that uses the [Apex Microservices Open Specification (AMOS)](https://github.com/bigassforce/amos), particularly:
- the [Service Summary](https://github.com/bigassforce/webhooks/blob/master/src/classes/RestfulConnector.cls#L8-L39) inner class
- package agnostic [event parameters](https://github.com/bigassforce/webhooks/blob/master/src/classes/RestfulResponder.cls#L34-L43)
- instance configuration via [custom setting](https://github.com/bigassforce/webhooks/blob/master/src/objects/RestfulEndpoint__c.object)

#### What is the "webhook" pattern?

Instead of you polling another system for data... _they_ knock on the door of _your_ system.

- [Reasons webhooks are magic (iron.io)](http://www.iron.io/blog/2013/09/7-reasons-webhooks-are-magic.html)
- [Webhook API example (github.com)](https://developer.github.com/webhooks/)

#### What this isn't:

We're not just standing up an Apex webservice class or a REST annotated method. A webhook shouldn't be concerned with performing any action. It should merely eat the notification so the transmitter can "fire and forget."

![webhook1](https://cloud.githubusercontent.com/assets/1878631/10134772/3856b2dc-65e0-11e5-93ea-a8623bb32b5e.png)

#### What it does do:

It separates the three concerns: the synchronous responder that says "got it!"; the event that is persisted; another service performs some action _while having no knowledge of the webhook transport_.

![webhook2](https://cloud.githubusercontent.com/assets/1878631/10134773/3a10a600-65e0-11e5-9150-4ad48a1187bf.png)

#### Why not just hard code the webhook action?

Rolling that Apex webhook probably won't be the first or the last one we ever build. We separate the event from the action by using AMOS with a service container. And the action gets free transaction management, free error handling, and context independence. Code less like the left, and more like the right:

![webhook3_4](https://cloud.githubusercontent.com/assets/1878631/10217469/c80f17d6-6827-11e5-8421-fcb0ce915e58.png)

#### How to arrange the services?

- First is your webhook
- Second is your action (using [AMOS](https://github.com/bigassforce/amos))

![webhook5-crop](https://cloud.githubusercontent.com/assets/1878631/10217929/f7a5b98e-682a-11e5-88aa-9d669962e447.png)

#### How to configure different endpoints?

On any service instance, click Configure to expose:

- URL path
- HTTP verbs
- Custom response

![webhook6-crop](https://cloud.githubusercontent.com/assets/1878631/10217930/f962caa0-682a-11e5-9054-8c2dbefd4f1c.png)

#### Video walkthrough:

[![video-frame](https://cloud.githubusercontent.com/assets/1878631/10218330/f2e0618a-682d-11e5-8acb-03eab5770b4e.png)](https://vimeo.com/141029160)
