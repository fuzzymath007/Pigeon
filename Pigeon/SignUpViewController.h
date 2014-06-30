//
//  SignUpViewController.h
//  Pigeon
//
//  Created by Matthew Chess on 6/26/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *codeName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;


- (IBAction)submit:(id)sender;


@end
