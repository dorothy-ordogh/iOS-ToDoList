//
//  ToDoListController.m
//  ToDoListApp
//
//  Created by Dorothy Ordogh on 2014-02-16.
//  Copyright (c) 2014 Dorothy Ordogh. All rights reserved.
//

#import "ToDoListController.h"
#import "Item.h"
#import "ItemStore.h"

@interface ToDoListController ()

@end

@implementation ToDoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"ToDo List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[ItemStore sharedStore] allItems].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Item *item = [[ItemStore sharedStore].allItems objectAtIndex:indexPath.row];
    cell.textLabel.text = item.itemName;
    if ([item.complete isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)addItem:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Item"
                                                   message:@"Enter your new item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *itemString = [alertView textFieldAtIndex:0].text;
        if(![itemString isEqualToString:@""]) {
            Item *item = [[ItemStore sharedStore] createItem];
            item.itemName = itemString;
            [self.tableView reloadData];
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
    
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Item *item = [[ItemStore sharedStore].allItems objectAtIndex:indexPath.row];
    if ([item.complete isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        item.complete = [NSNumber numberWithBool:NO];
    } else {
        item.complete = [NSNumber numberWithBool:YES];
    }
    [self.tableView reloadData];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Item *item = [[ItemStore sharedStore].allItems objectAtIndex:indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
