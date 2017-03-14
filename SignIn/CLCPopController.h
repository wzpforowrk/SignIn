//
//  CLCPopController.h
//  打卡
//
//  Created by jusfoun on 16/4/30.
//  Copyright © 2016年 jusfoun. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol CLCPopDelegate <NSObject>

-(void)reloadPop;

@end

@interface CLCPopController : NSViewController


-(void)writeFile:(NSInteger)tag;

@end
