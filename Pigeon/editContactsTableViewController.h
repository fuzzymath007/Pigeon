//
//  editContactsTableViewController.h
//  Pigeon
//
//  Created by Matthew Chess on 6/29/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface editContactsTableViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, strong) PFUser *foundContact;
@property (strong,nonatomic) NSMutableArray *contacts;
@property (nonatomic,strong) PFUser *currentUser;

@property (strong, nonatomic) IBOutlet UISearchBar *searchContacts;
-(BOOL)isContact:(PFUser *)contact;

@end
