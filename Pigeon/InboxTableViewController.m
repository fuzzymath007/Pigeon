//
//  InboxTableViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 6/26/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "InboxTableViewController.h"
#import "GAIDictionaryBuilder.h"

@interface InboxTableViewController ()

@end

@implementation InboxTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([PFUser currentUser] != nil) {
        self.currentUser = [PFUser currentUser];
    }
    
    
    if (self.currentUser) {
            NSLog(@"Current User is %@",self.currentUser);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Inbox"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    if (self.currentUser != nil) {
        PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
        [query whereKey:@"Recipients" equalTo:[[PFUser currentUser] objectId]];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"Error %@ %@", error, error.userInfo);
            }else{
                //We got our messages stored in our objects array stroed in our block
                
                self.messages = objects;
                [self.tableView reloadData];
            }
        }];
    }
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    self.selectedMessage = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.selectedMessage objectForKey:@"senderName"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
//    [self performSegueWithIdentifier:@"playAudioMessage" sender:self];
    
    self.selectedMessage = [self.messages objectAtIndex:indexPath.row];
    
    PFFile *audioFile = [message objectForKey:@"file"];

    
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
            
            NSMutableArray *recipientsInMeaages = [NSMutableArray arrayWithArray:[self.selectedMessage objectForKey:@"Recipients"]];
            NSLog(@"%@",recipientsInMeaages);
            
            if ([recipientsInMeaages count] == 1) {
                [self.selectedMessage deleteInBackground];
            }else{
                [recipientsInMeaages removeObject:[[PFUser currentUser] objectId]];
                [self.selectedMessage setObject:recipientsInMeaages forKey:@"recipientIds"];
                [self.selectedMessage saveInBackground];
            }
            
            
            
        }
    }progressBlock:^(int percentDone) {
        NSLog(@"%d", percentDone);
    }];
    


    
    
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"showLogin"]) {
//        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
//    }
//    else if ([segue.identifier isEqualToString:@"playAudioMessage"]) {
//        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
//        playMessageViewController *playAMessageViewController = (playMessageViewController *)segue.destinationViewController;
//        playAMessageViewController.message = self.selectedMessage;
//        
//    }
//    
//}

-(IBAction)logOut:(id)sender {
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"Current User is %@",currentUser);
}





/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
