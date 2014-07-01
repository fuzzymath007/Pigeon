//
//  editContactsTableViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 6/29/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "editContactsTableViewController.h"


@interface editContactsTableViewController ()

@end

@implementation editContactsTableViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.contactRelation = [[PFUser currentUser] objectForKey:@"contactRelation"];
    
    PFQuery *query = [self.contactRelation query];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFUser *user = [self.allContacts objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    if ([self isContact:user]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"%@",_contacts);
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    //Get the user and the relationship to that user when someone hits a row
    PFUser *user = [self.allContacts objectAtIndex:indexPath.row];
    PFRelation *contactRelation = [self.currentUser relationForKey:@"contactRelation"];
    
    if ([self isContact:user]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
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

-(BOOL)isContact:(PFUser *)user{
    for (PFUser *contact in self.contacts)
        if([contact.objectId isEqualToString:user.objectId])
            return YES; {
            }
    return NO;
}





@end
