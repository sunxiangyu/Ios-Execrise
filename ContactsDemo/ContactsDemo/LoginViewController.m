//
//  LoginViewController.m
//  ContactsDemo
//
//  Created by 孙翔宇 on 15/6/15.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+NJ.h"

#define kAccount @"account"
#define kPwd @"pwd"
#define kRemPwd @"remPwd"
#define kAutoLogin @"autoLogin"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accoutTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;


@property (weak, nonatomic) IBOutlet UISwitch *remPwdSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;


- (IBAction)remPwdChange:(id)sender;

- (IBAction)autoLoginChange:(id)sender;

- (IBAction)loginBtnOnClick:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accoutTextField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdTextField];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.accoutTextField.text = [defaults objectForKey:kAccount];
    
    [self.remPwdSwitch setOn:[defaults boolForKey:kRemPwd] animated:YES];
    
    if (self.remPwdSwitch.isOn) {
        self.pwdTextField.text = [defaults objectForKey:kPwd];
    }
    
    [self.autoLoginSwitch setOn:[defaults boolForKey:kAutoLogin] animated:YES];
    
    self.LoginBtn.enabled = (self.accoutTextField.text.length > 0 && self.pwdTextField.text.length > 0);
    
//    if (self.autoLoginSwitch.isOn) {
//        [self loginBtnOnClick:nil];
//    }
    
}

-(void)textChange
{
    self.LoginBtn.enabled = (self.accoutTextField.text.length > 0 && self.pwdTextField.text.length > 0);
}



- (IBAction)remPwdChange:(id)sender {
    
    if (self.remPwdSwitch.isOn == NO) {
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

- (IBAction)autoLoginChange:(id)sender {
    
    if (self.autoLoginSwitch.isOn) {
        [self.remPwdSwitch setOn:YES animated:YES];
    }
}

- (IBAction)loginBtnOnClick:(id)sender {
    
    [MBProgressHUD showMessage:@"正在加载中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![self.accoutTextField.text isEqualToString:@"sxy"]) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"用户名不正确!!!"];
            return;
        }
        
        if (![self.pwdTextField.text isEqualToString:@"123"]) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"密码不正确!!!"];
            return;
        }
        
        [MBProgressHUD hideHUD];
        
        [self performSegueWithIdentifier:@"login2contact" sender:nil];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.accoutTextField.text forKey:kAccount];
        [defaults setObject:self.pwdTextField.text forKey:kPwd];
        [defaults setBool:self.remPwdSwitch.isOn forKey:kRemPwd];
        [defaults setBool:self.autoLoginSwitch.isOn forKey:kAutoLogin];
        [defaults synchronize];
    });
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = segue.destinationViewController;
    
    vc.title = [NSString stringWithFormat:@"%@ 的联系人列表", self.accoutTextField.text];
}
@end
