//
//  ScanResultsViewController.m
//  Bar Gain
//
//  Created by Nupur Mittal on 10/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import "ScanResultsViewController.h"

@interface ScanResultsViewController (){
    IBOutlet UILabel *labelItem;
    IBOutlet UIView *viewInputBox;
    IBOutlet UIImageView *imageViewItem;
    IBOutlet UIButton *buttonDiscount;

    IBOutletCollection(UITextField) NSArray *textFieldCollection;

    NSArray *arrayKeys;
    NSArray *arrayValues;
    NSString *userEmail;
    NSString *userTel;
    NSString *storeId;
    Product *product;
    NSDictionary *article;
}

@end

@implementation ScanResultsViewController
@synthesize results = _results;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    product = [[Product alloc] init];
    
    //defaults
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userTel"] length]>1) {
        userTel = [[NSUserDefaults standardUserDefaults] valueForKey:@"userTel"];
    }else{
        userTel = @"";
        
    }
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userEmail"] length]>1) {
        userEmail = [[NSUserDefaults standardUserDefaults] valueForKey:@"userEmail"];
    }else{
        userEmail = @"";
    }


    storeId = [Store getSelectedStore][@"store_id"];
    
    if (!_results) {
        _results = @"99999999";
    }
    [labelItem setText:[NSString stringWithFormat:@"Item Id : %@", _results]];
    [APIClass getProductDetails:@"103108"];
    article = [NSDictionary dictionaryWithDictionary:[product getProductDetailsForBarCode:_results]];
    arrayKeys = @[@"Brand",@"Type",@"Quantity",@"Cost"];
    arrayValues = @[article[@"brand"],article[@"type"],article[@"quantity"],article[@"cost"]];

    [imageViewItem setImage:[UIImage imageNamed:article[@"image_name"]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setResults:(NSString *)results{
    if([results isEqualToString:@"Cannot Scan!"]) results=@"99999999";
    _results=results;
}


-(IBAction)tappedButtonPurchase:(id)sender{
    //
    NSString *msgString = @"Please take item to store check-out area. \n Thank-you.";
    UIAlertView *alertPurchase = [[UIAlertView alloc] initWithTitle:@"" message:msgString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alertPurchase.layer setBackgroundColor:[[UIColor redColor] CGColor]];
    [alertPurchase show];
}

-(IBAction)discountTappped:(id)sender{
    [buttonDiscount setSelected:![buttonDiscount isSelected]];
    [viewInputBox setHidden:![buttonDiscount isSelected]];
    [self checkAndGetTextFieldTexts];
}
-(IBAction)tapGestureRecognizer:(UIGestureRecognizer *)gesture{
    [self discountTappped:buttonDiscount];
}

-(void)uploadDetailsPurchase{
    NSDictionary *parameters =  @{ @"id": @"0",
                                   @"type": @"userenquiry",
                                   @"userid": @"1",
                                   @"Fields" : @[
                                           @{@"id" :@"0", @"fieldkey" : @"purchase", @"fieldvalue" : @"1"},
                                           @{@"id" :@"0", @"fieldkey" : @"productid", @"fieldvalue" : _results},
                                           @{@"id" :@"0", @"fieldkey" : @"storeid", @"fieldvalue" : storeId},
                                           @{@"id" :@"0", @"fieldkey" : @"timestamp", @"fieldvalue" : [self getUTCTime]}
                                           ]};
    
    [APIClass uploadWithParameters:parameters];
    
}

-(void)uploadDetailsOk{
    
    NSDictionary *parameters =  @{ @"id": @"0",
                                   @"type": @"userenquiry",
                                   @"userid": @"1",
                                   @"Fields" : @[
                                           @{@"id":@"0",@"fieldkey":@"cellno",@"fieldvalue": userTel},
                                           @{@"id" :@"0", @"fieldkey" : @"email", @"fieldvalue" : userEmail},
                                           @{@"id" :@"0", @"fieldkey" : @"discount", @"fieldvalue" : @"1"},
                                           @{@"id" :@"0", @"fieldkey" : @"productid", @"fieldvalue" : _results},
                                           @{@"id" :@"0", @"fieldkey" : @"storeid", @"fieldvalue" : storeId},
                                           @{@"id" :@"0", @"fieldkey" : @"timestamp", @"fieldvalue" : [self getUTCTime]}
                                           ]};

    [APIClass uploadWithParameters:parameters];
}

-(void)uploadDetailsNoThanks{
    NSDictionary *parameters =  @{ @"id": @"0",
                                   @"type": @"userenquiry",
                                   @"userid": @"1",
                                   @"Fields" : @[
                                           @{@"id" :@"0", @"fieldkey" : @"nothanks", @"fieldvalue" : @"1"},
                                           @{@"id" :@"0", @"fieldkey" : @"productid", @"fieldvalue" : _results},
                                           @{@"id" :@"0", @"fieldkey" : @"storeid", @"fieldvalue" : storeId},
                                           @{@"id" :@"0", @"fieldkey" : @"timestamp", @"fieldvalue" : [self getUTCTime]}
                                           ]};
    
    [APIClass uploadWithParameters:parameters];
    
}


-(IBAction)tappedButtonOk:(id)sender{
    [self getTextFieldTexts];
    [self discountTappped:buttonDiscount];
    [self uploadDetailsOk];
}

-(IBAction)tappedButtonNoThanks:(id)sender{
    [self.tabBarController setSelectedIndex:3];
    [self uploadDetailsNoThanks];
}

-(void)getTextFieldTexts{

    for (UITextField *textField in textFieldCollection) {
        if ([textField tag]==1) {
            [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"userTel"];
            userTel = textField.text;
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"userEmail"];
            userEmail = textField.text;
        }
    }

}

-(void)checkAndGetTextFieldTexts{
    
    for (UITextField *textField in textFieldCollection) {
        if ([textField tag]==1) {
            if ([userTel length]>1) {
                textField.text = userTel;
            }
        }else{
            if([userEmail length]>1){
                textField.text = userEmail;
            }
        }
    }
    
}

-(NSString *)getUTCTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ddMMyyy HH:mm:ss"];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"UTC"];
    [formatter setTimeZone:zone];
    
    return [formatter stringFromDate:[NSDate date]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - text field delegates

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
//- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(textField.text);
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self getTextFieldTexts];
    [textField resignFirstResponder];
    return YES;
}// called when 'return' key pressed. return NO to ignore.


#pragma mark - Table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayKeys.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = arrayKeys[indexPath.row];
    cell.detailTextLabel.text = arrayValues[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *labelSection =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 50)];
    [labelSection setText:@"Overview"];
    [labelSection setFont:[UIFont boldSystemFontOfSize:20.0]];
    [labelSection setCenter:CGPointMake(labelSection.center.x, view.center.y)];
    
    [view addSubview:labelSection];
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *labelFooter =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    [labelFooter setText:@"The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog"];
    [labelFooter setNumberOfLines:4];
    [labelFooter setLineBreakMode:NSLineBreakByWordWrapping];

    return labelFooter;
}

#pragma mark - AlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self uploadDetailsPurchase];
    }
}


@end
