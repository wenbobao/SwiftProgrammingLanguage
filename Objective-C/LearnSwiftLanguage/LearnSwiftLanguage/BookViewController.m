//
//  ViewController.m
//  LearnSwiftLanguage
//
//  Created by bob on 16/11/9.
//  Copyright © 2016年 __company__. All rights reserved.
//

#import "BookViewController.h"
#import "BookTitleCell.h"
#import <SafariServices/SafariServices.h>

@interface BookViewController () <UIWebViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"swift基础语法";
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTitleCell" bundle:nil] forCellReuseIdentifier:@"BookTitleCell"];
    
    self.webView = [[UIWebView alloc]init];
    self.webView.delegate = self;
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
    
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    self.dataSource = data[@"swift"];
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.title = @"内容刷新中";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = @"swift基础语法";
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.title = @"内容获取失败";
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTitleCell" forIndexPath:indexPath];
    cell.name.text = self.dataSource[indexPath.row][@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSURL *url = [NSURL URLWithString:self.dataSource[indexPath.row][@"url"]];
    
    [self presentViewController:[[SFSafariViewController alloc]initWithURL:url] animated:YES completion:NULL];
    
}

@end
