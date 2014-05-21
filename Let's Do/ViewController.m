//
//  ViewController.m
//  Let's Do
//
//  Created by Pratik on 15-05-14.
//  Copyright (c) 2014 appacitive. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import <Appacitive/AppacitiveSDK.h>
#import "MBProgressHUD.h"

@interface ViewController () <MBProgressHUDDelegate> {
    MBProgressHUD *_busyView;
}

@end

@implementation ViewController

- (IBAction)addButtonTapped {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"What needs to be done?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)logoutButtonTapped {
    [APUser logOutCurrentUserWithSuccessHandler:^{
        [self performSegueWithIdentifier:@"showLoginView" sender:nil];
    } failureHandler:^(APError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1) {
        APObject *todoObject = [[APObject alloc] initWithTypeName:@"todo"];
        [todoObject addPropertyWithKey:@"title"  value:[alertView textFieldAtIndex:0].text];
        [todoObject addPropertyWithKey:@"completed" value:@"false"];
        [todoObject addPropertyWithKey:@"order" value:[NSString stringWithFormat:@"%ld",(unsigned long)self.todoItems.count]];
        [todoObject saveObject];
        APConnection *conn = [[APConnection alloc] initWithRelationType:@"owner"];
        [conn createConnectionWithObjectA:todoObject objectB:[APUser currentUser] labelA:@"todo" labelB:@"user"];
        [self.todoItems addObject:todoObject];
        [self.tableView reloadData];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([APUser currentUser] == nil) {
        [self performSegueWithIdentifier:@"showLoginView" sender:nil];
    } else {
        if(_busyView == nil) {
            _busyView = [[MBProgressHUD alloc] initWithView:self.view];
        }
        [_busyView setLabelText:@"Fetching..."];
        [self.view addSubview:_busyView];
        _busyView.delegate = self;
        [_busyView show:YES];
        [APConnections fetchObjectsConnectedToObjectOfType:@"user" withObjectId:[[APUser currentUser] objectId] withRelationType:@"owner" fetchConnections:NO successHandler:^(NSArray *objects) {
            self.todoItems = [[NSMutableArray alloc] init];
            for(APGraphNode *node in objects) {
                [self.todoItems addObject:node.object];
            }
            [self.tableView reloadData];
            [_busyView removeFromSuperview];
        } failureHandler:^(APError *error) {
            NSLog(@"%@",[error description]);
        }];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSDictionary* attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle],
                                 NSStrikethroughColorAttributeName: [UIColor colorWithRed:0.349 green:0.733 blue:0.733 alpha:1.000]};
    
    cell.textLabel.text = [[self.todoItems objectAtIndex:indexPath.row] getPropertyWithKey:@"title"];
    
    NSLog(@"%@",[[self.todoItems objectAtIndex:indexPath.row] getPropertyWithKey:@"completed"]);
    
    if([[[self.todoItems objectAtIndex:indexPath.row] getPropertyWithKey:@"completed"] isEqualToString:@"true"]) {
        NSAttributedString* attrText = [[NSAttributedString alloc] initWithString:[[self.todoItems objectAtIndex:indexPath.row] getPropertyWithKey:@"title"] attributes:attributes];
        cell.textLabel.attributedText = attrText;
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:0.349 green:0.733 blue:0.733 alpha:1.000]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.minimumScaleFactor = 0.5;
    return cell;
}

//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[self.todoItems objectAtIndex:indexPath.row] deleteObjectWithConnectingConnections];
        [self.todoItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *strikeThroughAttributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle],NSStrikethroughColorAttributeName: [UIColor colorWithRed:0.349 green:0.733 blue:0.733 alpha:1.000]};
    NSDictionary *plainattributes = [[NSDictionary alloc] init];
    
    if([[[self.todoItems objectAtIndex:indexPath.row] getPropertyWithKey:@"completed"] isEqualToString:@"true"])
    {
        NSAttributedString *plainText = [[NSAttributedString alloc] initWithString:[[self.todoItems objectAtIndex:indexPath.row] getPropertyWithKey:@"title"] attributes:plainattributes];
        [self.tableView cellForRowAtIndexPath:indexPath].textLabel.attributedText = plainText;
        [[self.todoItems objectAtIndex:indexPath.row] updatePropertyWithKey:@"completed" value:@"false"];
        [[self.todoItems objectAtIndex:indexPath.row] updateObject];
    } else {
        NSAttributedString *strikeThroughText = [[NSAttributedString alloc] initWithString:[[self.todoItems objectAtIndex:indexPath.row] getPropertyWithKey:@"title"] attributes:strikeThroughAttributes];
        [self.tableView cellForRowAtIndexPath:indexPath].textLabel.attributedText = strikeThroughText;
        [[self.todoItems objectAtIndex:indexPath.row] updatePropertyWithKey:@"completed" value:@"true"];
        [[self.todoItems objectAtIndex:indexPath.row] updateObject];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoItems.count;
}

@end
