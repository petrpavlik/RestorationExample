//
//  MyTicketsController.m
//  RestorationExample
//
//  Created by Petr Pavlik on 4/21/13.
//  Copyright (c) 2013 Petr Pavlik. All rights reserved.
//

#import "MyTicketsController.h"
#import "MyTicketController.h"

@interface MyTicketsController ()

@property(nonatomic, strong) NSArray* myTicketsArray;

@end

@implementation MyTicketsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSBundle* bundle = [NSBundle mainBundle];
	NSString* plistPath = [bundle pathForResource:@"MyTickets" ofType:@"plist"];
    
	self.myTicketsArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
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
    return self.myTicketsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSDictionary* concert = self.myTicketsArray[indexPath.row];
    cell.textLabel.text = concert[@"artist"];
    cell.detailTextLabel.text = concert[@"date"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    //[self performSegueWithIdentifier:@"ShowMyTicketController" sender:self];
    
    MyTicketController* myTicketController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyTicketController"];
    
    NSDictionary* ticket =  self.myTicketsArray[self.tableView.indexPathForSelectedRow.row];
    myTicketController.ticket = ticket;
    
    [self.navigationController pushViewController:myTicketController animated:YES];
}

#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowMyTicketController"]) {
        
        MyTicketController* destinationController = segue.destinationViewController;
        NSDictionary* ticket =  self.myTicketsArray[self.tableView.indexPathForSelectedRow.row];
        destinationController.ticket = ticket;
    }
}

#pragma mark -

- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view {
    
    NSIndexPath* indexPath = nil;
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    NSNumber * ticketId = [f numberFromString:identifier];
    
    if (ticketId) {
        
        NSInteger index = 0;
        for (NSDictionary* ticket in self.myTicketsArray) {
            
            if ([ticket[@"id"] isEqual:ticketId]) {
                
                indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                break;
            }
            
            index++;
        }
    }
    
    return indexPath;
}

- (NSString*)modelIdentifierForElementAtIndexPath:(NSIndexPath*)idx inView:(UIView*)view {
    
    if (idx) {
        
        NSDictionary* ticket = self.myTicketsArray[idx.row];
        NSString* identifier = [ticket[@"id"] description];
        return identifier;
    }
    
    return nil;
}

@end
