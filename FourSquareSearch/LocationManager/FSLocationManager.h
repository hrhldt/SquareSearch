//
//  LocationManager.h
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol FSLocationManagerDelegate <NSObject>

@optional
- (void)locationManagerDidLoadUserLocation:(NSString *)latLngString;
- (void)locationManagerDidFailToAuthForLocationUpdates;
- (void)locationManagerDidAuthorizeForLocationUpdates;

@end

@interface FSLocationManager : NSObject <CLLocationManagerDelegate>

+ (FSLocationManager *)sharedInstance;
- (void)startLocationUpdates;
- (NSString *)currentLocationString;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) id<FSLocationManagerDelegate> delegate;

@end
