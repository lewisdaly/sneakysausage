//
//  IndustryViewController.m
//  GovHack
//
//  Created by Lewis Daly on 4/07/2015.
//  Copyright (c) 2015 Lewis Daly. All rights reserved.
//

#import "IndustryViewController.h"
#import <TWRCharts/TWRChart.h>
#import "ViewUtils.h"
#import "GHData.h"
#import "IndustryTableViewCell.h"
#import "OccupationViewController.h"

#define CELL_ID @"CellId"


@interface IndustryViewController () <UITableViewDataSource, UITableViewDelegate>

@property UIWebView *webView;
@property TWRChartView *chartView;
@property UITableView *tableView;
@property (nonatomic, strong) NSDictionary *industry;
@property (nonatomic, strong) NSArray *topOccupations;
@property (nonatomic, strong) NSNumber *totalOccupationCount;
@property (nonatomic, strong) UIView *reportView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *colors;

//ReportView Elements
@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation IndustryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[IndustryTableViewCell class] forCellReuseIdentifier:CELL_ID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.scrollView addSubview:self.tableView];
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
    [self loadPieChart];
    
    [self.tableView setFrame:CGRectMake(_chartView.right, _chartView.top, _chartView.width, _chartView.height)];

    self.reportView.frame = CGRectMake(padding, _chartView.bottom + padding, self.view.width - 2*padding, 500);
    self.titleLabel.frame = CGRectMake(0, 0, 100, 100);
    self.titleLabel.width = self.reportView.width/2;
    self.titleLabel.center = self.reportView.center;
    self.titleLabel.top = padding;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setIndustry:(NSDictionary *)industry withName:(NSString *)name
{
    //TODO: Set up the views etc.
    self.title = name;
    
    NSMutableDictionary *mutableIndustry = [[NSMutableDictionary alloc] initWithDictionary:industry];
    NSDictionary *occupations = [GHData sharedInstance].occupations;
    
    NSMutableArray *topValues = [[NSMutableArray alloc] initWithCapacity:5];
    int total = 0;
    
    for (int i = 0; i < 7; i++)
    {
        int maxValue = 0;
        NSString *maxKey = @"";
        
        for (id key in mutableIndustry)
        {
            int value = (int)mutableIndustry[key];
            total = total + value;
            if (value > maxValue)
            {
                maxValue = value;
                maxKey = (NSString *)key;
            }
        }
        NSString *occupationName = occupations[maxKey][@"industryName"];
        
        NSDictionary *entry = [[NSDictionary alloc] initWithObjectsAndKeys:occupationName, @"occupationName", [NSNumber numberWithInt:maxValue], @"maxValue", nil];
        [topValues addObject:entry];
        [mutableIndustry removeObjectForKey:maxKey];
    }
    
    //remove the total: (at index 0)
    [topValues removeObjectAtIndex:0];
    
    self.topOccupations = [[NSArray alloc] initWithArray:topValues];
    self.totalOccupationCount = [NSNumber numberWithInt:total];
}

- (void)loadPieChart
{
    // Values
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.topOccupations)
    {
//        NSNumber *value = dict[@"maxValue"];
        [values addObject:dict[@"maxValue"]];
    }
    
    
    // Colors
    UIColor *color1 = [UIColor colorWithHue:0.5 saturation:0.6 brightness:0.6 alpha:1.0];
    UIColor *color2 = [UIColor colorWithHue:0.6 saturation:0.6 brightness:0.6 alpha:1.0];
    UIColor *color3 = [UIColor colorWithHue:0.7 saturation:0.6 brightness:0.6 alpha:1.0];
    UIColor *color4 = [UIColor colorWithHue:0.8 saturation:0.6 brightness:0.6 alpha:1.0];
    UIColor *color5 = [UIColor colorWithHue:0.8 saturation:0.6 brightness:0.6 alpha:1.0];

    self.colors = @[color1, color2, color3, color4, color1, color2];
    
    // Doughnut Chart
    TWRCircularChart *pieChart = [[TWRCircularChart alloc] initWithValues:values
                                                                   colors:_colors
                                                                     type:TWRCircularChartTypeDoughnut
                                                                 animated:YES];
    
    // You can even leverage callbacks when chart animation ends!
    [_chartView loadCircularChart:pieChart withCompletionHandler:^(BOOL finished)
    {
        
        if (finished)
        {
            NSLog(@"Animation finished!!!");
        }
    }];
    

}

#pragma mark - TableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.topOccupations.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IndustryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dict = [self.topOccupations objectAtIndex:indexPath.row];
    [cell.titleLabel setText:dict[@"occupationName"]];
    NSNumber *maxValue = dict[@"maxValue"];
    [cell.valueLabel setText:[NSString stringWithFormat:@"%d", maxValue.intValue]];
    [cell.colorView setBackgroundColor:[self.colors objectAtIndex:indexPath.row]];
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Load the Occupation VC
    OccupationViewController *occupationVC = [[OccupationViewController alloc] init];
    NSDictionary *dict = [self.topOccupations objectAtIndex:indexPath.row];

    NSString *occupationName = dict[@"occupationName"];
    [occupationVC setOccupation:occupationName];
    
    self.title = occupationName;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:occupationVC animated:YES];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    cell.textLabel.font =[UIFont fontWithName:@"AvenirNext-Regular" size:14];
    //    cell.backgroundColor = [UIColor clearColor];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



@end
