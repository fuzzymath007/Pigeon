//
//  editContactsTableViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 6/29/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "editContactsTableViewController.h"
#import "GAIDictionaryBuilder.h"


@interface editContactsTableViewController ()

@end

@implementation editContactsTableViewController


-(void)viewDidLoad{
    [super viewDidLoad];
   // self.contactRelation = [[PFUser currentUser] objectForKey:@"contactRelation"];
    
    
    
    
    //In edit contacts I set the contactRealtion key for the database
    self.contactsRelation = [[PFUser currentUser] objectForKey:@"contactRelation"];
    
    //Call to the backend to get our array of contacts
    PFQuery *query = [self.contactsRelation query];
    
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error : %@ %@",error, [error userInfo]);
        }else{
            self.allContacts = objects;
            [self.tableView reloadData];
        }
    }];
    
    self.currentUser = [PFUser currentUser];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Edit Contacts"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    
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
    return [self.allContacts count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.allContacts objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;

    if ([self isContact:user]) {
        cell.imageView.image = [UIImage imageNamed:@"remove_user-32.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"add_user-32.png"];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    //Get the user and the relationship to that user when someone hits a row
    PFRelation *contactRelation = [self.currentUser relationforKey:@"contactRelation"];
    
    PFUser *user = [self.allContacts objectAtIndex:indexPath.row];
    
    

    
    if ([self isContact:user]) {
    //    cell.accessoryType = UITableViewCellAccessoryNone;
        for (PFUser *contact in self.contacts){
            if([contact.objectId isEqualToString:user.objectId]){
                [self.contacts removeObject:contact];
                break;
            }
        }
        [contactRelation removeObject:user];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.contacts addObject:user];
        [contactRelation addObject:user];
    }
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"%@ %@",error, [error userInfo]);
        }
    }];
    
}


#pragma mark - Hellper Methods

- (BOOL)isContact:(PFUser *)user {
    for(PFUser *contact in self.contacts) {
        if ([contact.objectId isEqualToString:user.objectId]) {
            return YES;
        }
    }
    
    return NO;
}





@end
