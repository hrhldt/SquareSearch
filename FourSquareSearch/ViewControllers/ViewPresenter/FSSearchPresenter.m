//
//  SearchControllerPresenter.m
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import "FSSearchPresenter.h"

@implementation FSSearchPresenter

NSString *latLngString;
BOOL isFirst = YES;

- (id)initWithView:(id<FSSearchView>)searchView {
    self = [super init];
    
    if ( self ){
        _searchView = searchView;
        
        [[FSLocationManager sharedInstance] startLocationUpdates];
        [FSLocationManager sharedInstance].delegate = self;
    }
    
    return self;
}

#pragma mark - Data loading

- (void)initFirstResultSet {
    if ( isFirst ) {
        isFirst = NO;
        [self searchWithQuery:@""];
    }
}

- (void)searchWithQuery:(NSString *)searchQuery {
    [FSNetwork requestPlacesWithSearchQuery:searchQuery latLngQuery:latLngString delegate:self];
}

#pragma mark - Networking

- (void)networkDidSearchWithResults:(NSMutableArray *)results {
    if ( _searchView && [_searchView respondsToSelector:@selector(onDataRecieved:)] ) {
        [_searchView onDataRecieved:results];
    }
}

- (void)networkDidFailWithError:(NSError *)error successSelector:(SEL)selector {
    if ( _searchView && [_searchView respondsToSelector:@selector(onNetworkError:)] ) {
        [_searchView onNetworkError:@"An error occured"];
    }
}

#pragma mark - Location manager

- (void)locationManagerDidLoadUserLocation:(NSString *)theLatLngString {
    latLngString = theLatLngString;
    [self initFirstResultSet];
    
    if ( _searchView && [_searchView respondsToSelector:@selector(onLocationRecieved)] ) {
        [_searchView onLocationRecieved];
    }
}

- (void)locationManagerDidAuthorizeForLocationUpdates {
    if ( _searchView && [_searchView respondsToSelector:@selector(onLocationUpdatesAuth)] ) {
        [_searchView onLocationUpdatesAuth];
    }
}

- (void)locationManagerDidFailToAuthForLocationUpdates {
    if ( _searchView && [_searchView respondsToSelector:@selector(onLocationError:)] ) {
        [_searchView onLocationError:@"Location updates have been disabled - please enable in settings"];
    }
}

@end
