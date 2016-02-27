//
//  FSContact.h
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 27/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSModel.h"

@interface FSContact : FSModel

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *formattedPhone;

@end
