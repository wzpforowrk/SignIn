//
//  StatusItemController.h
//  打卡
//
//  Created by jusfoun on 16/4/30.
//  Copyright © 2016年 jusfoun. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AppKit;
#import "StatusItemView.h"
@interface StatusItemController : NSObject

@property (nonatomic, strong, readonly) NSStatusItem *statusItem;
@property (nonatomic, strong, readonly) StatusItemView *statusItemView;

@end
