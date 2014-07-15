//
//  playMessageViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 7/14/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "playMessageViewController.h"

@interface playMessageViewController ()

@end

@implementation playMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFFile *audioFile = [self.message objectForKey:@"file"];
    
    NSData *audioFileData = [audioFile getData];
    
    NSLog(@"%@",audioFileData);
    
    
    
//    NSURL *audioFileURL = [[NSURL alloc] initWithString:audioFile.url];
//    
//  
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    
//    NSError *error;
//    
//    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:&error];
//    
//    
//    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
//    
//    [audioSession setActive:YES error: &error];
//    
//    //play through iphone speakers
//    
//    [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error: &error];
//    
//    _audioPlayer.delegate = self;
//    
//    NSLog(@"%@",audioFileURL);
//    
//    
//    [self.audioPlayer play];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end









