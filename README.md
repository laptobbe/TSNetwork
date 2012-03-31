#TSNetwork
TSNetwork is a simple block based callback network framework supporting both iOS and Mac. Please feel free to help and/or come with suggestions on what you need from a network framework!

The TSNetwork framework is provided under an MIT licence. 

##Overview

The framework is designed around the principle that you just want to get or send the data. Therefor it asumes a lot of things to make things simple, making it sutable for most apps but probobly not for everyone.  

To send a async request the framework uses NSURLConnection and adds the request to a single NSOperationQueue in the TSNetwork object. Multiple queues can be managed by creating additional TSNetwork instances.

To send a sync request the framework uses NSURLConnection using the send synchronous request method. The returning block is the same, making it easy to switch back and forth between Async and Sync as needed.



##Example

A simple async get request with all the standard values

	TSNetwork *http = [[TSNetwork alloc] init];
	NSURL *url = ...
	[http getURL:url] sendAsync:^(NSHTTPURLResponse *response, NSString *body, NSError *error) { 
		//Do something with the response
	}]; 

A simple async post with some data atteched to it

	TSNetwork *http = [[TSNetwork alloc] init];
	NSURL *url = ...
	NSData *data = ...
	[http postURL:url data:data] sendAsync:^(NSHTTPURLResponse *response, NSString *body, NSError *error) { 
		//Do something with the response
	}];

If you don't want to use the standard values of the request you can change them by nesting the method calls as follows.

	TSNetwork *http = [[TSNetwork alloc] init];
	NSURL *url = ...
	NSData *data = ...
	[[http postURL:url data:data] contentType:@"application/json"] sendAsync:^(NSHTTPURLResponse *response, NSString *body, NSError *error) { 
		//Do something with the response
	}];

Right now we support the following nested settings:

* Cache policy
* Timeout interval
* Content type
* Headers
* Network service type
* Should handle cookies
* Should use pipelining

if you would like to send the request synchronously you just have to change the name of the send method, here is an simple get send synchronously. Notice the diffrent method name sendSync instead of sendAsync.

	TSNetwork *http = [[TSNetwork alloc] init];
	NSURL *url = ...
	[http getURL:url] sendSync:^(NSHTTPURLResponse *response, NSString *body, NSError *error) { 
		//Do something with the response
	}];

