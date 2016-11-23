
#import "AddTrainingViewController.h"
#import "AddApproachViewController.h"
#import "TrainingViewController.h"
#import "DataModel.h"
#import "const.h"

@interface AddTrainingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *largePeriod;
@property (weak, nonatomic) IBOutlet UITextField *smallPeriod;
@end

@implementation AddTrainingViewController

- (IBAction)addTraining:(UIButton *)sender {
  Training *training = [[DataModel sharedInstance] addTrainingWithName:self.name.text];
  training.smallPeriod = [self.smallPeriod.text integerValue];
  training.largePeriod = [self.largePeriod.text integerValue];
  [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UPDATE object:nil];

  TrainingViewController *vc1 = [self.storyboard
                                instantiateViewControllerWithIdentifier:TRAINING_VIEW_SEGUE];
  vc1.training = training;

  AddApproachViewController *vc2 = [self.storyboard
                                    instantiateViewControllerWithIdentifier:ADD_APPROACH_SEGUE];
  vc2.training = training;

  NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
  [viewControllers removeLastObject];
  [viewControllers addObject:vc1];
  [viewControllers addObject:vc2];
  [self.navigationController setViewControllers:viewControllers animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:TRAINING_VIEW_SEGUE]) {
    if ([segue.destinationViewController class] == [TrainingViewController class]) {
      if ([sender class] == [Training class]) {
        TrainingViewController *dst = segue.destinationViewController;
        dst.training = sender;
      }
    }
  }
}

@end
