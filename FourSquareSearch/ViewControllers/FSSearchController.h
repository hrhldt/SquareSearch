//
//  ViewController.h
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 25/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSSearchPresenter.h"

@interface FSSearchController : UITableViewController <FSSearchView, UISearchBarDelegate>

@property (strong, nonatomic) FSSearchPresenter *presenter;
@property (strong, nonatomic) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

