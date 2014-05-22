//
//  LoginViewController.m
//  Let's Do
//
//  Created by Pratik on 15-05-14.
//  Copyright (c) 2014 appacitive. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import <Appacitive/AppacitiveSDK.h>

@interface LoginViewController () <MBProgressHUDDelegate> {
    MBProgressHUD *_busyView;
}

@end

@implementation LoginViewController

-(IBAction)buttonTapped:(id)sender {
    if(self.email.text != nil && self.password.text != nil && ![[self.email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] && ![[self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        if((UIButton*)sender == self.loginButton) {
            if(_busyView == nil) {
                _busyView = [[MBProgressHUD alloc] initWithView:self.view];
            }
            [_busyView setLabelText:@"Verifying..."];
            [self.view addSubview:_busyView];
            _busyView.delegate = self;
            [_busyView show:YES];
            [APUser authenticateUserWithUsername:self.email.text password:_password.text successHandler:^(APUser *user){
                [_busyView removeFromSuperview];
                [self dismissViewControllerAnimated:YES completion:nil];
            } failureHandler:^(APError *error) {
                NSLog(@"ERROR:%@",[error description]);
                [_busyView removeFromSuperview];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alert show];
            }];
        } else if ((UIButton*)sender == self.signupButton) {
            [_busyView setLabelText:@"Signing you up..."];
            [self.view addSubview:_busyView];
            _busyView.delegate = self;
            [_busyView show:YES];
            APUser *newUser = [[APUser alloc] init];
            [newUser addPropertyWithKey:@"username" value:self.email.text];
            [newUser addPropertyWithKey:@"password" value:self.password.text];
            [newUser addPropertyWithKey:@"firstname" value:self.email.text];
            [newUser addPropertyWithKey:@"email" value:self.email.text];
            [newUser createUserWithSuccessHandler:^{
                [APUser authenticateUserWithUsername:self.email.text password:self.password.text successHandler:^(APUser *user) {
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
        }
        else {
            if(_busyView == nil) {
                _busyView = [[MBProgressHUD alloc] initWithView:self.view];
            }
            [_busyView setLabelText:@"Hold on tight..."];
            [self.view addSubview:_busyView];
            _busyView.delegate = self;
            [_busyView show:YES];
            [APUser sendResetPasswordEmailForUserWithUsername:self.email.text withSubject:@"Reset your Let's Do account password." successHandler:^{
                [_busyView removeFromSuperview];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yay!" message:@"I have sent you an email with instructions for resetting your Let's Do account password. Come back soon with a new password, we have a lot to get done." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alert show];
            } failureHandler:^(APError *error) {
                NSLog(@"ERROR:%@",[error description]);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alert show];
            }];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"We need your 'email' and 'password' both." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
