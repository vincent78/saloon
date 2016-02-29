//
//  SNFontImgViewController.m
//  saloon
//
//  Created by vincent on 16/1/18.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNFontImgViewController.h"
#import "SNFontImgCell.h"

@interface SNFontImgViewController()
{
    UICollectionView *colView;
    NSArray *items;
    NSString *cellNibName;
}

@end

@implementation SNFontImgViewController



-(void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareItems];
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    colView = [[UICollectionView alloc] initWithFrame:self.contentFrame collectionViewLayout:flowLayout];
    colView.backgroundColor = [FTAppHelper sharedInstance].vcBackGroundColor;
    colView.dataSource = self;
    colView.delegate = self;
    [self.view addSubview:colView];
    cellNibName = NSStringFromClass([SNFontImgCell class]);
    [colView registerNib:[UINib nibWithNibName:cellNibName bundle:nil]
     forCellWithReuseIdentifier:cellNibName];
}

-(void) prepareItems
{
    if (!items || items.count == 0)
    {
        NSString *tmpFileFullName = [[NSBundle mainBundle] pathForResource:@"FontImgItem" ofType:@"json"];
        if ([FTFileUtil exist:tmpFileFullName])
            items = [FTFileUtil readArrayFromFile:tmpFileFullName];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(180, 80);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return items? items.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SNFontImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellNibName forIndexPath:indexPath];
    [cell setFontFamily:[UIFont fontWithName:@"common" size:24] withColor:[UIColor blackColor]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    SNFontImgCell *tmpCell = (SNFontImgCell *)cell;
    [tmpCell initWithImg:@"\U0000e62c" withTxt1:@"txt1" withTxt2:@"txt2" withTxt3:@"txt3"];
}





@end
