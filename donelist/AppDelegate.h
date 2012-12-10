//
//  AppDelegate.h
//  donelist
//
//  Created by Jeff Dickey on 10/23/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListViewController.h"
#import <RestKit/RestKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
