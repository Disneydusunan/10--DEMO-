//
//  EditViewController.h
//  通讯录实现
//
//  Created by 谢谦 on 16/2/26.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ModelContact,EditViewController;
@protocol EditViewControllerDelegate <NSObject>

@optional
-(void)editContactWithController:(EditViewController *)editVC editContact:(ModelContact *)contact;

@end

@interface EditViewController : UIViewController

@property (nonatomic,assign)id<EditViewControllerDelegate> delegate;
@property (nonatomic,strong)ModelContact *contact;

@end
