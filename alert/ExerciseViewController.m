
#import "ExerciseViewController.h"

@implementation ExerciseViewController

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.approach removeExercise:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.approach.exercises.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ExerciseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExerciseViewCell"];
  NSNumber *count = [self.approach.exercises objectAtIndex:indexPath.row];
  cell.pos.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
  cell.value.text = [NSString stringWithFormat:@"%@", count];
  return cell;
}

- (void)addExerciseViewControllerDidCancel:(AddExerciseViewController *)controller {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addExerciseViewController:(AddExerciseViewController *)controller didAddExercise:(NSArray *)exercises {
  for (NSNumber *i in exercises) {
    [self.approach addExercise:[i integerValue]];
  }
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"AddExercise"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    AddExerciseViewController *addExerciseViewController = [[navigationController viewControllers] objectAtIndex:0];
    addExerciseViewController.delegate = self;
  }
}

@end

@implementation ExerciseViewCell
@end
