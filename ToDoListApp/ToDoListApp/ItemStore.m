//
//  ItemStore.m
//  ToDoListApp
//
//  Created by Dorothy Ordogh on 2014-10-13.
//  Copyright (c) 2014 Dorothy Ordogh. All rights reserved.
//

#import "ItemStore.h"
#import <CoreData/CoreData.h>

@interface ItemStore ()
@end

@implementation ItemStore {
    NSManagedObjectContext *_context;
    NSManagedObjectModel *_model;
    NSMutableArray *allItems;
}

- (NSString *)modelPath {
    NSArray *docDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [docDirectories objectAtIndex:0];
    return [docDirectory stringByAppendingPathComponent:@"store.data"];
}

- (id)init {
    self = [super init];
    if (self) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        NSURL *storeURL = [NSURL fileURLWithPath:self.modelPath];
        NSError *error;
        if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            [NSException raise:@"Open Failed" format:@"Reason: %@", error.localizedDescription];
        }
        
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = coordinator;
        _context.undoManager = nil;
    }
    return self;
}

+ (ItemStore *)sharedStore {
    static ItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedStore];
}

- (Item *)createItem {
    Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:_context];
    [allItems addObject:item];
    return item;
}

- (NSArray *)allItems {
    if (!allItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *description = [_model.entitiesByName objectForKey:@"Item"];
        request.entity = description;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"complete==%@", [NSNumber numberWithBool:NO]];
        request.predicate = predicate;
        
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdOn" ascending:YES];
        request.sortDescriptors = @[descriptor];
        
        NSError *error;
        NSArray *result = [_context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", error.localizedDescription];
        }
        allItems = [[NSMutableArray alloc] initWithArray:result];
    }
    return allItems;
}

- (void)save {
    [_context save:nil];
}

- (void)removeItem:(Item *)item {
    [_context deleteObject:item];
    [allItems removeObjectIdenticalTo:item];
}


@end
