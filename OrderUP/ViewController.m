//
//  ViewController.m
//  OrderUP
//
//  Created by Jason Bandy on 2/12/13.
//  Copyright (c) 2013 Jason Bandy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    GKSession *session;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    availablePeers = [[NSMutableArray alloc]init];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    session = [[GKSession alloc]initWithSessionID:@"OrderUP!"
                                      displayName:nil
                                      sessionMode:GKSessionModePeer];
    session.available = YES;
    session.delegate = self;
    [session setDataReceiveHandler:self
                       withContext:nil];
//    [session connectToPeer:session.peerID
//               withTimeout:40.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectToPeers:(id)sender
{
    [session connectToPeer:[availablePeers lastObject]
               withTimeout:40.0];
}

- (IBAction)sendMessage:(id)sender
{
    NSString *textString = @"0Hey I'm sending a message to your phone!";
    //package string as NSData object
    NSData *textData = [textString dataUsingEncoding:NSASCIIStringEncoding];
    //send data to all connected devices
    [session sendDataToAllPeers:textData withDataMode:GKSendDataReliable error:nil];
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{
    //unpackage NSData to NSString and set incoming text as label's text
    NSString *receivedString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSString *componentString = [receivedString substringToIndex:1];
    NSInteger choice = [componentString intValue];
    switch (choice) {
        case 0:// alert user selected
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Party Invitation"
                                                           message:[receivedString substringFromIndex:1]
                                                          delegate:nil
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles: nil];
            [alert show];
            
            break;
        }
            
        case 1:
        {
            NSLog(@"Message Received!!! [ %@] ", [receivedString substringFromIndex:1]);
            break;
        }
            
        default:
            break;
    }
    {
        
    }
}


#pragma mark GKSession Delegate methods

-(void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    [availablePeers addObject:peerID];
#ifdef DEBUG
    NSLog(@"OrderUpServer : [peer --> %@] changed state (%d)", peerID,state );
#endif
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
    [session acceptConnectionFromPeer:peerID error:nil];
#ifdef DEBUG
	NSLog(@"OrderUpServer: connection request from peer %@", peerID);
#endif
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
#ifdef DEBUG
	NSLog(@"OrderUpServer: connection with peer %@ failed %@", peerID, error);
#endif
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error
{
#ifdef DEBUG
	NSLog(@"OrderUpServer: session failed %@", error);
#endif
}

@end
