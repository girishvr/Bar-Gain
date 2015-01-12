//
//  ScanViewController.m
//  Bar Gain
//
//  Created by Nupur Mittal on 04/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpScanner];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startScanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backButton{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - AVCapture Metadata delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
//    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        //        NSLog(@"--%@",metadata.description);
        //        NSLog(@"=%@",[(AVMetadataMachineReadableCodeObject *)metadata stringValue]);
        
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                //                highlightViewRect = barCodeObject.bounds;
                //                _highlightView.frame = highlightViewRect;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (detectionString != nil)
        {
            break;
        }
        else{
            detectionString = @"Cannot Scan!";
        }
    }
    
    NSLog(@"%@",detectionString);
    [self scanCompleted:detectionString];
    
}

-(void)setUpScanner{
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error --- %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.view.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];
    
}


//-(IBAction)takePicture:(id)sender{
//    
//    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
//    videoOutput.videoSettings = @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
//    [_session addOutput:videoOutput];
//    
//    dispatch_queue_t queue = dispatch_queue_create("MyQueue", NULL);
//    [videoOutput setSampleBufferDelegate:self queue:queue];
////    dispatch_release(queue);
////    Then, implement the delegate method below to get your image snapshot:
//    
//}
//- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
//    
//    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
//    // Add your code here that uses the image.
//    dispatch_async(dispatch_get_main_queue(), ^{
////        _imageView.image = image;
//    });
//}
//

-(void)startScanner{
    [_session startRunning];
}
-(void)stopScanning{
    [_session stopRunning];
//    [_prevLayer removeFromSuperlayer];
}

-(void)scanCompleted:(NSString *)result{
    [self stopScanning];
    if (result) {
        //load scan result page
        ScanResultsViewController *scanResultsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ScanResultsVC"];
        scanResultsVC.results = result;
        [self.navigationController pushViewController:scanResultsVC animated:YES];
        
    }
    
}


@end
