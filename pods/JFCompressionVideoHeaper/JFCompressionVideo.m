//
//  JFCompressionVideo.m
//  textUpLoad
//
//  Created by iOS-Developer on 16/2/19.
//  Copyright © 2016年 iOS-Jessonliu. All rights reserved.
//

#import "JFCompressionVideo.h"
#import <AVFoundation/AVFoundation.h>


#define CompressionVideoPaht [NSHomeDirectory() stringByAppendingFormat:@"/Documents/CompressionVideoField"]

@interface JFCompressionVideo ()
@end

@implementation JFCompressionVideo

+ (void)compressedVideoOtherMethodWithURL:(NSURL *)url compressionType:(NSString *)compressionType compressionResultPath:(CompressionSuccessBlock)resultPathBlock {
    
    NSString *resultPath;
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    CGFloat totalSize = (float)data.length / 1024 / 1024;
    
    //抽象类和不可变类
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];

    // 所支持的压缩格式中是否有 所选的压缩格式
    if ([compatiblePresets containsObject:compressionType]) {

        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:compressionType];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        BOOL isExists = [manager fileExistsAtPath:CompressionVideoPaht];
        if (!isExists) {
            
            [manager createDirectoryAtPath:CompressionVideoPaht withIntermediateDirectories:YES attributes:nil error:nil];
        }

        resultPath = [CompressionVideoPaht stringByAppendingPathComponent:[NSString stringWithFormat:@"outputJFVideo-%@.mov", [formater stringFromDate:[NSDate date]]]];
        
//        JFLog(@"resultPath = %@",resultPath);
        
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             if (exportSession.status == AVAssetExportSessionStatusCompleted) {
                 
                 NSData *data = [NSData dataWithContentsOfFile:resultPath];
                 
                 float memorySize = (float)data.length / 1024 / 1024;
//                 JFLog(@"视频压缩后大小 %f", memorySize);
                 
                 resultPathBlock (resultPath, memorySize);
                 
             } else {
                 
//                 JFLog(@"压缩失败");
             }
             
         }];
        
    } else {
//        JFLog(@"不支持 %@ 格式的压缩", compressionType);
    }
}



+ (float)countVideoTotalMemorySizeWithURL:(NSURL *)url {
    NSData *data = [NSData dataWithContentsOfURL:url];
    CGFloat totalSize = (float)data.length / 1024 / 1024;
    return totalSize;
}

+ (void)removeCompressedVideoFromDocuments {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:CompressionVideoPaht]) {
        [[NSFileManager defaultManager] removeItemAtPath:CompressionVideoPaht error:nil];
    }
}


//             switch (exportSession.status) {
//
//                 case AVAssetExportSessionStatusUnknown:
//
//                     JFLog(@"AVAssetExportSessionStatusUnknown");
//
//                     break;
//
//                 case AVAssetExportSessionStatusWaiting:
//
//                     JFLog(@"AVAssetExportSessionStatusWaiting");
//
//                     break;
//
//                 case AVAssetExportSessionStatusExporting:
//
//                     JFLog(@"AVAssetExportSessionStatusExporting");
//
//                     break;
//
//                 case AVAssetExportSessionStatusCompleted:
//
//                 {   JFLog(@"---------AVAssetExportSessionStatusCompleted");
//
//                     NSData *data = [NSData dataWithContentsOfFile:resultPath];
//
//                     float memorySize = (float)data.length / 1024 / 1024;
//                     JFLog(@"视频压缩后大小 %f", memorySize);
//
//                     resultPathBlock (resultPath, totalSize, memorySize);
//
//                 }
//                     break;
//
//                 case AVAssetExportSessionStatusFailed:
//
//                     JFLog(@"AVAssetExportSessionStatusFailed");
//
//                     break;
//                 case AVAssetExportSessionStatusCancelled:
//
//                     JFLog(@"AVAssetExportSessionStatusCancelled");
//
//                     break;
//             }
//


@end
