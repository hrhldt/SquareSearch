//
//  FSNetwork.h
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"

@protocol FSNetworkDelegate <NSObject>

@optional
- (void)networkDidSearchWithResults:(NSMutableArray *)results;

@required
- (void)networkDidFailWithError:(NSError *)error successSelector:(SEL)selector;

@end

@interface FSNetwork : NSObject

+ (void)requestPlacesWithSearchQuery:(NSString *)searchQuery latLngQuery:(NSString *)latLngQuery delegate:(id<FSNetworkDelegate>)delegate;

@end
