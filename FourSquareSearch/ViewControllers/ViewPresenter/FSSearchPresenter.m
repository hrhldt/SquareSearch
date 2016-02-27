//
//  SearchControllerPresenter.m
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import "FSSearchPresenter.h"

@implementation FSSearchPresenter

- (id)initWithView:(id<FSSearchView>)searchView {
    self = [super init];
    
    if ( self ){
        _searchView = searchView;
        
        [[FSLocationManager sharedInstance] startLocationUpdates];
    }
    
    return self;
}

#pragma mark - Data loading

- (void)searchWithQuery:(NSString *)searchQuery {
    [FSNetwork requestPlacesWithSearchQuery:searchQuery delegate:self];
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

@end
