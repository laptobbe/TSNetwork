//
//  TSNetworkTests.m
//  TSNetworkTests
//
//  Created by Tobias Sundstrand on 2012-02-25.

//  The software is provided under the MIT licence
//  Copyright (c) 2012 Tobias Sundstrand
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation 
//  files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, 
//  modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software 
//  is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "TSNetworkTests.h"

@implementation TSNetworkTests

- (void)setUp
{
    [super setUp];
    
}

- (void)tearDown
{
    
    [super tearDown];
}
- (void)get:(TSNetwork *)http{
    NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    
    TSNetworkRequest *req = [http getURL:url];
    [req sendAsync:^(NSHTTPURLResponse *response, NSString *body, NSError *error) {
        
    }];
    STAssertNotNil(req.urlRequest, @"no url request object");
    STAssertEqualObjects(req.urlRequest.HTTPMethod, @"GET", @"Not a get request");
    STAssertEqualObjects([req.urlRequest.allHTTPHeaderFields objectForKey:@"User-Agent"], @"TSNetwork", @"User agent wrong");
    STAssertNil(req.urlRequest.HTTPBody, @"Sending data on get");
    STAssertEqualObjects(req.urlRequest.URL, url, @"URL wrong on GET");
    STAssertEquals(req.urlRequest.timeoutInterval, 30.0,@"Wrong timeout interval on get");
    STAssertNil([req.urlRequest.allHTTPHeaderFields objectForKey:@"Content-Type"], @"Sending content type on GET");
    if(req.urlRequest.cachePolicy != NSURLRequestUseProtocolCachePolicy)
        STFail(@"wrong cache policy on GET");
}
- (void)post:(TSNetwork *)http{
    NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    
    NSString *dataString = @"{\"json\":\"value\"}";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    TSNetworkRequest *req = [[http postURL:url data:data] contentType:@"application/json"];
    [req sendAsync:^(NSURLResponse *response, NSString *body, NSError *error) {
        
    }];
    STAssertNotNil(req.urlRequest, @"no url request object");
    STAssertEqualObjects(req.urlRequest.HTTPMethod, @"POST", @"Not a post request");
    STAssertEqualObjects([req.urlRequest.allHTTPHeaderFields objectForKey:@"User-Agent"], @"TSNetwork", @"User agent wrong");
    STAssertNotNil(req.urlRequest.HTTPBody , @"not sending data on post");
    STAssertEqualObjects(req.urlRequest.URL, url, @"URL wrong on POST");
    STAssertEquals(req.urlRequest.timeoutInterval, 240.0, @"Wrong timeout interval on post");
    STAssertEqualObjects([req.urlRequest.allHTTPHeaderFields objectForKey:@"Content-Type"], @"application/json", @"not setting content type on POST");
    if(req.urlRequest.cachePolicy != NSURLRequestUseProtocolCachePolicy)
        STFail(@"wrong cache policy on POST");
}
- (void)put:(TSNetwork *)http{
    NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    
    NSString *dataString = @"{\"json\":\"value\"}";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    TSNetworkRequest *req = [[http putURL:url data:data] contentType:@"application/json"];
    [req sendAsync:^(NSHTTPURLResponse *response, NSString *body, NSError *error) {
        
    }];
    STAssertNotNil(req.urlRequest, @"no url request object");
    STAssertEqualObjects(req.urlRequest.HTTPMethod, @"PUT", @"Not a PUT request");
    STAssertEqualObjects([req.urlRequest.allHTTPHeaderFields objectForKey:@"User-Agent"], @"TSNetwork", @"User agent wrong");
    STAssertNotNil(req.urlRequest.HTTPBody , @"not sending data on PUT");
    STAssertEqualObjects(req.urlRequest.URL, url, @"URL wrong on PUT");
    STAssertEquals(req.urlRequest.timeoutInterval, 240.0,@"Wrong timeout interval on PUT");
    STAssertEqualObjects([req.urlRequest.allHTTPHeaderFields objectForKey:@"Content-Type"], @"application/json", @"not setting content type on PUT");
    if(req.urlRequest.cachePolicy != NSURLRequestUseProtocolCachePolicy)
        STFail(@"wrong cache policy on PUT");
}
- (void)delete:(TSNetwork *)http{
    NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    
    TSNetworkRequest *req = [http deleteURL:url];
    [req sendAsync:^(NSHTTPURLResponse *response, NSString *body, NSError *error) {
        
    }];
    STAssertNotNil(req.urlRequest, @"no url request object");
    STAssertEqualObjects(req.urlRequest.HTTPMethod, @"DELETE", @"Not a DELETE request");
    STAssertEqualObjects([req.urlRequest.allHTTPHeaderFields objectForKey:@"User-Agent"], @"TSNetwork", @"User agent wrong");
    STAssertNil(req.urlRequest.HTTPBody, @"Sending data on DELETE");
    STAssertEqualObjects(req.urlRequest.URL, url, @"URL wrong on DELETE");
    STAssertEquals(req.urlRequest.timeoutInterval, 30.0,@"Wrong timeout interval on DELETE");
    STAssertNil([req.urlRequest.allHTTPHeaderFields objectForKey:@"Content-Type"], @"Sending content type on DELETE");
    if(req.urlRequest.cachePolicy != NSURLRequestUseProtocolCachePolicy)
        STFail(@"wrong cache policy on DELETE");
}
- (void)testBasicGet{
    TSNetwork *http = [[TSNetwork alloc] init];
    [self get:http];
    [http release];
}

- (void)testBasicPost{
    TSNetwork *http = [[TSNetwork alloc] init];
    [self post:http];
    [http release];
    
}
- (void)testBasicPut{
    TSNetwork *http = [[TSNetwork alloc] init];
    [self put:http];
    [http release];
}
- (void)testBasicDelete{
    TSNetwork *http = [[TSNetwork alloc] init];
    [self delete:http];
    [http release];
}
- (void)testSequential{
    TSNetwork *http = [[TSNetwork alloc] init];
    [self get:http];
    [self delete:http];
    [self post:http];
    [self put:http];
    [http release];
}

- (void)testNSURLEncoded{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"hej", @"hå",
                                @"dåre", @"mi",
                                @"fa", @"så", nil];
    NSData *data = [TSNetwork urlEncodedEntityFromDictionary:dictionary];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    STAssertFalse([string hasSuffix:@"&"],@"wrong ending");
    
}
@end
