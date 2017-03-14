//
//  AppDelegate.m
//  SignIn
//
//  Created by WangZhipeng on 17/3/13.
//  Copyright © 2017年 王志朋. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.statusItemController = [[StatusItemController alloc] init];
    
    [self installDaemon];
    
    
}



// 配置开机默认启动
-(void)installDaemon{
    //注册为开机启动
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    NSString *appPath = [[NSBundle mainBundle] executablePath];
    appPath = [[NSBundle mainBundle] bundlePath];
    CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath:appPath];
    LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems, kLSSharedFileListItemLast, NULL, NULL, url, NULL, NULL);
    CFRelease(item);
    CFRelease(loginItems);
}




- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
