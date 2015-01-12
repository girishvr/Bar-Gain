//
//  ScanViewController.h
//  Bar Gain
//
//  Created by Nupur Mittal on 04/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ScanResultsViewController.h"
@interface ScanViewController : CommonBaseClass<AVCaptureMetadataOutputObjectsDelegate>{
    UIView *_highlightView;
    NSString *detectionString;
}
@property(nonatomic, strong)AVCaptureSession *session;
@property(nonatomic, strong)AVCaptureDevice *device;
@property(nonatomic, strong)AVCaptureDeviceInput *input;
@property(nonatomic, strong)AVCaptureMetadataOutput *output;
@property(nonatomic, strong)AVCaptureVideoPreviewLayer *prevLayer;


@end
