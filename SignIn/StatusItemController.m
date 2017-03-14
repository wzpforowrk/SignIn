//
//  StatusItemController.m
//  打卡
//
//  Created by jusfoun on 16/4/30.
//  Copyright © 2016年 jusfoun. All rights reserved.
//

#import "StatusItemController.h"

@implementation StatusItemController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Install status item into the menu bar
        _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
        // create custom view for status item
        _statusItemView = [[StatusItemView alloc] initWithStatusItem:_statusItem];
        // use hardcoded image as calendar background
        _statusItemView.image = [NSImage imageNamed:@"calendarIcon"];
    }
    return self;
}

- (void)dealloc
{
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
}


@end
