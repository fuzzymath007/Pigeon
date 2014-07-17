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

//    NSString *docsDir;
//    NSArray *dirPaths;
//    
//    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    docsDir = [dirPaths objectAtIndex:0];
//    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"foo.png"]];
//    [audioData writeToFile:databasePath atomically:YES];

    
//    NSString *docsDir;
//    NSArray *dirPaths;
    
//    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    docsDir = [dirPaths objectAtIndex:0];
//    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"recievedMessage.caf"]];
//    NSURL *audioURL = [[NSURL alloc] initWithString:databasePath];
    

    
//    NSLog(@"%@", audioURL);
    

    
    //[data writeToURL:(NSURL *) audioURL atomically:YES];
    

    
    
}

//- (void)saveSoundFileToDocuments:(NSData *)soundData fileName:(NSString *)fileName {
//    NSString *docsDir;
//    NSArray *dirPaths;
//    
//    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    docsDir = [dirPaths objectAtIndex:0];
//    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"recievedMessage.caf"]];
//    [soundData writeToFile:databasePath atomically:YES];
//}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    PFFile *audioFile = [self.message objectForKey:@"file"];
    NSURL *audioFileURL = [[NSURL alloc] initWithString:audioFile.url];
    NSData *audioData = [NSData dataWithContentsOfURL:audioFileURL];
    
    [audioFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSError *error;
            
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            
            self.audioPlayer = [[AVAudioPlayer alloc] initWithData:data fileTypeHint:AVFileTypeCoreAudioFormat error:&error];
            
        //    _audioPlayer = [[AVAudioPlayer alloc] initWithData:data url error:&error];
            
            [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
            
            [audioSession setActive:YES error: &error];
            
            //play through iphone speakers
            
            [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error: &error];
            
            _audioPlayer.delegate = self;
            
            
            [self.audioPlayer play];
            
            
            
        }
    }progressBlock:^(int percentDone) {
        NSLog(@"%d", percentDone);
    }];
    
//    NSArray *dirPaths;
//    NSString *docsDir;
//    
//    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    docsDir = dirPaths[0];
//    
//    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"recievedMessage.caf"];
//    
//    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
//    
//    NSError *error;
//    
//    NSLog(@" %@",docsDir);
//    
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    
//    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
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
//    NSLog(@" %@",soundFileURL);
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
