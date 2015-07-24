//
//  AddViewController.m
//  ContactsDemo
//
//  Created by 孙翔宇 on 15/6/15.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "AddViewController.h"
#import "Contact.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

- (IBAction)addOnClick:(UIButton *)sender;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneTextField];
}


-(void)textChange
{
    self.addBtn.enabled = (self.nameTextField.text.length > 0 && self.phoneTextField.text.length > 0);
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.nameTextField becomeFirstResponder];
}


- (IBAction)addOnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    NSString *name = self.nameTextField.text;
    NSString *phone = self.phoneTextField.text;
    
    Contact *c = [[Contact alloc] init];
    c.name = name;
    c.phone = phone;
    
    if ([self.delegate respondsToSelector:@selector(addViewControllerDidAddBtn:contact:)]) {
        [self.delegate addViewControllerDidAddBtn:self contact:c];
    }
    
}
@end
