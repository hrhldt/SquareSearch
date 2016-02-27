//
//  ViewController.m
//  FourSquareSearch
//
//  Created by Martin Herholdt Rasmussen on 25/02/16.
//  Copyright © 2016 Martin Herholdt Rasmussen. All rights reserved.
//

#import "FSSearchController.h"
#import "FSVenue.h"

static NSString *kCellIdentifier = @"Cell";

@interface FSSearchController ()

@end

@implementation FSSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init

- (void)initView {
    self.presenter = [[FSSearchPresenter alloc] initWithView:self];
}

#pragma mark - TableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    FSVenue *venue = self.data[indexPath.row];
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.formattedAddress[0];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

#pragma mark - FSSearchView

- (void)onDataRecieved:(NSMutableArray *)data {
    self.data = data;
    [self.tableView reloadData];
}

- (void)onNetworkError:(NSString *)errorMessage {
    [[[UIAlertView alloc] initWithTitle:errorMessage message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
}

- (void)onConnectionError {
    [[[UIAlertView alloc] initWithTitle:@"No internet connection" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
}

#pragma mark - UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.presenter searchWithQuery:searchText];
}

@end
