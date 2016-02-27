//
//  SearchControllerPresenter.h
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSSearchView.h"
#import "FSNetwork.h"
#import "FSLocationManager.h"

@interface FSSearchPresenter : NSObject <FSNetworkDelegate>

- (id)initWithView:(id<FSSearchView>)searchView;
- (void)searchWithQuery:(NSString *)searchQuery;

@property (weak, nonatomic) id<FSSearchView> searchView;
@end
