//
//  ItemStore.h
//  ToDoListApp
//
//  Created by Dorothy Ordogh on 2014-10-13.
//  Copyright (c) 2014 Dorothy Ordogh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;

@interface ItemStore : NSObject

+ (ItemStore *)sharedStore;
- (NSArray *)allItems;
- (Item *)createItem;
- (void)removeItem:(Item *)item;
- (void)save;

@end
