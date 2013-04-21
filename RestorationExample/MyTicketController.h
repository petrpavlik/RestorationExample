//
//  MyTicketController.h
//  RestorationExample
//
//  Created by Petr Pavlik on 4/21/13.
//  Copyright (c) 2013 Petr Pavlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTicketController : UIViewController <UIViewControllerRestoration>

@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;

@property(nonatomic, strong) NSDictionary* ticket;

@end
