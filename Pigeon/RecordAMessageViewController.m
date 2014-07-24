//
//  RecordAMessageViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 7/7/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "RecordAMessageViewController.h"
#import "GAIDictionaryBuilder.h"


@interface RecordAMessageViewController ()
{
    int recorded_time;
    NSTimer *timer;

}
@end

@implementation RecordAMessageViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"message.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    _audioRecorder = [[AVAudioRecorder alloc]
                      initWithURL:soundFileURL
                      settings:recordSettings
                      error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [_audioRecorder prepareToRecord];
        NSLog(@" %@",docsDir);
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Record Message"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{

}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    NSLog(@"Error: %@", error);
}


- (IBAction)recordMessage:(id)sender {
    if (!self.audioRecorder.recording)
    {
        [self.audioRecorder record];
        
        
        
    }
    
}

- (IBAction)stopRecording:(id)sender {
    
    if (self.audioRecorder.recording)
    {
        [self.audioRecorder stop];
    }
    
    [self performSegueWithIdentifier:@"showContactsForMessage" sender:self];
}




@end
