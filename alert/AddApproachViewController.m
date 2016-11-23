
#import "AddApproachViewController.h"
#import "ExerciseViewController.h"
#import "const.h"

@interface AddApproachViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@end

@implementation AddApproachViewController

- (IBAction)addApproach:(UIButton *)sender {
  Approach *approach = [self.training addApproachWithName:self.name.text];
  [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UPDATE object:nil];

  ExerciseViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:EXERCISE_SEGUE];
  vc.approach = approach;
  
  NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
  [viewControllers removeLastObject];
  [viewControllers addObject:vc];
  [self.navigationController setViewControllers:viewControllers animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
