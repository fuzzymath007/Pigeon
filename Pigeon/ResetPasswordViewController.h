//
//  ResetPasswordViewController.h
//  Pigeon
//
//  Created by Matthew Chess on 8/17/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)submitReset:(id)sender;
@end
