#TSNetwork
TSNetwork is a simple block based callback network framework supporting both iOS and Mac.

TSNetwork is provided under an MIT licence. 

##Overview

The purpose of the framework is to provide a simple way to send and recive data over the network with a blockbased callback. It is NOT designed to be a complete network solution for all situation. The framework has convinence methods for basic REST functions. It also assumes that you are using HTTP.

To send a async requests the framework uses NSURLConnection and adds the request to a single NSOperationQueue in the a TSNetwork object.

To send a sync requests the framework uses NSURLConnections send synchronous request method.

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

Right now the following nested settings are supported:

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

##Installation

To install TSNetwork you can either copy all the files in the directory named code into your project or you could follow the steps below to add it as a submodule.

1. Add TSNetwork as a git submodule or download the source to a know location
2. Drag the TSNetwork projectfile into your project, make sure that the TSNetwork project file is not open in xcode.
3. In you Build Phases of your target add a Target Dependency to the correct framework TSNetwork (iOS) or TSNetworkFramework (Mac)
4. Add a link to the correct libary under Link binary with libraries libTSNetwork.a(iOS) TSNetworkFramework.framework (Mac)
5. Make sure that the root of the TSNetwork project is in your header search path. This is done from build settings, setting the key Header Search Paths to the path of TSNetwork
6. Import TSNetwork.h where you want to use the framework

##Dependencies

TSNetwork has no external dependencies

##Credits

TSNetwork is brought to you by [Tobias Sundstrand](https://github.com/laptobbe)
