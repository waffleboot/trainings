//
//  ViewController.m
//  alert
//
//  Created by Андрей on 22.11.16.
//  Copyright © 2016 Andrei Yangabishev. All rights reserved.
//

#import "ViewController.h"
#import "MyCellTableViewCell.h"

@interface ViewController ()
@end

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@end

@implementation ViewController

NSArray *data;

- (void)viewDidLoad {
  [super viewDidLoad];
  data = [NSArray arrayWithObjects:@"one", @"two", @"three", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *text = [data objectAtIndex:indexPath.row];
  MyCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellTableViewCell"];
  if (!cell) {
    cell = [[MyCellTableViewCell alloc] init];
  }
  cell.label.text = text;
  return cell;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
