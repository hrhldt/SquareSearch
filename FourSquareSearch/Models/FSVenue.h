//
//  FSVenue.h
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSModel.h"
#import "FSContact.h"
#import "FSLocation.h"

@interface FSVenue : FSModel

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) FSContact *contact;
@property (strong, nonatomic) FSLocation *location;

@end
