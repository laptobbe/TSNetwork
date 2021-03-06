//
//  TSNetwork.m
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

#import "TSNetwork.h"

@interface TSNetwork (privateMethods)
    + (void)sendRequest:(NSMutableURLRequest *)req encoding:(NSStringEncoding)encoding completeBlock:(CompleteBlock)block;
@end

@implementation TSNetwork

-(id)init{
    self = [super init];
    if (self) {
        [self setDefaults];
    }
    return self;
}
- (void)setDefaults{
    
    _workerQueue = [[NSOperationQueue alloc] init];
    [self.workerQueue setName:@"TSNetworkQueue"];
    
}

- (TSNetworkRequest *)getURL:(NSURL *)url{
    TSNetworkRequest *req = [[TSNetworkRequest alloc] init];
    req.method = @"GET";
    req.url = url;
    req.queue = self.workerQueue;
    return req;
}

- (TSNetworkRequest *)postURL:(NSURL *)url{
    return [self postURL:url data:nil];
}

- (TSNetworkRequest *)postURL:(NSURL *)url data:(NSData *)data{
    TSNetworkRequest *req = [[TSNetworkRequest alloc] init];
    req.method = @"POST";
    req.url = url;
    req.data = data;
    req.queue = self.workerQueue;
    return req;
}

-(TSNetworkRequest *)postURL:(NSURL *)url dataStream:(NSInputStream *)inputStream{
    TSNetworkRequest *req = [[TSNetworkRequest alloc] init];
    req.method = @"POST";
    req.url = url;
    req.dataStream = inputStream;
    req.queue = self.workerQueue;
    return req;
}

- (TSNetworkRequest *)putURL:(NSURL *)url{
    return [self putURL:url data:nil];
}

- (TSNetworkRequest *)putURL:(NSURL *)url data:(NSData *)data{
    TSNetworkRequest *req = [[TSNetworkRequest alloc] init];
    req.method = @"PUT";
    req.url = url;
    req.data = data;
    req.queue = self.workerQueue;
    return req;
}
-(TSNetworkRequest *)putURL:(NSURL *)url dataStream:(NSInputStream *)inputSteam{
    TSNetworkRequest *req = [[TSNetworkRequest alloc] init];
    req.method = @"PUT";
    req.url = url;
    req.dataStream = inputSteam;
    req.queue = self.workerQueue;
    return req;
}

- (TSNetworkRequest *)deleteURL:(NSURL *)url{
    TSNetworkRequest *req = [[TSNetworkRequest alloc] init];
    req.method = @"DELETE";
    req.url = url;
    req.queue = self.workerQueue;
    return req;
}

+ (NSData *)urlEncodedEntityFromDictionary:(NSDictionary *)dictionary{
    NSMutableData *data = [NSMutableData data];
    for (int i = 0; i < dictionary.allKeys.count; i++) {
        if(i==dictionary.allKeys.count-1){
            NSString *key = [dictionary.allKeys objectAtIndex:i];
            NSString *value = [dictionary objectForKey:key];
            NSData *partialData = [[NSString stringWithFormat:@"%@=%@",key,value] dataUsingEncoding:NSUTF8StringEncoding];
            [data appendData:partialData];
        }else {
            NSString *key = [dictionary.allKeys objectAtIndex:i];
            NSString *value = [dictionary objectForKey:key];
            NSData *partialData = [[NSString stringWithFormat:@"%@=%@&",key,value] dataUsingEncoding:NSUTF8StringEncoding];
            [data appendData:partialData];
        }
    }
    return data;
}

@end
