//
//  Item.m
//  ToDoListApp
//
//  Created by Dorothy Ordogh on 2014-02-16.
//  Copyright (c) 2014 Dorothy Ordogh. All rights reserved.
//

#import "Item.h"


@implementation Item

@dynamic createdOn;
@dynamic complete;
@dynamic itemName;

- (void)awakeFromInsert {
    self.createdOn = [NSDate date];
    self.complete = [NSNumber numberWithBool:NO];
    self.itemName = @"new item";
}

@end