
#import "TrainingViewController.h"
#import "ExerciseViewController.h"
#import "AddApproachViewController.h"
#import "TimerViewController.h"
#import "DataModel.h"

@interface TrainingViewController () <AddApproachViewControllerDelegate>

@end

@implementation TrainingViewController

static NSString * const TIMER_SEGUE = @"startTimer";

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableView * __weak weakTableView = tableView;
  UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                        title:@"Edit"
                                                                      handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                        
                                                                        UITableView *localTableView = weakTableView;
                                                                        [localTableView setEditing:NO animated:YES];
                                                                        
                                                                        Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
                                                                        
                                                                        [self performSegueWithIdentifier:@"EditApproachViewController" sender:approach];
                                                                      }];
  editAction.backgroundColor = [UIColor blueColor];
  UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                          title:@"Delete"
                                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                          
                                                                          Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
                                                                          [self.training deleteApproach:approach];

                                                                          UITableView *localTableView = weakTableView;
                                                                          [localTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                                        }];
  deleteAction.backgroundColor = [UIColor redColor];
  return @[deleteAction,editAction];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.training.approaches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrainingViewCell"];
  Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
  cell.textLabel.text = approach.name;
  return cell;
}

/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
    [self.training deleteApproach:approach];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"ExerciseViewController"]) {
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
    ExerciseViewController *dst = segue.destinationViewController;
    dst.approach = approach;
  } else if ([segue.identifier isEqualToString:@"AddApproachViewController"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    AddApproachViewController *addApproachViewController = [[navigationController viewControllers] objectAtIndex:0];
    addApproachViewController.delegate = self;
  } else if ([segue.identifier isEqualToString:@"EditApproachViewController"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    AddApproachViewController *addApproachViewController = [[navigationController viewControllers] objectAtIndex:0];
    addApproachViewController.delegate = self;
    addApproachViewController.approach = sender;
  } else if ([segue.identifier isEqualToString:TIMER_SEGUE]) {
    if ([segue.destinationViewController class] == [TimerViewController class]) {
      TimerViewController *dst = segue.destinationViewController;
      dst.training = self.training;
    }
  }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  [self.training moveApproachFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (void)addApproachViewControllerDidCancel:(AddApproachViewController *)controller {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addApproachViewController:(AddApproachViewController *)controller didAddApproach:(Approach *)approach {
  [self.training addApproach:approach];
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addApproachViewController:(AddApproachViewController *)controller didEditApproach:(Approach *)approach {
  [[DataModel sharedInstance] saveUserDefaultsTrainings];
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
