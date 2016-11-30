//
//  AddExerciseViewController.m
//  alert
//
//  Created by Андрей on 30.11.16.
//  Copyright © 2016 Andrei Yangabishev. All rights reserved.
//

#import "AddExerciseViewController.h"

@interface AddExerciseViewController ()

@end

@implementation AddExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  return section == 0 ? self.footer1 : self.footer2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 55;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)addRepeat:(id)sender {
  NSString *repeatValue = self.singleRepeat.text;
  NSString *repeatCount = self.singleRepeatCount.text;
  if (repeatValue) {
    NSNumber *repeat = [NSNumber numberWithInteger:labs([repeatValue integerValue])];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:repeat];
    if (repeatCount) {
      NSInteger count = labs([repeatCount integerValue]);
      for (int i = 1; i < count; ++i) {
        [array addObject:repeat];
      }
    }
    [self.delegate addExerciseViewController:self didAddExercise:array];
  }
}

- (void)addRange:(id)sender {
  NSString *repeatFrom = self.rangeRepeatFrom.text;
  NSString *repeatTo   = self.rangeRepeatTo.text;
  if (repeatFrom && repeatTo) {
    unsigned from = (unsigned) labs([repeatFrom integerValue]);
    unsigned to   = (unsigned) labs([repeatTo integerValue]);
    NSMutableArray *array = [NSMutableArray array];
    if (from < to) {
      for (int i = from; i <= to; ++i) {
        [array addObject:[NSNumber numberWithInt:i]];
      }
    } else {
      for (int i = from; i >= to; --i) {
        [array addObject:[NSNumber numberWithInt:i]];
      }
    }
    [self.delegate addExerciseViewController:self didAddExercise:array];
  }
}

- (void)cancel:(id)sender {
  [self.delegate addExerciseViewControllerDidCancel:self];
}

@end
