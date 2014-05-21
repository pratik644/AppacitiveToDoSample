//
//  LoginViewController.m
//  Let's Do
//
//  Created by Pratik on 15-05-14.
//  Copyright (c) 2014 appacitive. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"

@interface LoginViewController () <MBProgressHUDDelegate> {
    MBProgressHUD *_busyView;
}

@end

@implementation LoginViewController

-(IBAction)buttonTapped:(id)sender {
    if((UIButton*)sender == self.loginButton || (UIButton*)sender == self.signupButton) {
        if(self.username.text != nil && self.password.text != nil && ![[self.username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] && ![[self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
        {
            if((UIButton*)sender == self.loginButton) {
                if(_busyView == nil) {
                    _busyView = [[MBProgressHUD alloc] initWithView:self.view];
                }
                [_busyView setLabelText:@"Verifying..."];
                [self.view addSubview:_busyView];
                _busyView.delegate = self;
                [_busyView show:YES];
                [APUser authenticateUserWithUserName:_username.text password:_password.text successHandler:^(APUser *user){
                    [_busyView removeFromSuperview];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } failureHandler:^(APError *error) {
                    NSLog(@"ERROR:%@",[error description]);
                    [_busyView removeFromSuperview];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                    [alert show];
                }];
            } else {
                if(self.email != nil && self.firstname != nil && ![[self.email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] &&  ![[self.firstname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
                    [_busyView setLabelText:@"Signing you up..."];
                    [self.view addSubview:_busyView];
                    _busyView.delegate = self;
                    [_busyView show:YES];
                    APUser *newUser = [[APUser alloc] init];
                    [newUser addPropertyWithKey:@"username" value:self.username.text];
                    [newUser addPropertyWithKey:@"password" value:self.password.text];
                    [newUser addPropertyWithKey:@"firstname" value:self.firstname.text];
                    [newUser addPropertyWithKey:@"email" value:self.email.text];
                    [newUser createUserWithSuccessHandler:^{
                        [APUser authenticateUserWithUserName:self.username.text password:self.password.text successHandler:^(APUser *user) {
                            [_busyView removeFromSuperview];
                            [self dismissViewControllerAnimated:YES completion:nil];
                        } failureHandler:^(APError *error) {
                            NSLog(@"ERROR:%@",[error description]);
                            [_busyView removeFromSuperview];
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                            [alert show];
                        }];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    } failureHandler:^(APError *error) {
                        NSLog(@"ERROR:%@",[error description]);
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                        [alert show];
                    }];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"I need your 'username', 'password', 'email' and 'firstname' to sign you up. Make sure you have entered them all." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"I need your 'username' and 'password' to let you in." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        if(self.username.text != nil && ![[self.username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            if(_busyView == nil) {
                _busyView = [[MBProgressHUD alloc] initWithView:self.view];
            }
            [_busyView setLabelText:@"Hold on tight..."];
            [self.view addSubview:_busyView];
            _busyView.delegate = self;
            [_busyView show:YES];
            APUser *forgetfulChap = [[APUser alloc] init];
            forgetfulChap.username = self.username.text;
            [forgetfulChap sendResetPasswordEmailWithSubject:@"Reset your Let's Do account password." successHandler:^{
                [_busyView removeFromSuperview];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yay!" message:@"I have sent you an email with instructions for resetting your Let's Do account password. Come back soon with a new password, we have a lot to get done." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alert show];
            } failureHandler:^(APError *error) {
                NSLog(@"ERROR:%@",[error description]);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alert show];
            }];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"I need your 'username' to email you the instructions for resetting your password." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
