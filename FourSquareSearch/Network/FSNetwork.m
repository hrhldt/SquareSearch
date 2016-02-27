//
//  FSNetwork.m
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import "FSNetwork.h"
#import "FSVenue.h"
#import "FSLocationManager.h"

@implementation FSNetwork

static NSInteger kParsingError = 10999;
static AFHTTPSessionManager *sharedOperationManager;
static NSString *kFoursquareAPIVersion = @"20130185";
static NSString *kFoursquareClientID = @"Q0OAHSWUKMWG5XFCEWEOPN3WLVGPNYTSLSPYM0SXMHFXH54S";
static NSString *kFoursquareClientSecret = @"RVQUH5YZQY0FEVOFLOKRWFNHGO4NCZNKIWN5PIYZCZFONV1X";
static NSString *kBaseURL = @"https://api.foursquare.com/v2";

#pragma mark - Network calls

+ (void)requestPlacesWithSearchQuery:(NSString *)searchQuery delegate:(id<FSNetworkDelegate>)delegate {
    NSString *latLngQuery = [[FSLocationManager sharedInstance] currentLocationString];
    NSString *query = [NSString stringWithFormat:@"venues/search?client_id=%@&client_secret=%@&v=%@&ll=%@&query=%@", kFoursquareClientID, kFoursquareClientSecret, kFoursquareAPIVersion, latLngQuery, searchQuery];
    [[self sharedOperationManager] GET:query parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        @try {
            if ( delegate && [delegate respondsToSelector:@selector(networkDidSearchWithResults:)] ) {
                if ( [responseObject[@"response"][@"venues"] isKindOfClass:[NSArray class]] ) {
                    NSArray *venuesArray = responseObject[@"response"][@"venues"];
                    
                    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:venuesArray.count];
                    for ( NSDictionary *venuesDict in venuesArray ) {
                        [returnArray addObject:[[FSVenue alloc] initWithDictionary:venuesDict]];
                    }
                    
                    [delegate networkDidSearchWithResults:returnArray];
                }
            }
        }
        @catch (NSException *exception) {
            if ( delegate && [delegate respondsToSelector:@selector(networkDidFailWithError:successSelector:)] ) {
                [delegate networkDidFailWithError:[NSError errorWithDomain:@"Error in parsing" code:kParsingError userInfo:nil] successSelector:@selector(networkDidSearchWithResults:)];
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ( delegate && [delegate respondsToSelector:@selector(networkDidFailWithError:successSelector:)] ) {
            [delegate networkDidFailWithError:error successSelector:@selector(networkDidSearchWithResults:)];
        }
    }];
}

#pragma mark - Networking utilities

+ (AFHTTPSessionManager *)sharedOperationManager {
    if ( sharedOperationManager == nil ) {
        sharedOperationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[self baseURL]];
        sharedOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        AFJSONRequestSerializer *requestSerializer = [[AFJSONRequestSerializer alloc] init];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"accept"];
        
        sharedOperationManager.requestSerializer = requestSerializer;
    }
    
    return sharedOperationManager;
}

+ (NSURL *)baseURL {
    return [NSURL URLWithString:kBaseURL];
}

@end
