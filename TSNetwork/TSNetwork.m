//
//  TSNetwork.m
//  TSNetwork
//
//  Created by Tobias Sundstrand on 2012-02-25.
//  Copyright (c) 2012 Dream Inspiration. All rights reserved.
//

#import "TSNetwork.h"
@interface TSNetwork (privateMethods)
    + (void)sendRequest:(NSMutableURLRequest *)req encoding:(NSStringEncoding)encoding completeBlock:(CompleteBlock)block;
    + (NSOperationQueue *)workerQueue;
@end
@implementation TSNetwork
static NSOperationQueue *workerQueue;
+ (NSOperationQueue *)workerQueue{
    if(!workerQueue){
        workerQueue = [[NSOperationQueue alloc] init];
        [workerQueue setName:@"TSNetworkQueue"];
    }
    return workerQueue;
}
/*
 
 convinience methods
 */

+ (void)retryRequest:(NSMutableURLRequest *)request responseEncoding:(NSStringEncoding)encoding completeBlock:(CompleteBlock)block{
    [TSNetwork sendRequest:request encoding:encoding completeBlock:block];
}

/*
 Get methods
 
 
 */
+ (void)getURL:(NSURL *)url encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval httpHeaders:(NSDictionary *)headers withCompleteBlock:(CompleteBlock)block{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:cachePolicy timeoutInterval:timeInterval];
    [request setHTTPMethod:@"GET"];
    
    for (NSString *key in [headers allKeys]) {
        [request setValue:[headers valueForKey:key] forHTTPHeaderField:key];
    }
    [TSNetwork sendRequest:request encoding:encoding completeBlock:block];    
}
+ (void)getURL:(NSURL *)url encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval withCompleteBlock:(CompleteBlock)block{
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"TSNetwork",@"User-Agent", nil];
    [TSNetwork getURL:url encoding:encoding cachePolicy:cachePolicy timeoutInterval:timeInterval httpHeaders:headers withCompleteBlock:block];
}
+ (void)getURL:(NSURL *)url encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy withCompleteBlock:(CompleteBlock)block{
    [TSNetwork getURL:url encoding:encoding cachePolicy:cachePolicy timeoutInterval:10.0 withCompleteBlock:block];
}

+ (void)getURL:(NSURL *)url encoding:(NSStringEncoding)encoding withCompleteBlock:(CompleteBlock)block{
    [TSNetwork getURL:url encoding:encoding cachePolicy:NSURLRequestReturnCacheDataElseLoad withCompleteBlock:block];
}
+ (void)getURL:(NSURL *)url withCompleteBlock:(CompleteBlock)block{
    [TSNetwork getURL:url encoding:NSUTF8StringEncoding withCompleteBlock:block];
}

/*
 
 Post methods 
 */

+ (void)postData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval httpHeaders:(NSDictionary *)headers withCompleteBlock:(CompleteBlock)block{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:cachePolicy timeoutInterval:timeInterval];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    for (NSString *key in [headers allKeys]) {
        [request setValue:[headers valueForKey:key] forHTTPHeaderField:key];
    }
    
    [TSNetwork sendRequest:request encoding:encoding completeBlock:block];
    
}
+ (void)postData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval withCompleteBlock:(CompleteBlock)block{
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"TSNetwork",@"User-Agent", nil];
    [TSNetwork postData:data toURL:url contentType:contentType encoding:encoding cachePolicy:cachePolicy timeoutInterval:timeInterval httpHeaders:headers withCompleteBlock:block];
}
+ (void)postData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy withCompleteBlock:(CompleteBlock)block{
    [TSNetwork postData:data toURL:url contentType:contentType encoding:encoding cachePolicy:cachePolicy timeoutInterval:10.0 withCompleteBlock:block];
}
+ (void)postData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding withCompleteBlock:(CompleteBlock)block{
    [TSNetwork postData:data toURL:url contentType:contentType encoding:encoding cachePolicy:NSURLRequestUseProtocolCachePolicy withCompleteBlock:block];
}
+ (void)postData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType withCompleteBlock:(CompleteBlock)block{
    [TSNetwork postData:data toURL:url contentType:contentType encoding:NSUTF8StringEncoding withCompleteBlock:block];
}
/*
 
 Put methods
 */

+ (void)putData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval httpHeaders:(NSDictionary *)headers withCompleteBlock:(CompleteBlock)block{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:cachePolicy timeoutInterval:timeInterval];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:data];
    
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    for (NSString *key in [headers allKeys]) {
        [request setValue:[headers valueForKey:key] forHTTPHeaderField:key];
    }
    
    [TSNetwork sendRequest:request encoding:encoding completeBlock:block];
    
}
+ (void)putData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval withCompleteBlock:(CompleteBlock)block{
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"TSNetwork",@"User-Agent", nil];
    [TSNetwork putData:data toURL:url contentType:contentType encoding:encoding cachePolicy:cachePolicy timeoutInterval:timeInterval httpHeaders:headers withCompleteBlock:block];
}
+ (void)putData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy withCompleteBlock:(CompleteBlock)block{
    [TSNetwork putData:data toURL:url contentType:contentType encoding:encoding cachePolicy:cachePolicy timeoutInterval:10.0 withCompleteBlock:block];
}
+ (void)putData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding withCompleteBlock:(CompleteBlock)block{
    [TSNetwork putData:data toURL:url contentType:contentType encoding:encoding cachePolicy:NSURLRequestUseProtocolCachePolicy withCompleteBlock:block];
}
+ (void)putData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType withCompleteBlock:(CompleteBlock)block{
    [TSNetwork putData:data toURL:url contentType:contentType encoding:NSUTF8StringEncoding withCompleteBlock:block];
}


/*
 
 Delete methods
 */

+ (void)delete:(NSURL *)url encoding:(NSStringEncoding)encoding headers:(NSDictionary *)headers cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval completeBlock:(CompleteBlock)block{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:cachePolicy timeoutInterval:timeInterval];
    [request setHTTPMethod:@"DELETE"];
    
    for (NSString *key in [headers allKeys]) {
        [request setValue:[headers valueForKey:key] forHTTPHeaderField:key];
    }
    
    [TSNetwork sendRequest:request encoding:encoding completeBlock:block];
}
+ (void)delete:(NSURL *)url encoding:(NSStringEncoding)encoding headers:(NSDictionary *)headers cachePolicy:(NSURLRequestCachePolicy)cachePolicy completeBlock:(CompleteBlock)block{
    [TSNetwork delete:url encoding:encoding headers:headers cachePolicy:cachePolicy timeoutInterval:10.0 completeBlock:block];
    
}
+ (void)delete:(NSURL *)url encoding:(NSStringEncoding)encoding headers:(NSDictionary *)headers completeBlock:(CompleteBlock)block{
    [TSNetwork delete:url encoding:encoding headers:headers cachePolicy:NSURLRequestUseProtocolCachePolicy completeBlock:block];
}

+ (void)delete:(NSURL *)url encoding:(NSStringEncoding)encoding completeBlock:(CompleteBlock)block{
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"TSNetwork",@"User-Agent", nil];
    [TSNetwork delete:url encoding:encoding headers:headers completeBlock:block];
}
+ (void)delete:(NSURL *)url completeBlock:(CompleteBlock)block{
    [TSNetwork delete:url encoding:NSUTF8StringEncoding completeBlock:block];
}
/*
 
 Helper methods
 */

+ (void)sendRequest:(NSMutableURLRequest *)req encoding:(NSStringEncoding)encoding completeBlock:(CompleteBlock)block{
    [NSURLConnection sendAsynchronousRequest:req queue:[TSNetwork workerQueue] completionHandler:^(NSURLResponse *response, NSData * data, NSError *error) {
        NSString *body = [[NSString alloc] initWithData:data encoding:encoding];
        block(response,body,error,req);
    }];
}


@end
