//
//  ContactTableViewController.m
//  通讯录实现
//
//  Created by 谢谦 on 16/2/26.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import "ContactTableViewController.h"
#import "AddViewController.h"
#import "ModelContact.h"
#import "EditViewController.h"

#define ContentFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"contacts.data"]


@interface ContactTableViewController ()<AddViewControllerDelegate,EditViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
- (IBAction)backClick:(UIBarButtonItem *)sender;


@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation ContactTableViewController


-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSKeyedUnarchiver unarchiveObjectWithFile:ContentFilePath];
        if (!_dataArr) {
            _dataArr = [[NSMutableArray alloc]init];

        }
        
    }

    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 

    self.tableView.rowHeight = 100;
//    [self clipExtraLines:self.tableView];

}
//-(void)clipExtraLines:(UITableView *)tableView
//{
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor clearColor];
//    [self.tableView setTableFooterView:view];
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    ModelContact *con = self.dataArr[indexPath.row];
    cell.textLabel.text = con.contact;
    cell.detailTextLabel.text = con.number;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


#pragma mark - Navigation




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[AddViewController class]]) {
        AddViewController *addVC = vc;
        addVC.delegate = self;
    }else if([vc isKindOfClass:[EditViewController class]]){
        EditViewController *editVC = vc;
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        editVC.contact = self.dataArr[path.row];
        
        editVC.delegate = self;
    
    }
//    
//    AddViewController *addVC = segue.destinationViewController;
//    addVC.delegate = self;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArr removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationBottom];
    }

}

-(void)editContactWithController:(EditViewController *)editVC editContact:(ModelContact *)contact
{
    [self.tableView reloadData];

}


-(void)addContactWithAddViewController:(AddViewController *)addVC addContact:(ModelContact *)contact
{
    [self.dataArr addObject:contact];
    [self.tableView reloadData];

    [NSKeyedArchiver archiveRootObject:self.dataArr toFile:ContentFilePath];
}


- (IBAction)backClick:(UIBarButtonItem *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注销"
                                                                             message:@"真的要注销吗"
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];

    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    
}
@end
