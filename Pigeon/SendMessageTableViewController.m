//
//  SendMessageTableViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 7/1/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "SendMessageTableViewController.h"
#import "GAIDictionaryBuilder.h"

@interface SendMessageTableViewController ()

@end

@implementation SendMessageTableViewController

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
    
    //In edit contacts I set the contactRealtion key for the database
    self.contactsRelation = [[PFUser currentUser] objectForKey:@"contactRelation"];
    
    //Call to the backend to get our array of contacts
    PFQuery *query = [self.contactsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }else{
            self.contacts = [NSMutableArray arrayWithArray:objects];
            [self.tableView reloadData];
        }
    }];
    
    self.recipients = [[NSMutableArray alloc] init];
    
    [self.audioPlayer prepareToPlay];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"SendAMessage"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
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
    return self.contacts.count;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFUser *user = [self.contacts objectAtIndex:indexPath.row];
  
//give checkmarks to contacts selected for message
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.recipients addObject:user.objectId];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.recipients removeObject:user.objectId];
    }
    
//prevents the reuse of "cell" when many rows are displayed
    
    if ([self.recipients containsObject:user.objectId]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    PFUser *user = [self.contacts objectAtIndex:indexPath.row];

        cell.textLabel.text = user.username;
    
    return cell;
}

-(void)uploadMessage{
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"message.caf"];
    
    PFFile *file = [PFFile fileWithName:@"message.caf" contentsAtPath:soundFilePath];
    
    NSLog(@"Upload message: %@",file.url);
    
    if (file == nil) {
        UIAlertView *noMessageAlert = [[UIAlertView alloc] initWithTitle:@"No Message" message:@"Something has gone wrong. Please record your message again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [noMessageAlert show];
    }
    
    
    
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        else{
            PFObject *message = [PFObject objectWithClassName:@"Messages"];
            [message setObject:file forKey:@"file"];
            [message setObject:self.recipients forKey:@"Recipients"];
            [message setObject:[[PFUser currentUser] objectId] forKey:@"senderId"];
            [message setObject:[[PFUser currentUser] username] forKey:@"senderName"];
            [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    UIAlertView *noMessageSentAlert = [[UIAlertView alloc] initWithTitle:@"No Message" message:@"Something has gone wrong. Please record your message again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [noMessageSentAlert show];
                    NSLog(@"%@",error);
                }else{
                    NSLog(@"sent");
                    
                    
                }
            }];
            
        }
    }progressBlock:^(int percentDone) {
        if (percentDone == 100) {
            [self.navigationController popToRootViewControllerAnimated:YES];
       //     [self reset];
            NSLog(@"%@",self.recipients);
            NSLog(@"sent");

        }
    }];
    
    
    
}

- (IBAction)previewMessage:(id)sender {
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"message.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSError *error;
    
    NSLog(@" %@",docsDir);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    
   [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
    
    [audioSession setActive:YES error: &error];
    
    //play through iphone speakers
    
    [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error: &error];
    
    _audioPlayer.delegate = self;
    
    
    [self.audioPlayer play];
}

- (IBAction)sendMessageButton:(id)sender {
    
    [self uploadMessage];
    
    
}

- (void)reset {
    [self.recipients removeAllObjects];
}


@end
