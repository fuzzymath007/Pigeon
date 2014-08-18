//
//  SignUpViewController.m
//  Pigeon
//
//  Created by Matthew Chess on 6/26/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"

@interface SignUpViewController ()



@end

@implementation SignUpViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"SignUp"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    
}


- (IBAction)submit:(id)sender {
    
    NSString *email = [self.email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passWord = [self.passWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *codeNameTrim = [self.codeName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    codeNameTrim = [codeNameTrim lowercaseString];
    NSString *retypePassword = [self.retypePassWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([email length] == 0 || [passWord length] == 0 || [codeNameTrim length] == 0) {
        UIAlertView *missingValueAlert = [[UIAlertView alloc] initWithTitle:@"Missing Something" message:@"You left a field blank" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [missingValueAlert show];
    }else if(![passWord isEqualToString:retypePassword]){
    UIAlertView *accountNotCreated = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your passwords do not match" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
         [accountNotCreated show];
    }
    
    else{
    
    PFUser *newUser = [PFUser user];
    newUser.username = codeNameTrim;
    newUser.password = self.passWord.text;
    newUser.email = self.email.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            UIAlertView *accountNotCreated = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your account has not been created. Check if you entered a valid email." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [accountNotCreated show];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    }
    
    NSLog(@"%@",codeNameTrim);
}

- (IBAction)backToLogIn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
