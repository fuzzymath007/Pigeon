//
//  RecordAMessageViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 7/7/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "RecordAMessageViewController.h"


@interface RecordAMessageViewController ()

@end

@implementation RecordAMessageViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //check if PFFile can be used as the location of the audio file
    PFFile *
    
    
    
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:<#(NSURL *)#> settings:<#(NSDictionary *)#> error:<#(NSError *__autoreleasing *)#>]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)Record:(id)sender {
}
@end
