//
//  NearByStoresViewController.m
//  Bar Gain
//
//  Created by Nupur Mittal on 17/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import "NearByStoresViewController.h"

@interface NearByStoresViewController (){
    IBOutlet UICollectionView *collectionViewStores;
}
@end

@implementation NearByStoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Store saveStoresData:nil];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [Store getStoresCount];
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind== UICollectionElementKindSectionHeader) {
        StoreLocatorCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        reusableView = headerView;
    }
    return reusableView;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StoresNBCollectionViewCell *cell = (StoresNBCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    int index = (int)indexPath.row%6;
    
    cell.labelStores.text = [NSString stringWithFormat:@"Store %d",index+1];
    [cell.imageViewStores setImage:[UIImage imageNamed:[NSString stringWithFormat:@"store_%d",index]]];
//    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"store_%d",index]]];

    [cell.btnSelectStores setTag:indexPath.row];

//    cell.selected = [Store getIsSelected:indexPath.row];
    [cell.btnSelectStores setSelected:[Store getIsSelected:indexPath.row]];

    if (cell.btnSelectStores.isSelected) {
        cell.alpha = 1;
    }else{
        cell.alpha = 0.8;
    }
    return cell;
}

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    [collectionView.collectionViewLayout invalidateLayout];
//    UICollectionViewCell *__weak cell = [collectionView cellForItemAtIndexPath:indexPath]; // Avoid retain cycles
//    [cell setHighlighted:YES];
//    return YES;
//}
//

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView.collectionViewLayout invalidateLayout];
    UICollectionViewCell *__weak cell = [collectionView cellForItemAtIndexPath:indexPath]; // Avoid retain cycles
//    NSLog(NSStringFromCGSize(cell.frame.size));
    int cellHeight = (int)cell.frame.size.height;
    [self setCell:cell atIndex:indexPath.row  asSelected:!(cellHeight==420)];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView.collectionViewLayout invalidateLayout];
    UICollectionViewCell *__weak cell = [collectionView cellForItemAtIndexPath:indexPath]; // Avoid retain cycles
    [self setCell:cell atIndex:indexPath.row asSelected:NO];
}

-(void)setCell:(UICollectionViewCell *)cell atIndex:(NSInteger )indx asSelected:(BOOL)selected{
    
    void (^animateChangeWidth)() = ^()
    {
        CGRect frame = cell.frame;
        if (selected) {
            frame.size = CGSizeMake(200, 420);
            cell.alpha = 1;

        }else{
            frame.size = CGSizeMake(200, 200);
            cell.alpha = 0.8;
            
        }
        
        cell.frame = frame;
    };
    
    // Animate
    
    [UIView transitionWithView:cell duration:0.1f options: UIViewAnimationOptionCurveLinear animations:animateChangeWidth completion:nil];
    [collectionViewStores bringSubviewToFront:cell];
}

-(IBAction)storeSelected:(UIButton *)sender{

    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [Store setExclusiveTouch:sender.tag];//deselect other buttons
    }else{
        [Store deselectStoreAt:sender.tag];//deselect only that button
    }
    [collectionViewStores reloadData];
    
    [self.tabBarController setSelectedIndex:3];

}

#pragma mark - User functions


@end
