//
//  ViewController.h
//  Let's Do
//
//  Created by Pratik on 15-05-14.
//  Copyright (c) 2014 appacitive. All rights reserved.
//

@interface ViewController : UITableViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *todoItems;

- (IBAction)addButtonTapped;
- (IBAction)logoutButtonTapped;

@end
