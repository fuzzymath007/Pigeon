//
//  LoginViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 6/26/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = true;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Login"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    [[self view] endEditing:YES];
}


- (IBAction)submitLogin:(id)sender {
    
    [super viewDidLoad];
    
    
    NSString *passWord = [self.passWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *codeName = [self.codeName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    codeName =[codeName lowercaseString];
    
    if ([passWord length] == 0 || [codeName length] == 0) {
        UIAlertView *missingValueAlert = [[UIAlertView alloc] initWithTitle:@"Missing Something" message:@"You left a field blank" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [missingValueAlert show];
    }else{
        
        [PFUser logInWithUsernameInBackground:codeName password:passWord block:^(PFUser *user, NSError *error) {
            if (user) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                else if (error.code == 101) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Invalid Login Credentials" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                    [alertView show];
                }
               
            else if (error == nil){
               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Could not log in:\nThe username or password were wrong." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alertView show];
            }
            else{
                NSLog(@"%@",error);
            }
        }];
        
    }
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
    


@end
