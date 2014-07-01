//
//  ContactSearchTableViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 6/30/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "ContactSearchTableViewController.h"

@interface ContactSearchTableViewController ()

@end

@implementation ContactSearchTableViewController

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
    
    self.searchContacts.delegate = self;
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
    if (self.foundContact) {
        
        return 1;
        
    } else {
        
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (self.foundContact) {
        cell.textLabel.text = self.foundContact.username;
    }
    
    
    
    return cell;
}


#pragma mark - Search Bar Methods

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //This will dismiss the keyboard and reload the table
    [self.searchContacts resignFirstResponder];
    [self.tableView reloadData];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //show cancel button
    self.searchContacts.showsCancelButton = true;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.searchContacts.showsCancelButton = false;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchContacts resignFirstResponder];
    
    
    //make sure found contact is empty
    self.foundContact = nil;
    
    NSString *searchedText = [self.searchContacts.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    if (!searchBar.text == 0) {
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:searchedText];
        [query  findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                if (objects.count > 0) {
                    self.foundContact = objects.lastObject;
                }else{
                    
                }
                
                [self.tableView reloadData];
            }else{
                //an error occurred
            }
        }];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFUser *user = self.foundContact;
    
    PFRelation *contactRelation = [self.currentUser relationForKey:@"contactRelation"];
    
    if ([self isContact:user]) {
        //remove them if they are already a contact
        
        cell.accessoryView = nil;
        
        for (PFUser *contact in self.contacts) {
            if ([contact.objectId isEqualToString:user.objectId]) {
                [self.contacts removeObject:contact];
                break;
            }
        }
        
        [contactRelation removeObject:user];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.contacts addObject:user];
        [contactRelation addObject:user];
    }
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}

-(BOOL)isContact:(PFUser *)user{
    for (PFUser *contact in self.contacts)
        if([contact.objectId isEqualToString:user.objectId])
            return YES; {
            }
    return NO;
}










@end
