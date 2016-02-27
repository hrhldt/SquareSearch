//
//  FSLocation.h
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FSModel.h"

@interface FSLocation : FSModel
/*
 "location": {
 "address": "W 42nd St",
 "crossStreet": "btwn Broadway & 8th Ave",
 "lat": 40.75650612666626,
 "lng": -73.98802757263184,
 "distance": 11348,
 "postalCode": "10036",
 "cc": "US",
 "city": "New York",
 "state": "NY",
 "country": "United States",
 "formattedAddress": [
 "W 42nd St (btwn Broadway & 8th Ave)",
 "New York, NY 10036",
 "United States"
 ]
 */

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *crossStreet;
@property (assign, nonatomic) CGFloat lat;
@property (assign, nonatomic) CGFloat lng;
@property (assign, nonatomic) NSInteger distance;
@property (strong, nonatomic) NSString *postalCode;
@property (strong, nonatomic) NSString *cc;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSArray *formattedAddress;


@end
