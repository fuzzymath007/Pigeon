//
//  LoginViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 6/26/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
}


- (IBAction)submitLogin:(id)sender {
    
    
    NSString *passWord = [self.passWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *codeName = [self.codeName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([passWord length] == 0 || [codeName length] == 0) {
        UIAlertView *missingValueAlert = [[UIAlertView alloc] initWithTitle:@"Missing Something" message:@"You left a field blank" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [missingValueAlert show];
    }else{
        
        [PFUser logInWithUsernameInBackground:codeName password:passWord block:^(PFUser *user, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }else{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
    }
    
    
}


    


@end
