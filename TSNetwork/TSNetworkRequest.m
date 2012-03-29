//
//  TSNetwork.h
//  TSNetwork
//
//  Created by Tobias Sundstrand on 2012-02-25.

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

#import "TSNetworkRequest.h"

@implementation TSNetworkRequest
@synthesize cachePolicy = _cachePolicy;
@synthesize timeoutInterval = _timeoutInterval;
@synthesize contentType = _contentType;
@synthesize headers = _headers;
@synthesize queue = _queue;
@synthesize data = _data;
@synthesize method = _method;
@synthesize url = _url;
@synthesize urlRequest = _urlRequest;

- (id)init
{
    self = [super init];
    if (self) {
        [self setDefaults];
    }
    return self;
}
- (void)dealloc
{
    [_headers release];
    [_contentType release];
    [_method release];
    [_url release];
    if(_urlRequest)
        [_urlRequest release];
    
    [super dealloc];
}
- (void)setDefaults{
    self.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    self.timeoutInterval = 30.0;
    self.headers = [NSMutableDictionary dictionaryWithObject:@"TSNetwork" forKey:@"User-Agent"];
}
- (TSNetworkRequest *)cachePolicy:(NSURLRequestCachePolicy)cachePolicy{
    self.cachePolicy = cachePolicy;
    return self;
}
- (TSNetworkRequest *)timeoutInterval:(NSTimeInterval)timeInterval{
    self.timeoutInterval = timeInterval;
    return self;
}
- (TSNetworkRequest *)contentType:(NSString *)contentType{
    self.contentType = contentType;
    return self;
}
- (TSNetworkRequest *)headers:(NSMutableDictionary*)headers{
    [self.headers addEntriesFromDictionary:headers];
    return self;
}
- (void)sendRequest:(NSMutableURLRequest *)request completeBlock:(CompleteBlock)block{
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse *response, NSData * data, NSError *error) {
        if (data) {
            NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding((CFStringRef)response.textEncodingName));
            NSString *body = [[[NSString alloc] initWithData:data encoding:encoding] autorelease];
            block(response,body,error);
        }else {
            block(response,nil ,error);
            
        }
    }];
}
- (void)send:(CompleteBlock)block{
    
    self.urlRequest = [[[NSMutableURLRequest alloc] 
                                initWithURL:self.url 
                                cachePolicy:self.cachePolicy 
                                timeoutInterval:self.timeoutInterval] autorelease];
    [self.urlRequest setHTTPMethod:self.method];
    
    if(self.data)
        [self.urlRequest setHTTPBody:self.data];

    if(self.contentType)
        [self.urlRequest setValue:self.contentType forHTTPHeaderField:@"Content-Type"];
    
    for (NSString *key in [self.headers allKeys]) {
        [self.urlRequest setValue:[self.headers valueForKey:key] forHTTPHeaderField:key];
    }
    [self sendRequest:self.urlRequest completeBlock:block];
}

 

@end
