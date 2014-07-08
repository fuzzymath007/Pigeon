//
//  RecordAMessageViewController.h
//  Pigeon
//
//  Created by Matthew Chess on 7/7/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>

@interface RecordAMessageViewController : ViewController

@property (strong,nonatomic) AVAudioRecorder *audioRecorder;
@property (strong,nonatomic) AVAudioPlayer *audioPlayer;
@property (strong,nonatomic) IBOutlet UIButton *recordButton;

- (IBAction)Record:(id)sender;

@end
