//
//  ViewController.h
//  Let's Do
//
//  Created by Pratik on 15-05-14.
//  Copyright (c) 2014 appacitive. All rights reserved.
//

@interface ViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *todoItems;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addButtonTapped;
- (IBAction)logoutButtonTapped;

@end
