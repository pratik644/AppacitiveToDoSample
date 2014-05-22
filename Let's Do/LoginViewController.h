//
//  LoginViewController.h
//  Let's Do
//
//  Created by Pratik on 15-05-14.
//  Copyright (c) 2014 appacitive. All rights reserved.
//

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (strong,nonatomic) IBOutlet UITextField *password;
@property (strong,nonatomic) IBOutlet UITextField *email;
@property (strong,nonatomic) IBOutlet UIButton *loginButton;
@property (strong,nonatomic) IBOutlet UIButton *signupButton;
@property (strong,nonatomic) IBOutlet UIButton *forgotPasswordButton;

- (IBAction)buttonTapped:(id)sender;

@end
