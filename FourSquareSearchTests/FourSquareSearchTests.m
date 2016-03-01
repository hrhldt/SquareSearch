//
//  FourSquareSearchTests.m
//  FourSquareSearchTests
//
//  Created by Martin Herholdt Rasmussen on 25/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FSNetwork.h"

@interface FourSquareSearchTests : XCTestCase <FSNetworkDelegate>

@end

@implementation FourSquareSearchTests

NSInteger kNetworkTimeout = 20;
XCTestExpectation *getVenuesExpectation;
XCTestExpectation *getVenuesShouldFailExpectation;

NSString *latLngQuery;
NSString *searchQuery;

NSString *requestShouldSucceed = @"Request should succeed";
NSString *requestShouldFail = @"Request should fail";

- (void)setUp {
    [super setUp];
    
    latLngQuery = @"55.12,12.56";
    searchQuery = @"s";
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler {
    [self waitForExpectationsWithTimeout:kNetworkTimeout handler:handler];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatGetVenuesFailsWhenParsingInWrongLocation {
    getVenuesShouldFailExpectation = [self expectationWithDescription:requestShouldFail];
    [FSNetwork requestPlacesWithSearchQuery:@"" latLngQuery:nil delegate:self];
    [self waitForExpectationsWithCommonTimeoutUsingHandler:nil];
}

- (void)testThatGetVenuesReturnsData {
    getVenuesExpectation = [self expectationWithDescription:requestShouldSucceed];
    [FSNetwork requestPlacesWithSearchQuery:searchQuery latLngQuery:latLngQuery delegate:self];
    [self waitForExpectationsWithCommonTimeoutUsingHandler:nil];
}

#pragma mark - Networking

- (void)networkDidFailWithError:(NSError *)error successSelector:(SEL)selector {
    [getVenuesShouldFailExpectation fulfill];
}

- (void)networkDidSearchWithResults:(NSMutableArray *)results {
    XCTAssert(results.count > 0, @"Results returned no data");
    
    [getVenuesExpectation fulfill];
}

@end
