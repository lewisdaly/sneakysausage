//
//  OccupationViewController.m
//  GovHack
//
//  Created by Lewis Daly on 4/07/2015.
//  Copyright (c) 2015 Lewis Daly. All rights reserved.
//

#import "OccupationViewController.h"
#import <TWRCharts/TWRChart.h>
#import "ViewUtils.h"
#import "GHData.h"
#import "IndustryTableViewCell.h"

#define CELL_ID @"CellId"


@interface OccupationViewController ()

@property UIWebView *webView;
@property TWRChartView *chartView;
@property (nonatomic, strong) NSDictionary *industry;
@property (nonatomic, strong) NSArray *topOccupations;
@property (nonatomic, strong) NSNumber *totalOccupationCount;
@property (nonatomic, strong) UIView *reportView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *colors;

//ReportView Elements
@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation OccupationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.reportView = [[UIView alloc] init];
    self.reportView.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:self.reportView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleLabel setText:@"Industry Insights"];
    [self.reportView addSubview:self.titleLabel];

}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    int padding = 30;
    self.scrollView.frame = self.view.bounds;
    [self.scrollView setContentSize:CGSizeMake(self.view.width, 1500)];
    
    _chartView = [[TWRChartView alloc] initWithFrame:CGRectMake(padding, self.navigationController.navigationBar.bottom + padding, (self.view.width-2*padding)/2, (self.view.width-2*padding)/2)];
    
    [self.scrollView addSubview:_chartView];

    
    self.reportView.frame = CGRectMake(padding, _chartView.bottom + padding, self.view.width - 2*padding, 500);
    self.titleLabel.frame = CGRectMake(0, 0, 100, 100);
    self.titleLabel.width = self.reportView.width/2;
    self.titleLabel.center = self.reportView.center;
    self.titleLabel.top = padding;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadLineChart];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setOccupation:(NSString *)name
{
    //TODO: Set up the views etc.
    self.title = name;
    
}

- (void)loadLineChart
{
    // Build chart data
    TWRDataSet *dataSet1 = [[TWRDataSet alloc] initWithDataPoints:@[@10, @15, @5, @15, @5]];
    TWRDataSet *dataSet2 = [[TWRDataSet alloc] initWithDataPoints:@[@5, @10, @5, @15, @10]];
    
    NSArray *labels = @[@"A", @"B", @"C", @"D", @"E"];
    
    TWRLineChart *line = [[TWRLineChart alloc] initWithLabels:labels
                                                     dataSets:@[dataSet1, dataSet2]
                                                     animated:NO];
    // Load data
    [_chartView loadLineChart:line];
}



@end

