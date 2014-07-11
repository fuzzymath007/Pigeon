//
//  SendMessageTableViewController.h
//  Pigeon
//
//  Created by Matthew Chess on 7/1/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>


@interface SendMessageTableViewController : UITableViewController <AVAudioSessionDelegate, AVAudioPlayerDelegate>

@property (strong,nonatomic) PFUser *currentUser;
@property (strong,nonatomic) PFRelation *contactsRelation;
//This array is our list of contacts returned with objects from our backend
@property (strong,nonatomic) NSArray *contacts;
@property (strong,nonatomic) AVAudioPlayer *audioPlayer;

- (IBAction)previewMessage:(id)sender;

- (IBAction)sendMessageButton:(id)sender;

@end
