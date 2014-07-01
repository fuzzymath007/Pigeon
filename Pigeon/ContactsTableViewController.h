//
//  ContactsTableViewController.h
//  Pigeon
//
//  Created by Matthew Chess on 6/30/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface ContactsTableViewController : UITableViewController

@property (strong,nonatomic) PFUser *currentUser;
@property (strong,nonatomic) PFRelation *contactsRelation;
//This array is our list of contacts returned with objects from our backend
@property (strong,nonatomic) NSArray *contacts;




@end
