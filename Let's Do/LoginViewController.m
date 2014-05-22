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

}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
