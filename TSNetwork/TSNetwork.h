//
//  TSNetwork.h
//  TSNetwork
//
//  Created by Tobias Sundstrand on 2012-02-25.
//  Copyright (c) 2012 Dream Inspiration. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSNetwork : NSObject
typedef void(^CompleteBlock)(NSURLResponse* response, NSString *body, NSError *error, NSMutableURLRequest *request);

/*
 
 Convinience methods
 */

+ (void)retryRequest:(NSMutableURLRequest *)request responseEncoding:(NSStringEncoding)encoding completeBlock:(CompleteBlock)block;

/*
 
 Get methods
 */
+ (void)getURL:(NSURL *)url encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval httpHeaders:(NSDictionary *)headers withCompleteBlock:(CompleteBlock)block;
+ (void)getURL:(NSURL *)url encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval withCompleteBlock:(CompleteBlock)block;
+ (void)getURL:(NSURL *)url encoding:(NSStringEncoding)encoding withCompleteBlock:(CompleteBlock)block;
+ (void)getURL:(NSURL *)url withCompleteBlock:(CompleteBlock)block;

/*
 
 Post methods
 */
+ (void)postData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval httpHeaders:(NSDictionary *)headers withCompleteBlock:(CompleteBlock)block;
+ (void)postData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval withCompleteBlock:(CompleteBlock)block;
+ (void)postData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy withCompleteBlock:(CompleteBlock)block;
+ (void)postData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding withCompleteBlock:(CompleteBlock)block;
+ (void)postData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType withCompleteBlock:(CompleteBlock)block;


/*
 
 Put methods
 */

+ (void)putData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval httpHeaders:(NSDictionary *)headers withCompleteBlock:(CompleteBlock)block;
+ (void)putData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval withCompleteBlock:(CompleteBlock)block;
+ (void)putData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding cachePolicy:(NSURLRequestCachePolicy)cachePolicy withCompleteBlock:(CompleteBlock)block;
+ (void)putData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType encoding:(NSStringEncoding)encoding withCompleteBlock:(CompleteBlock)block;
+ (void)putData:(NSData *)data toURL:(NSURL *)url contentType:(NSString *)contentType withCompleteBlock:(CompleteBlock)block;

/*
 
 Delete methods
 */

+ (void)delete:(NSURL *)url encoding:(NSStringEncoding)encoding headers:(NSDictionary *)headers cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeInterval completeBlock:(CompleteBlock)block;
+ (void)delete:(NSURL *)url encoding:(NSStringEncoding)encoding headers:(NSDictionary *)headers cachePolicy:(NSURLRequestCachePolicy)cachePolicy completeBlock:(CompleteBlock)block;
+ (void)delete:(NSURL *)url encoding:(NSStringEncoding)encoding headers:(NSDictionary *)headers completeBlock:(CompleteBlock)block;
+ (void)delete:(NSURL *)url encoding:(NSStringEncoding)encoding completeBlock:(CompleteBlock)block;
+ (void)delete:(NSURL *)url completeBlock:(CompleteBlock)block;
@end
