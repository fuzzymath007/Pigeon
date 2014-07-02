//
//  ContactsTableViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 6/30/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "editContactsTableViewController.h"

@interface ContactsTableViewController ()

@end

@implementation ContactsTableViewController

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
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showEditContacts"]) {
        editContactsTableViewController *viewController = (editContactsTableViewController *)segue.destinationViewController;
        viewController.contacts = [NSMutableArray arrayWithArray:self.contacts];
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
    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    PFUser *user = [self.contacts objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    return cell;
}


@end
