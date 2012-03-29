#TSNetwork
TSNetwork is a simple block based callback network framework, currently only for iOS but hopefully coming to Mac soon. Please feel free to help and come with suggestions on what you need!

The TSNetwork framework is provided under an MIT licence. 

##Overview

The framework is designed around the principle that you just want to get or send the data. Therefor it asumes a lot of things, making it sutable for most simple apps but not sutable for others.  

The framework uses NSURLConnection and adds the request to a single NSOperationQueue in the TSNetwork object. Right now only async requests are supported. Multiple queues can be created by creating additional TSNetwork instances.

##Example

A simple get request with all the standard values

	TSNetwork *http = [[TSNetwork alloc] init];
	NSURL *url = ...
	[http getURL:url] send:^(NSHTTPURLResponse *response, NSString *body, NSError *error) { 
		//Do something with the response
	}]; 

A simple post with some data atteched to it

	TSNetwork *http = [[TSNetwork alloc] init];
	NSURL *url = ...
	NSData *data = ...
	[http postURL:url data:data] send:^(NSHTTPURLResponse *response, NSString *body, NSError *error) { 
		//Do something with the response
	}];

If you don't want to use the standard values of the request you can change them by nesting the method calls as follows.

	TSNetwork *http = [[TSNetwork alloc] init];
	NSURL *url = ...
	NSData *data = ...
	[[http postURL:url data:data] contentType:@"application/json"] send:^(NSHTTPURLResponse *response, NSString *body, NSError *error) { 
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

##Coming
* Mac support
* Async and sync requests with the same callback method


