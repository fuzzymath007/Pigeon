//
//  playMessageViewController.h
//  Pigeon
//
//  Created by Matthew Chess on 7/14/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <AVFoundation/AVFoundation.h>

@interface playMessageViewController : UIViewController <AVAudioSessionDelegate, AVAudioPlayerDelegate>

@property (strong,nonatomic) PFObject *message;
@property (strong,nonatomic) AVAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UIImageView *audioView;

@end
