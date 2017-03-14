//
//  StatusItemView.h
//  打卡
//
//  Created by jusfoun on 16/4/30.
//  Copyright © 2016年 jusfoun. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CLCPopController;
@interface StatusItemView : NSControl
{
    NSMutableParagraphStyle *_style;
    NSEvent *_popoverTransiencyMonitor;
}
@property BOOL active;
@property (nonatomic, strong, readonly) NSStatusItem *statusItem;

@property (nonatomic,strong)CLCPopController *popController;

@property (nonatomic, retain) NSImage *image;

@property(strong, nonatomic) NSPopover *popover;


- (id)initWithStatusItem:(NSStatusItem *)statusItem;
- (void) hidePopover;
- (void)showPopover;
@end
