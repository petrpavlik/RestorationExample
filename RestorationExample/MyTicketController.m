//
//  MyTicketController.m
//  RestorationExample
//
//  Created by Petr Pavlik on 4/21/13.
//  Copyright (c) 2013 Petr Pavlik. All rights reserved.
//

#import "MyTicketController.h"

@interface MyTicketController ()

@end

@implementation MyTicketController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSAssert(self.ticket!=nil, @"ticket property is not supposed to be nil");
    
    self.restorationClass = [self class];
    
    self.artistLabel.text = self.ticket[@"artist"];
    self.qrCodeImageView.image = [UIImage imageNamed:self.ticket[@"qr"]];
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:self.ticket[@"id"] forKey:@"ticketId"];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
}

+ (UIViewController *) viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    
    MyTicketController* vc = nil;
    
    UIStoryboard* storyboard = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
    
    if (!storyboard) {
        // bug???
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    }
    
    if (storyboard) {
        
        NSNumber* ticketId = [coder decodeObjectForKey:@"ticketId"];
        
        if (ticketId) {
            
            NSBundle* bundle = [NSBundle mainBundle];
            NSString* plistPath = [bundle pathForResource:@"MyTickets" ofType:@"plist"];
            NSArray* ticketsArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
            
            NSDictionary* ticket = nil;
            for (NSDictionary* testedTicket in ticketsArray) {
                
                if ([testedTicket[@"id"] isEqual:ticketId]) {
                    
                    ticket = testedTicket;
                    break;
                }
            }
            
            if (ticket) {
                
                vc = [storyboard instantiateViewControllerWithIdentifier:@"MyTicketController"];
                vc.ticket = ticket;
                
                vc.restorationIdentifier = [identifierComponents lastObject];
                vc.restorationClass = [self class];
            }
        }
    }
    
    return vc;
}

@end
