//
//  SendMessageTableViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 7/1/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "SendMessageTableViewController.h"

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
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    PFUser *user = [self.contacts objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    [self uploadMessage];
    
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
    
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        else{
            PFObject *message = [PFObject objectWithClassName:@"Messages"];
            [message setObject:file forKey:@"file"];
            [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                }else{
                    NSLog(@"sent");
                }
            }];
            
        }
    }];
    
    
    
}



@end
