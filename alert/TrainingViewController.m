
#import "TrainingViewController.h"
#import "ExerciseViewController.h"
#import "AddApproachViewController.h"
#import "TimerViewController.h"
#import "DataModel.h"
#import "const.h"

@interface TrainingViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextField *smallPeriod;
@property (weak, nonatomic) IBOutlet UITextField *largePeriod;

@end

@implementation TrainingViewController

static NSString * const TIMER_SEGUE = @"startTimer";

- (IBAction)addApproach:(UIButton *)sender {
  [self performSegueWithIdentifier:ADD_APPROACH_SEGUE sender:nil];
}

- (IBAction)deleteTraining:(UIButton *)sender {
  [[DataModel sharedInstance] deleteTraining:self.training];
  [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UPDATE object:nil];
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)runTraining:(UIButton *)sender {
  [self performSegueWithIdentifier:TIMER_SEGUE sender:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.name.text = self.training.name;
  self.largePeriod.text = [[NSNumber numberWithUnsignedInteger:self.training.largePeriod] stringValue];
  self.smallPeriod.text = [[NSNumber numberWithUnsignedInteger:self.training.smallPeriod] stringValue];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(refresh)
                                               name:NOTIFICATION_UPDATE
                                             object:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refresh {
  [self.table reloadData];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
    [self.training deleteApproach:approach];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
  [self performSegueWithIdentifier:EXERCISE_SEGUE sender:approach];
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:EXERCISE_SEGUE]) {
    NSIndexPath *indexPath = [self.table indexPathForCell:sender];
    Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
    ExerciseViewController *dst = segue.destinationViewController;
    dst.approach = approach;
  } else if ([segue.identifier isEqualToString:ADD_APPROACH_SEGUE]) {
    if ([segue.destinationViewController class] == [AddApproachViewController class]) {
      AddApproachViewController *dst = segue.destinationViewController;
      dst.training = self.training;
    }
  } else if ([segue.identifier isEqualToString:TIMER_SEGUE]) {
    if ([segue.destinationViewController class] == [TimerViewController class]) {
      TimerViewController *dst = segue.destinationViewController;
      dst.training = self.training;
    }
  }
}

- (IBAction)onLargePeriod:(UITextField *)sender {
  self.training.largePeriod = [sender.text integerValue];
  [[DataModel sharedInstance] saveUserDefaultsTrainings];
}

- (IBAction)onSmallPeriod:(UITextField *)sender {
  self.training.smallPeriod = [sender.text integerValue];
  [[DataModel sharedInstance] saveUserDefaultsTrainings];
}

@end
