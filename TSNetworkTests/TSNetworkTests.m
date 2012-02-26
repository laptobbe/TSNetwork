//
//  TSNetworkTests.m
//  TSNetworkTests
//
//  Created by Tobias Sundstrand on 2012-02-25.
//  Copyright (c) 2012 Dream Inspiration. All rights reserved.
//

#import "TSNetworkTests.h"

@implementation TSNetworkTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}
- (void)testBasicPost{
    
}
- (void)testBasicGet{
    NSURL *url = [NSURL URLWithString:@"http://www.google.se/"];
    [TSNetwork getURL:url withCompleteBlock:^(NSURLResponse *response, NSString *body, NSError *error, NSMutableURLRequest *request) {
        STAssertNil(error, @"There was an error");
    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:10];
    while ([loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
}
- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in TSNetworkTests");
}

@end
