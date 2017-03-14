//
//  StatusItemView.m
//  打卡
//
//  Created by jusfoun on 16/4/30.
//  Copyright © 2016年 jusfoun. All rights reserved.
//

#import "StatusItemView.h"
#import "CLCPopController.h"

@implementation StatusItemView



- (id)initWithStatusItem:(NSStatusItem *)statusItem
{
    self = [super initWithFrame:NSZeroRect];
    if (self != nil) {
        _statusItem = statusItem;
        _statusItem.view = self;
    }
    
    return self;
}



- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [self.statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:self.active];
    
    
    // init string drawing attr
    if(_style == nil) {
        _style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [_style setAlignment:NSCenterTextAlignment];
    }
    
    // draw day of month
    NSDictionary *attr;
    attr = [NSDictionary  dictionaryWithObjectsAndKeys:
            [NSColor blackColor], NSForegroundColorAttributeName,
            [NSFont fontWithName:@"Helvetica" size:11], NSFontAttributeName,
            _style, NSParagraphStyleAttributeName,
            nil];
    [[NSColor blackColor] set];
    
   
    NSRect calRect = NSMakeRect(2, 3, self.bounds.size.width - 4, self.bounds.size.height - 9);
   
    [@"打卡" drawInRect:calRect withAttributes:attr];
    
}




// Left Mouse Down, trigger left click action
-(void)mouseDown:(NSEvent *)theEvent {
    //    NSLog(@"left mouse Down");
    [self togglePopover];
}



// Right Mouse Down, trigger right click action
-(void)rightMouseDown:(NSEvent *)theEvent{
    //    NSLog(@"right mouse Down");
    [self togglePopover];
}

- (void) togglePopover {
    if( !self.popover.shown )
    {
        [self showPopover];
    } else {
        [self hidePopover];
    }
    [self setNeedsDisplay:YES];
}


- (void)setupPopover
{
    if(! self.popover)
    {
        self.popover = [[NSPopover alloc] init];
        //self.popover.contentViewController = [[CLCPopController alloc]init];
        self.popController = [[CLCPopController alloc]  initWithNibName:@"CLCPopController" bundle:nil];
        self.popover.contentViewController = self.popController;
        self.popover.animates = YES;
        self.popover.behavior = NSPopoverBehaviorTransient;
        //self.popover.delegate = self;
    }
}

- (void)showPopover
{
    self.active = true;
    
    [self setupPopover];
    
    [self.popover showRelativeToRect:[self bounds]
                              ofView:self
                       preferredEdge:NSMinYEdge];
    
    // if user click area outside of our menulet, hide the popover
    _popoverTransiencyMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseDownMask|NSRightMouseDownMask
                                                                       handler:^(NSEvent* event)
                                 {
                                     [self hidePopover];
                                     [self setNeedsDisplay:YES];
                                     [NSEvent removeMonitor:_popoverTransiencyMonitor];
                                     _popoverTransiencyMonitor = nil;
                                 }];
    
 
    [NSApp activateIgnoringOtherApps:YES];
}




- (void) hidePopover
{
    self.active = false;
    [self.popover performClose:nil];
}







@end
