//
//  FSSearchView.h
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#ifndef FSSearchView_h
#define FSSearchView_h


#endif /* FSSearchView_h */

@protocol FSSearchView <NSObject>

- (void)onLocationUpdatesAuth;
- (void)onLocationRecieved;
- (void)onLocationError:(NSString *)locationError;
- (void)onConnectionError;
- (void)onDataRecieved:(NSMutableArray *)data;
- (void)onNetworkError:(NSString *)errorMessage;

@end
