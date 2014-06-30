//
//  SignUpViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 6/26/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()



@end

@implementation SignUpViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)submit:(id)sender {
    
    NSString *email = [self.email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passWord = [self.passWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *codeName = [self.codeName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([email length] == 0 || [passWord length] == 0 || [codeName length] == 0) {
        UIAlertView *missingValueAlert = [[UIAlertView alloc] initWithTitle:@"Missing Something" message:@"You left a field blank" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [missingValueAlert show];
    }else{
    
    PFUser *newUser = [PFUser user];
    newUser.username = self.codeName.text;
    newUser.password = self.passWord.text;
    newUser.email = self.email.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            UIAlertView *accountNotCreated = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Your account has NOT been created" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [accountNotCreated show];
        }else{
            
 //           UIAlertView *accountCreated = [[UIAlertView alloc] initWithTitle: @"Done" message: @"Go get started" delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
   //         [accountCreated show];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    }
    
    
}




@end
