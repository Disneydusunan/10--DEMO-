//
//  ModelContact.h
//  通讯录实现
//
//  Created by 谢谦 on 16/2/26.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelContact : NSObject<NSCoding>
@property (nonatomic,copy)NSString *contact;
@property (nonatomic,copy)NSString *number;

@end
