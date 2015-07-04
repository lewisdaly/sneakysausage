//
//  ViewController.m
//  GovHack
//
//  Created by Lewis Daly on 4/07/2015.
//  Copyright (c) 2015 Lewis Daly. All rights reserved.
//

#import "ViewController.h"
#import "CTCollectionViewCell.h"
#import "GHData.h"
#import "IndustryViewController.h"

#define CELL_ID @"CellIdentifier"


@interface ViewController () <UICollectionViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *titleView; //left static panel
@property (nonatomic, strong) UILabel *titleText;
@property (nonatomic, strong) UILabel *subtitleText;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UILabel *contentLabel;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerClass:[CTCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];

    self.collectionView.backgroundColor = UIColorFromRGB(0xfffeff);
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //TODO: Load a CV Cell
    //TODO: Load the data
    
    //Set up the side panel
    self.titleView = [[UIView alloc] init];
    self.titleView.backgroundColor = UIColorFromRGB(0x573e7e);
    
    self.searchBar = [[UISearchBar alloc] init];
    [self.searchBar setPlaceholder:@"Search"];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.titleText = [[UILabel alloc] init];
    [self.titleText setText:@"Industries"];
    [self.titleText setFont:[UIFont fontWithName:@"TrebuchetMS" size:45]];
    self.titleText.backgroundColor = [UIColor clearColor];
    [self.titleText setTextColor:UIColorFromRGB(0xfff2ff)];
    
    self.subtitleText = [[UILabel alloc] init];
    [self.subtitleText setText:@"Select an Industry"];
    [self.subtitleText setFont:[UIFont fontWithName:@"TrebuchetMS" size:25]];
    self.subtitleText.backgroundColor = [UIColor clearColor];
    [self.subtitleText setTextColor:UIColorFromRGB(0x8c74a6)];

    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentLabel setText:@"_____ gives SA businesses insights into their industry. Using a variety of Open Data, "];
    [self.contentLabel setFont:[UIFont fontWithName:@"TrebuchetMS" size:17]];
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.numberOfLines = 9;
    [self.contentLabel setTextColor:UIColorFromRGB(0x8c74a6)];
    [self.contentLabel setTextAlignment:NSTextAlignmentJustified];

    
    
    [self.titleView addSubview:self.searchBar];
    [self.titleView addSubview:self.titleText];
    [self.titleView addSubview:self.subtitleText];
    [self.titleView addSubview:self.contentLabel];
    
    
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.titleView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Sneaky Spicy Sausage";

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.title = @"Sneaky Spicy Sausage";
    
    int panelWidth = 250;
    self.titleView.frame = CGRectMake(0, self.navigationController.navigationBar.bottom, panelWidth, self.view.height);
    self.collectionView.frame = CGRectMake(panelWidth, 0, self.view.width - panelWidth, self.view.height);
    
    
    int padding = 20;
    int smallPadding = 5;
    self.searchBar.frame = CGRectMake(smallPadding, smallPadding, panelWidth - smallPadding*2, 40);
    self.titleText.frame = CGRectMake(padding, _searchBar.bottom + padding, panelWidth, 50);
    self.subtitleText.frame = CGRectMake(padding, self.titleText.bottom, panelWidth, 50);
    self.contentLabel.frame = CGRectMake(padding, self.subtitleText.bottom + padding, panelWidth - padding, 300);
    
    [self.contentLabel sizeToFit];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CollectionViewDataSource

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    GHData *data = [GHData sharedInstance];
    return data.industryNames.count;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    NSArray *industryNames = [GHData sharedInstance].industryNames;
    NSString *industryName = [industryNames objectAtIndex: indexPath.item];
    [cell.titleLabel setText:industryName];

    
    cell.backgroundColor = indexPath.row % 2 == 0 ? UIColorFromRGB(0xf4f4f4) : UIColorFromRGB(0xe8e8e8);
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 150);
}

- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(60, 60, 60, 60);
}


#pragma mark - CollectionViewDelegate

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    SectorViewController *sectorVC = [[SectorViewController alloc] init];
//    [sectorVC setUpForIndex:indexPath.row];
//    self.title = @"Fields";
//    [self.navigationController pushViewController:sectorVC animated:YES];
    
    IndustryViewController *industryVC = [[IndustryViewController alloc] init];
    NSArray *industryNames = [GHData sharedInstance].industryNames;
    NSString *industryName = [industryNames objectAtIndex: indexPath.item];
    NSDictionary *industryDict = [[GHData sharedInstance].data objectForKey:industryName];
    [industryVC setIndustry: industryDict withName:industryName];
    
    self.title = industryName;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:industryVC animated:YES];
    
}



@end
