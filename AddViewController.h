//
//  AddViewController.h
//  通讯录实现
//
//  Created by 谢谦 on 16/2/26.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelContact,AddViewController;

@protocol AddViewControllerDelegate <NSObject>

@optional
-(void)addContactWithAddViewController:(AddViewController *)addVC addContact:(ModelContact *)contact;

@end

@interface AddViewController : UIViewController

@property (nonatomic,assign)id<AddViewControllerDelegate> delegate;

@property (nonatomic,strong)ModelContact *contact;

@end
