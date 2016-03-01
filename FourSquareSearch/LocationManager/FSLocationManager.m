//
//  LocationManager.m
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import "FSLocationManager.h"

@implementation FSLocationManager

static NSString *kLocationCoordinateKey = @"LocationCoordinateKey";
static FSLocationManager *instance;

+ (FSLocationManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    
    if ( self ) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    return self;
}

- (void)startLocationUpdates {
    if ( [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ) {
        [self.locationManager startUpdatingLocation];
    } else {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (NSString *)currentLocationString {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCoordinateKey];
}

- (NSString *)latLngStringByLocation:(CLLocation*)location {

    if (location) {
        NSString *llString = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
        return llString;
    } else {
        return @"";
    }
}

#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if ( status == kCLAuthorizationStatusDenied ) {
        if ( self.delegate && [self.delegate respondsToSelector:@selector(locationManagerDidFailToAuthForLocationUpdates)] ) {
            [self.delegate locationManagerDidFailToAuthForLocationUpdates];
        }
    } else if ( status == kCLAuthorizationStatusAuthorizedWhenInUse ) {
        [self startLocationUpdates];
        
        if ( self.delegate && [self.delegate respondsToSelector:@selector(locationManagerDidAuthorizeForLocationUpdates)] ) {
            [self.delegate locationManagerDidAuthorizeForLocationUpdates];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if ( self.delegate && [self.delegate respondsToSelector:@selector(locationManagerDidLoadUserLocation:)] ) {
        [self.delegate locationManagerDidLoadUserLocation:[self latLngStringByLocation:locations[0]]];
    }
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    
}

@end
