//
//  BuyTicketsController.m
//  RestorationExample
//
//  Created by Petr Pavlik on 4/21/13.
//  Copyright (c) 2013 Petr Pavlik. All rights reserved.
//

#import "BuyTicketsController.h"

@interface BuyTicketsController ()

@property(nonatomic, strong) NSArray* concertsArray;

@end

@implementation BuyTicketsController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSBundle* bundle = [NSBundle mainBundle];
	NSString* plistPath = [bundle pathForResource:@"Concerts" ofType:@"plist"];
    
	self.concertsArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.concertsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSDictionary* concert = self.concertsArray[indexPath.row];
    cell.textLabel.text = concert[@"artist"];
    cell.detailTextLabel.text = concert[@"price"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
