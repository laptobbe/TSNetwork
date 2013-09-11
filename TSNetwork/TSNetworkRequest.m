//
//  TSNetwork.h
//  TSNetwork
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

#import "TSNetworkRequest.h"

@implementation TSNetworkRequest

- (id)init
{
    self = [super init];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (void)setData:(NSData *)data{
    _data = data;
}

- (void)setDataStream:(NSInputStream *)dataStream{
    _dataStream = dataStream;
}

- (void)setDefaults{
    self.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    self.timeoutInterval = 60.0;
    self.headers = [NSMutableDictionary dictionaryWithObject:@"TSNetwork" forKey:@"User-Agent"];
    self.networkServiceType = NSURLNetworkServiceTypeDefault;
    self.shouldHandleCookies = YES;
    self.shouldUsePipelining = NO;
}

- (TSNetworkRequest *)networkServiceType:(NSURLRequestNetworkServiceType)serviceType{
    self.networkServiceType = serviceType;
    return self;
}
- (TSNetworkRequest *)shouldHandleCookies:(BOOL)should{
    self.shouldHandleCookies = should;
    return self;
}
- (TSNetworkRequest *)shouldUsePiplining:(BOOL)should{
    self.shouldUsePipelining = should;
    return self;
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

- (void)send:(CompleteBlock)block{
    NSMutableURLRequest *request = [self createURLRequest];
    self.urlRequest = request;
    [self sendRequest:request completeBlock:block];
}

- (void)sendRequest:(NSMutableURLRequest *)request completeBlock:(CompleteBlock)block{
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse *response, NSData * data, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (data) {
            NSString *body = [self parseStringWithData:data textEncoding:response.textEncodingName];
            block(httpResponse,body,error);
        }else {
            block(httpResponse, nil ,error);
        }
    }];
}

- (NSMutableURLRequest *)createURLRequest{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:self.url
                                    cachePolicy:self.cachePolicy
                                    timeoutInterval:self.timeoutInterval];
    [request setHTTPMethod:self.method];
    [request setNetworkServiceType:self.networkServiceType];
    [request setHTTPShouldHandleCookies:self.shouldHandleCookies];
    [request setHTTPShouldUsePipelining:self.shouldUsePipelining];
    
    if(self.data)
        [request setHTTPBody:self.data];
    if(self.dataStream)
        [request setHTTPBodyStream:self.dataStream];
    if(self.contentType)
        [request setValue:self.contentType forHTTPHeaderField:@"Content-Type"];
    
    for (NSString *key in [self.headers allKeys]) {
        [request setValue:[self.headers valueForKey:key] forHTTPHeaderField:key];
    }
    return request;
}

- (NSString *)parseStringWithData:(NSData *)data textEncoding:(NSString *)encoding{
    NSStringEncoding finalencoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding((CFStringRef)encoding));
    NSString *body = [[NSString alloc] initWithData:data encoding:finalencoding];
    return body;
}




 

@end
