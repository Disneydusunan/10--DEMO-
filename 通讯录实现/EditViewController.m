//
//  EditViewController.m
//  通讯录实现
//
//  Created by 谢谦 on 16/2/26.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import "EditViewController.h"
#import "ModelContact.h"
@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *contactTxtField;
@property (weak, nonatomic) IBOutlet UITextField *numberTxtField;
- (IBAction)saveBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)editClick:(UIBarButtonItem *)sender;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.contactTxtField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.numberTxtField];
    // Do any additional setup after loading the view.
    
    
    self.contactTxtField.text = self.contact.contact;
    self.numberTxtField.text = self.contact.number;
    
}

-(void)textChange
{

    self.saveBtn.enabled = self.contactTxtField.text.length && self.numberTxtField.text.length;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveBtn:(UIButton *)sender {

        [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(editContactWithController:editContact:)]) {
        self.contact.contact = self.contactTxtField.text;
        self.contact.number = self.numberTxtField.text;
        [self.delegate editContactWithController:self editContact:self.contact];
    }
    

    
}
- (IBAction)editClick:(UIBarButtonItem *)sender {
    if (self.contactTxtField.enabled) {
        self.contactTxtField.enabled = NO;
        self.numberTxtField.enabled = NO;
        [self.view endEditing:YES];
        self.saveBtn.enabled = NO;
        sender.title = @"编辑";
        self.contactTxtField.text = self.contact.contact;
        self.numberTxtField.text = self.contact.number;
    }else{
    
        self.contactTxtField.enabled = YES;
        self.numberTxtField.enabled = YES;
        [self.view endEditing:NO];
        self.saveBtn.enabled = YES;
        sender.title = @"取消";
        
    }
    
}
@end
