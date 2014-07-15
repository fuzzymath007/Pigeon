//
//  InboxTableViewController.h
//  Pigeon
//
//  Created by Matthew Chess on 6/26/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>


@interface InboxTableViewController : UITableViewController

@property (nonatomic,strong) NSArray *messages;
@property (strong,nonatomic) AVAudioPlayer *audioPlayer;
@property (strong,nonatomic) PFObject *selectedMessage;



-(IBAction)logOut:(id)sender;



@end
