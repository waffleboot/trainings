
#import "ExerciseViewController.h"

@interface ExerciseViewController () <AddExerciseViewControllerDelegate>

@end

@implementation ExerciseViewController

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.approach removeExercise:indexPath.row];
    [self.tableView reloadData];
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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  [self.approach moveExerciseFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (void)addExerciseViewControllerDidCancel:(AddExerciseViewController *)controller {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addExerciseViewController:(AddExerciseViewController *)controller didAddExercise:(NSArray<NSNumber*> *)exercises {
  for (NSNumber *i in exercises) {
    [self.approach addExercise:[i integerValue]];
  }
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"AddExerciseViewController"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    AddExerciseViewController *addExerciseViewController = [[navigationController viewControllers] objectAtIndex:0];
    addExerciseViewController.delegate = self;
  }
}

@end

@implementation ExerciseViewCell

@end
