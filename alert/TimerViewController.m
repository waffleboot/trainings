
#import "TimerViewController.h"
#import "DataModel.h"
#import "MZTimerLabel.h"

@interface Step : NSObject
@property Approach *approach;
@property NSUInteger round;
@property NSUInteger count;
@property NSUInteger delay;
+ (NSArray*)calculateSteps:(Training*)training;
@end

@implementation Step
- (NSString *)description {
  return [NSString stringWithFormat:@"%lu %@ %lu", self.round, self.approach.name, self.delay];
}
+ (NSArray *)calculateSteps:(Training *)training {
  NSUInteger delay = 0;
  NSUInteger maxRound = training.maxRound;
  NSMutableArray *array = [[NSMutableArray alloc] init];
  for (int round = 0; round < maxRound; ++round) {
    for (int i = 0; i < training.approaches.count; ++i) {
      Approach *approach = [training.approaches objectAtIndex:i];
      NSInteger count = [approach exercisesCountForRound:round];
      if (count >= 0) {
        Step *step = [[Step alloc] init];
        step.approach = approach;
        step.count = count;
        step.round = round + 1;
        step.delay = delay;
        [array addObject:step];
        delay = training.smallPeriod;
      }
    }
    delay = training.largePeriod;
  }
  return array;
}
@end

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet MZTimerLabel *stopwatch;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *approachLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation TimerViewController {
  NSArray *times;
  NSUInteger pos;
}

- (void)updateText {
  Step *step = [times objectAtIndex:pos];
  self.roundLabel.text = [NSString stringWithFormat:@"Round %lu", step.round];
  self.approachLabel.text = step.approach.name;
  self.countLabel.text = [NSString stringWithFormat:@"Count %lu", step.count];
  self.stepLabel.text = [NSString stringWithFormat:@"Step %lu", pos + 1];
}

- (void)hideText:(BOOL)hide {
  self.button.hidden = hide;
  self.roundLabel.hidden = hide;
  self.approachLabel.hidden = hide;
  self.countLabel.hidden = hide;
  self.stepLabel.hidden = hide;
}

- (IBAction)done:(UIButton *)sender {
  pos += 1;
  if (pos < times.count) {
    [self updateText];
    Step *step = [times objectAtIndex:pos];
    [self.stopwatch setCountDownTime:step.delay];
    TimerViewController* __weak weakSelf = self;
    [self hideText:YES];
    self.stopwatch.endedBlock = ^(NSTimeInterval ti) {
      TimerViewController* __strong strongSelf = weakSelf;
      strongSelf.stopwatch.backgroundColor = [UIColor redColor];
      [strongSelf hideText:NO];
    };
    self.stopwatch.backgroundColor = [UIColor greenColor] ;
    [self.stopwatch reset];
    [self.stopwatch start];
  } else {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Done"];
    NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
    [viewControllers removeLastObject];
    [viewControllers removeLastObject];
    [viewControllers addObject:vc];
    [self.navigationController setViewControllers:viewControllers animated:NO];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.stopwatch.timerType = MZTimerLabelTypeTimer;
  if (self.training.approaches.count > 0) {
    pos = 0; times = [Step calculateSteps:self.training];
    [self updateText];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
