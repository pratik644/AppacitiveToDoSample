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
    if(self.email.text != nil && self.password.text != nil && ![[self.email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] && ![[self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        if((UIButton*)sender == self.loginButton) {
            if(_busyView == nil) {
                _busyView = [[MBProgressHUD alloc] initWithView:self.view];
            }
            [_busyView setLabelText:@"Verifying..."];
            [self.view addSubview:_busyView];
            _busyView.delegate = self;
            [_busyView show:YES];
            //Insert appactitive code here - 1
        } else if ((UIButton*)sender == self.signupButton) {
            [_busyView setLabelText:@"Signing you up..."];
            [self.view addSubview:_busyView];
            _busyView.delegate = self;
            [_busyView show:YES];
            //Insert Appacitive code here - 2
        }
        else {
            if(_busyView == nil) {
                _busyView = [[MBProgressHUD alloc] initWithView:self.view];
            }
            [_busyView setLabelText:@"Hold on tight..."];
            [self.view addSubview:_busyView];
            _busyView.delegate = self;
            [_busyView show:YES];
            //Insert Appacitive code here - 3
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
