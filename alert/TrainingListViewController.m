
#import "TrainingListViewController.h"
#import "AddTrainingViewController.h"
#import "TrainingViewController.h"
#import "DataModel.h"

@interface TrainingListViewController () <AddTrainingViewControllerDelegate>
@end

@implementation TrainingListViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return DataModel.sharedInstance.trainings.count;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableView * __weak weakTableView = tableView;
  UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                        title:@"Edit"
                                                                      handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {

                                                                        UITableView *localTableView = weakTableView;
                                                                        [localTableView setEditing:NO animated:YES];

                                                                        NSArray *trainings = [[DataModel sharedInstance] trainings];
                                                                        Training *training = [trainings objectAtIndex:indexPath.row];
                                                                        
                                                                        [self performSegueWithIdentifier:@"EditTrainingViewController" sender:training];
                                                                      }];
  editAction.backgroundColor = [UIColor blueColor];
  UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                          title:@"Delete"
                                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                          NSArray *trainings = [[DataModel sharedInstance] trainings];
                                                                          Training *training = [trainings objectAtIndex:indexPath.row];
                                                                          [[DataModel sharedInstance] deleteTraining:training];
                                                                          UITableView *localTableView = weakTableView;
                                                                          [localTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }];
  deleteAction.backgroundColor = [UIColor redColor];
  return @[deleteAction,editAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSArray *trainings = [[DataModel sharedInstance] trainings];
    Training *training = [trainings objectAtIndex:indexPath.row];
    [[DataModel sharedInstance] deleteTraining:training];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrainingListViewCell"];
  NSArray *trainings = [[DataModel sharedInstance] trainings];
  Training *training = [trainings objectAtIndex:indexPath.row];
  cell.textLabel.text = training.name;
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"TrainingViewController"]) {
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Training *training = [DataModel.sharedInstance.trainings objectAtIndex:indexPath.row];
    TrainingViewController *trainingViewController = segue.destinationViewController;
    trainingViewController.training = training;
  } else if ([segue.identifier isEqualToString:@"AddTrainingViewController"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    AddTrainingViewController *addTrainingViewController = [[navigationController viewControllers] objectAtIndex:0];
    addTrainingViewController.delegate = self;
  } else if ([segue.identifier isEqualToString:@"EditTrainingViewController"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    AddTrainingViewController *addTrainingViewController = [[navigationController viewControllers] objectAtIndex:0];
    addTrainingViewController.delegate = self;
    addTrainingViewController.training = sender;
  }
}

- (void)addTrainingViewControllerDidCancel:(AddTrainingViewController *)controller {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addTrainingViewController:(AddTrainingViewController *)controller didAddTraining:(Training *)training {
  [[DataModel sharedInstance] addTraining:training];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:DataModel.sharedInstance.trainings.count - 1 inSection:0];
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addTrainingViewController:(AddTrainingViewController *)controller didEditTraining:(Training *)training {
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
