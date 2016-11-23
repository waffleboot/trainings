
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.training.approaches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TrainingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrainingViewCell"];
  if (!cell) {
    cell = [[TrainingViewCell alloc] init];
  }
  Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
  cell.label.text = approach.name;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
  [self performSegueWithIdentifier:EXERCISE_SEGUE sender:approach];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:EXERCISE_SEGUE]) {
    if ([segue.destinationViewController class] == [ExerciseViewController class]) {
      if ([sender class] == [Approach class]) {
        ExerciseViewController *dst = segue.destinationViewController;
        dst.approach = sender;
      }
    }
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
}

- (IBAction)onSmallPeriod:(UITextField *)sender {
  self.training.smallPeriod = [sender.text integerValue];
}

@end

@implementation TrainingViewCell

@end
