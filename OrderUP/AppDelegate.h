//
//  AppDelegate.h
//  OrderUP
//
//  Created by Jason Bandy on 2/12/13.
//  Copyright (c) 2013 Jason Bandy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, GKSessionDelegate, GKPeerPickerControllerDelegate>
{
    GKPeerPickerController *connectionPicker;
    GKSession* connectionSession;
    NSMutableArray *connectionPeers;
}

@property (strong, nonatomic) UIWindow *window;
@property (retain) GKSession* connectionSession;
@property (nonatomic, retain) NSMutableArray *connectionPeers;
@property (nonatomic, retain) GKPeerPickerController* connectionPicker;
@end
