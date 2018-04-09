//
//  AppDelegate.h
//  binTest
//
//  Created by NCS Student on 4/6/18.
//  Copyright © 2018 NCS Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

