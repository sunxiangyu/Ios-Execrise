//
//  ContactsTableViewController.m
//  ContactsDemo
//
//  Created by 孙翔宇 on 15/6/15.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "AddViewController.h"
#import "ContactCell.h"
#import "Contact.h"
#import "EditViewController.h"

#define kContactPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.arc"]

@interface ContactsTableViewController ()<UIActionSheetDelegate, AddViewControllerDelegate, EditViewControllerDelegate>
- (IBAction)loginOut:(id)sender;

@property(nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSMutableArray *)contacts
{
    if (_contacts == nil) {
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:kContactPath];
        
        if (_contacts == nil) {
            _contacts = [NSMutableArray array];
        }
    }
    return _contacts;
}



- (IBAction)loginOut:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles: nil];
    
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!0 == buttonIndex) {
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = segue.destinationViewController;
    
    if ([vc isKindOfClass:[AddViewController class]]) {
        AddViewController *addVc = (AddViewController *)vc;
        addVc.delegate = self;
    } else if ([vc isKindOfClass:[EditViewController class]]) {
        EditViewController *editVc = (EditViewController *)vc;
        
        editVc.delegate = self;
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        Contact *contact = self.contacts[path.row];
        
        editVc.contact = contact;
        
        
    }
}

#pragma mark - AddViewControllerDelegate

- (void)addViewControllerDidAddBtn:(AddViewController *)addViewController contact:(Contact *)contact
{
    [self.contacts addObject:contact];
    
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kContactPath];;
    
    [self.tableView reloadData];
}

#pragma mark - EditViewControllerDelegate

-(void)editViewControllerDidClickSaveBtn:(EditViewController *)editViewController contact:(Contact *)contact
{
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kContactPath];
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell = [ContactCell cellWithTableView:tableView];
    
    Contact *c = self.contacts[indexPath.row];
    cell.contact = c;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:kContactPath];
    }
}

@end
