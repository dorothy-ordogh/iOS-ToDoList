//
//  Item.h
//  ToDoListApp
//
//  Created by Dorothy Ordogh on 2014-02-16.
//  Copyright (c) 2014 Dorothy Ordogh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSNumber * complete;
@property (nonatomic, retain) NSString * itemName;

@end
