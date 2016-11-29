
#import "TrainingListViewController.h"
#import "TrainingViewController.h"
#import "DataModel.h"

@implementation TrainingListViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return DataModel.sharedInstance.trainings.count;
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

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Training *training = [[DataModel sharedInstance].trainings objectAtIndex:indexPath.row];
  [self performSegueWithIdentifier:@"TrainingViewController" sender:training];
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"TrainingViewController"]) {
    //UINavigationController *navigationController = segue.destinationViewController;
    //TrainingViewController *trainingViewController = [[navigationController viewControllers] objectAtIndex:0];
    TrainingViewController *trainingViewController = segue.destinationViewController;
    UITableViewCell *cell = sender;
    trainingViewController.training = [DataModel.sharedInstance.trainings objectAtIndex:0];
  } else if ([segue.identifier isEqualToString:@"AddTraining"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    AddTrainingViewController *addTrainingViewController = [[navigationController viewControllers] objectAtIndex:0];
    addTrainingViewController.delegate = self;
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

@end
