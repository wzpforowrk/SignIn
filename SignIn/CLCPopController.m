//
//  CLCPopController.m
//  打卡
//
//  Created by jusfoun on 16/4/30.
//  Copyright © 2016年 jusfoun. All rights reserved.
//

#import "CLCPopController.h"
#import "StatusItemController.h"
#import "AppDelegate.h"
@interface CLCPopController ()<NSTableViewDelegate,NSTableViewDataSource>

@property (strong, nonatomic)NSString *userNameStr;
@property (strong, nonatomic)NSString *savePath;

//用户名
@property (strong, nonatomic)NSTextField *nameTextfld;

//保存
@property (strong, nonatomic)NSButton *saveBtn;

//重置
@property (strong, nonatomic)NSButton *resetBtn;

//上班签到
@property (strong, nonatomic)NSButton *workBtn;

//下班打卡
@property (strong, nonatomic)NSButton *leaveBtn;

//退出
@property (strong, nonatomic)NSButton *quitBtn;

@end

@implementation CLCPopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // remove blue shadow of NSButton
    [[self view] setFocusRingType:NSFocusRingTypeNone];
    
    
//    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
//     
//                                                           selector:@selector(sleepMethod)
//     
//                                                               name:NSWorkspaceWillSleepNotification
//     
//                                                             object:nil];
    
    
    /*
     //其中能捕获到的状态有：
     
     NSWorkspaceWillSleepNotification睡眠
     
     NSWorkspaceDidWakeNotification从睡眠中唤醒
     
     NSWorkspaceWillPowerOffNotification当用户注销或关机
     
     NSWorkspaceSessionDidResignActiveNotification被切换到另一用户
     
     NSWorkspaceSessionDidBecomeActiveNotification被切换回到当前用户
     
     NSWorkspaceScreensDidSleepNotification屏幕睡眠
     
     NSWorkspaceScreensDidWakeNotification屏幕唤醒
     */

    
    
    
    self.quitBtn = [[NSButton alloc]init];
    [self.quitBtn setTitle:@"退出"];
    [self.quitBtn setTarget:self];
    [self.quitBtn setAction:@selector(quit:)];
    [self.view addSubview:self.quitBtn];
    
    self.leaveBtn = [[NSButton alloc]init];
    [self.leaveBtn setTitle:@"下班签退"];
    [self.leaveBtn setTarget:self];
    [self.leaveBtn setTag:3];
    [self.leaveBtn setAction:@selector(addWorkTime:)];
    [self.view addSubview:self.leaveBtn];
    
    self.workBtn = [[NSButton alloc]init];
    [self.workBtn setTitle:@"上班打卡"];
    [self.workBtn setTarget:self];
    [self.workBtn setTag:2];
    [self.workBtn setAction:@selector(addWorkTime:)];
    [self.view addSubview:self.workBtn];
    
//    self.resetBtn = [[NSButton alloc]init];
//    [self.resetBtn setTitle:@"重置目录"];
//    [self.resetBtn setTarget:self];
//    [self.resetBtn setAction:@selector(clearAdminPath)];
//    [self.view addSubview:self.resetBtn];
//    
//    self.saveBtn = [[NSButton alloc]init];
//    [self.saveBtn setTag:10];
//    [self.saveBtn setTitle:@"保存"];
//    [self.saveBtn setTarget:self];
//    [self.saveBtn setAction:@selector(setAdminPath:)];
//    [self.view addSubview:self.saveBtn];
//    
//    self.nameTextfld=[[NSTextField alloc]init];
//    self.nameTextfld.placeholderString = @"用户名";
//    [self.view addSubview:self.nameTextfld];
    
    
    [self changeFrame];
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//          }
//    
//    return self;
//}

-(void)viewWillAppear
{
    
}

-(void)changeFrame
{
    self.quitBtn.frame = NSRectFromCGRect(CGRectMake(10, 10, 60, 20));
    self.leaveBtn.frame = NSRectFromCGRect(CGRectMake(10, CGRectGetMaxY(self.quitBtn.frame)+10, 60, 20));
    self.workBtn.frame = NSRectFromCGRect(CGRectMake(10, CGRectGetMaxY(self.leaveBtn.frame)+10, 60, 20));
    self.resetBtn.frame = NSRectFromCGRect(CGRectMake(10, CGRectGetMaxY(self.workBtn.frame)+10, 60, 20));
    
//    self.saveBtn.frame = NSRectFromCGRect(CGRectMake(10, CGRectGetMaxY(self.resetBtn.frame), 60, 0));
//    
//    self.nameTextfld.frame = NSRectFromCGRect(CGRectMake(10, CGRectGetMaxY(self.saveBtn.frame), 60, 0));
    
    self.view.frame = NSRectFromCGRect(CGRectMake(0, 0, 80,  CGRectGetMaxY(self.workBtn.frame)+10));
}


#pragma mark - 上班打卡下班签退
- (void)addWorkTime:(NSButton*)sender
{
//    if ([self.userNameStr isEqualToString:@""]||!self.userNameStr||self.userNameStr.length == 0)
//    {
//        NSAlert *alert = [[NSAlert alloc]init];
//        [alert addButtonWithTitle:@"确定"];
//        [alert setMessageText:@"请输入需要保存的文件名称"];
//        [alert setAlertStyle:NSWarningAlertStyle];
//        [alert runModal];
//        
//        return;
//    }
    NSDateFormatter *form=[[NSDateFormatter alloc]init];
    [form setDateFormat:@"yyyy-MM"];
    NSString *date=[form stringFromDate:[NSDate date]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    // NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"20130510150714.log"];
    
    self.savePath = [NSString stringWithFormat:@"%@/%@打卡记录.txt",documentsDirectory,date];
    NSFileManager *filemanager=[NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:self.savePath]) {
        //NSLog(@"已经存在");
    }
    else
    {
        NSData *data=[[NSString stringWithFormat:@"%@记录\n\n",date] dataUsingEncoding:NSUTF8StringEncoding];
        bool succeed =  [filemanager createFileAtPath:self.savePath contents:data attributes:nil];
        if (succeed) {
            //NSLog(@"创建成功");
        }
        else
        {
            //NSLog(@"创建失败");
            NSAlert *alert = [[NSAlert alloc]init];
            [alert addButtonWithTitle:@"确定"];
            [alert setMessageText:@"创建文件失败"];
            [alert setAlertStyle:NSWarningAlertStyle];
            [alert runModal];
            return;
        }
    }
    [self writeFile:sender.tag];

}
//写入文件
-(void)writeFile:(NSInteger)tag
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    if (tag==1) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss EEEE\n"];
    }
    else if (tag==2)
    {
        [formatter setDateFormat:@"\n\t\tyyyy-MM-dd EEEE\n上班时间：HH:mm:ss "];
    }
    else if (tag==3)
    {
        [formatter setDateFormat:@" ==== 下班时间：HH:mm:ss\n\n"];
    }
    NSString *timeStr=[formatter stringFromDate:[NSDate date]];
    NSData *data=[timeStr dataUsingEncoding:NSUTF8StringEncoding];
    NSFileHandle *handle=[NSFileHandle fileHandleForWritingAtPath:self.savePath];
    [handle seekToEndOfFile];
    [handle writeData:data];
    [handle closeFile];
    NSAlert *alert = [[NSAlert alloc]init];
    [alert addButtonWithTitle:@"确定"];
    [alert setMessageText:@"今天加班记录成功"];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert runModal];
    
    StatusItemController *controller = [(AppDelegate *)[[NSApplication sharedApplication] delegate] statusItemController];
    [controller.statusItemView hidePopover];
    
}

#pragma mark - 设置用户名
-(void)setAdminPath:(NSButton*)sender
{
    if ([self.nameTextfld.stringValue isEqualToString:@""]) {
        NSAlert *alert = [[NSAlert alloc]init];
        [alert addButtonWithTitle:@"确定"];
        [alert setMessageText:@"请输入需要保存的用户名称"];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert runModal];
    }
    else
    {
        self.userNameStr=self.nameTextfld.stringValue;
        [[NSUserDefaults standardUserDefaults] setValue:self.userNameStr forKey:@"userNameStr"];
        [sender setHidden:true];
        [self.nameTextfld setHidden:true];
       // [self changeFrame];
    }
}


#pragma mark - 重置目录
-(void)clearAdminPath
{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"userNameStr"];
    [self changeFrame];
}


-(void)quit:(id)sender
{
    //[NSApp terminate:sender];
    [[NSApplication sharedApplication] terminate:self];
}


-(void)sleepMethod
{
    [self writeFile:2];
}




@end
