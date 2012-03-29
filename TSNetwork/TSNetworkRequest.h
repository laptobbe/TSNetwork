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

#import <Foundation/Foundation.h>

@interface TSNetworkRequest : NSObject


typedef void(^CompleteBlock)(NSHTTPURLResponse* response, NSString *body, NSError *error);
@property (assign) NSOperationQueue* queue;


@property (assign) NSURLRequestCachePolicy cachePolicy;
@property (assign) NSTimeInterval timeoutInterval;
@property (assign) NSURLRequestNetworkServiceType networkServiceType;
@property (assign) BOOL shouldHandleCookies;
@property (assign) BOOL shouldUsePipelining;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSMutableDictionary *headers;
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSInputStream *dataStream;
@property (nonatomic, retain) NSMutableURLRequest *urlRequest;

- (TSNetworkRequest *)networkServiceType:(NSURLRequestNetworkServiceType)serviceType;
- (TSNetworkRequest *)shouldHandleCookies:(BOOL)should;
- (TSNetworkRequest *)shouldUsePiplining:(BOOL)should;
- (TSNetworkRequest *)cachePolicy:(NSURLRequestCachePolicy)cachePolicy;
- (TSNetworkRequest *)timeoutInterval:(NSTimeInterval)timeInterval;
- (TSNetworkRequest *)contentType:(NSString *)contentType;
- (TSNetworkRequest *)headers:(NSMutableDictionary*)headers;

- (void)send:(CompleteBlock)block;

@end
