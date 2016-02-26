//
//  AddViewController.m
//  通讯录实现
//
//  Created by 谢谦 on 16/2/26.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import "AddViewController.h"
#import "ModelContact.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *contactField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
- (IBAction)addClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.contactField];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.numberField];
    
    
    // Do any additional setup after loading the view.
}
-(void)textChange
{
    self.addBtn.enabled = self.contactField.text.length && self.numberField.text.length;
    
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

- (IBAction)addClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    if ([self.delegate respondsToSelector:@selector(addContactWithAddViewController:addContact:)]) {
        ModelContact *contact = [[ModelContact alloc]init];
        contact.contact = self.contactField.text;
        contact.number = self.numberField.text;
        [self.delegate addContactWithAddViewController:self addContact:contact];
        
    }
    
}
@end
