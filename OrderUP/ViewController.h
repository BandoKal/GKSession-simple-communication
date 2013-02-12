//
//  ViewController.h
//  OrderUP
//
//  Created by Jason Bandy on 2/12/13.
//  Copyright (c) 2013 Jason Bandy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController <GKSessionDelegate>
{
    AppDelegate *appDelegate;
    NSMutableArray *availablePeers;
}
- (IBAction)connectToPeers:(id)sender;
- (IBAction)sendMessage:(id)sender;

@end
