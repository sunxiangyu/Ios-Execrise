//
//  EditViewController.m
//  ContactsDemo
//
//  Created by 孙翔宇 on 15/6/15.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "EditViewController.h"
#import "Contact.h"

@interface EditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;


- (IBAction)editBtnOnClick:(UIBarButtonItem *)sender;


- (IBAction)saveBtnOnClick:(UIButton *)sender;


@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextField.text = _contact.name;
    self.phoneTextField.text = _contact.phone;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneTextField];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textChange
{
    self.saveBtn.enabled = (self.nameTextField.text.length > 0 && self.phoneTextField.text.length > 0);
}



- (IBAction)editBtnOnClick:(UIBarButtonItem *)sender {
    
    if (self.nameTextField.enabled) {
        self.nameTextField.enabled = NO;
        self.phoneTextField.enabled = NO;
        self.saveBtn.hidden = YES;
        [self.view endEditing:YES];
        sender.title = @"编辑";
        
        self.nameTextField.text = _contact.name;
        self.phoneTextField.text = _contact.phone;
    } else {
        self.nameTextField.enabled = YES;
        self.phoneTextField.enabled = YES;
        self.saveBtn.hidden = NO;
        [self.phoneTextField becomeFirstResponder];
        sender.title = @"取消";
    }
}

- (IBAction)saveBtnOnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.contact.name = self.nameTextField.text;
    self.contact.phone = self.phoneTextField.text;
    
    if ([self.delegate respondsToSelector:@selector(editViewControllerDidClickSaveBtn:contact:)]) {
        [self.delegate editViewControllerDidClickSaveBtn:self contact:self.contact];
    }
    
}
@end
