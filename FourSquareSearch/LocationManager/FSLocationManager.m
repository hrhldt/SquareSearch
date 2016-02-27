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
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (NSString *)currentLocationString {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLocationCoordinateKey];
}

- (void)saveCurrentLocation:(CLLocation*)location {

    NSString *llString = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults] setObject:llString forKey:kLocationCoordinateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self saveCurrentLocation:locations[0]];
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    
}

@end
