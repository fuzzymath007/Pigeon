//
//  LoginViewController.h
//  Pigeon
//
//  Created by Matthew Chess on 6/26/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codeName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;


- (IBAction)submitLogin:(id)sender;



@end
