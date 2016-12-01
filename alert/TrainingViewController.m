
#import "TrainingViewController.h"
#import "ExerciseViewController.h"
#import "AddApproachViewController.h"
#import "TimerViewController.h"
#import "DataModel.h"

@interface TrainingViewController () <UITableViewDataSource,UITableViewDelegate,AddApproachViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UITextField *smallPeriod;
@property (strong, nonatomic) IBOutlet UITextField *largePeriod;

@end

@implementation TrainingViewController

static NSString * const TIMER_SEGUE = @"startTimer";

- (IBAction)runTraining:(UIButton *)sender {
  [self performSegueWithIdentifier:TIMER_SEGUE sender:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.largePeriod.text = [[NSNumber numberWithUnsignedInteger:self.training.largePeriod] stringValue];
  self.smallPeriod.text = [[NSNumber numberWithUnsignedInteger:self.training.smallPeriod] stringValue];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"ExerciseViewController"]) {
    NSIndexPath *indexPath = [self.table indexPathForCell:sender];
    Approach *approach = [self.training.approaches objectAtIndex:indexPath.row];
    ExerciseViewController *dst = segue.destinationViewController;
    dst.approach = approach;
  } else if ([segue.identifier isEqualToString:@"AddApproachViewController"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    AddApproachViewController *addApproachViewController = [[navigationController viewControllers] objectAtIndex:0];
    addApproachViewController.delegate = self;
  } else if ([segue.identifier isEqualToString:TIMER_SEGUE]) {
    if ([segue.destinationViewController class] == [TimerViewController class]) {
      TimerViewController *dst = segue.destinationViewController;
      dst.training = self.training;
    }
  }
}

- (void)addApproachViewControllerDidCancel:(AddApproachViewController *)controller {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addApproachViewController:(AddApproachViewController *)controller didAddApproach:(Approach *)approach {
  [self.training addApproach:approach];
  [self.table reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
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
