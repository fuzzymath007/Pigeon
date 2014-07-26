//
//  editContactsTableViewController.h
//  Pigeon
//
//  Created by Matthew Chess on 6/29/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface editContactsTableViewController : UITableViewController

//store ours user's contacts
@property (strong,nonatomic) NSArray *allContacts;

@property (nonatomic,strong) PFUser *currentUser;

@property (nonatomic,strong) NSMutableArray *contacts;

@property (strong,nonatomic) PFRelation *contactsRelation;



//Method to tell us if the user is a contact so that we can add a check mark
-(BOOL)isContact:(PFUser *)user;

@end
