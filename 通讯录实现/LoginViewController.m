//
//  LoginViewController.m
//  通讯录实现
//
//  Created by 谢谦 on 16/2/26.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import "LoginViewController.h"
#import "ContactTableViewController.h"
#import "MBProgressHUD+MJ.h"

#define usernameKey @"name"
#define userpassKey @"pass"
#define switchKey @"switchKey"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTxtFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UISwitch *switchbTN;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginClick;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameTxtFiled];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdTextField];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.nameTxtFiled.text = [defaults valueForKey:usernameKey];
    self.pwdTextField.text = [defaults valueForKey:userpassKey];
    self.switchbTN.on = [defaults boolForKey:switchKey];
    
    if (self.switchbTN.isOn) {
        self.pwdTextField.text = [defaults valueForKey:userpassKey];
        self.loginBtn.enabled = YES;
    }
    
    // Do any additional setup after loading the view.
}

-(void)textChange
{
    self.loginBtn.enabled = self.nameTxtFiled.text.length&&self.pwdTextField.text.length;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"id"]) {
        ContactTableViewController *contactVC = segue.destinationViewController;
        contactVC.title = [NSString stringWithFormat:@"%@的联系人列表",self.nameTxtFiled.text];
    }


}


- (IBAction)loginClick {
    if (![self.nameTxtFiled.text isEqualToString:@"dsn"]) {
        [MBProgressHUD showError:@"用户名错误"];
        return;
    }
    if(![self.pwdTextField.text isEqualToString:@"123"])
    {
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    
    [MBProgressHUD showMessage:@"正在登陆，请等待...."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self performSegueWithIdentifier:@"id" sender:nil];
    });
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.nameTxtFiled.text forKey:usernameKey];
    [defaults setObject:self.pwdTextField.text forKey:userpassKey];
    [defaults setBool:self.switchbTN.on forKey:switchKey];
    
    [defaults synchronize];
    
    
}
@end
