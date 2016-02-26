//
//  ModelContact.m
//  通讯录实现
//
//  Created by 谢谦 on 16/2/26.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import "ModelContact.h"

@implementation ModelContact
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.contact forKey:@"name"];
    [aCoder encodeObject:self.number forKey:@"number"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.contact = [aDecoder decodeObjectForKey:@"name"];
        self.number = [aDecoder decodeObjectForKey:@"number"];
    }
    return self;
}
@end
