
#import "TimerViewController.h"
#import "DataModel.h"

@interface Step : NSObject
@property Approach *approach;
@property NSUInteger round;
@property NSUInteger count;
@property NSUInteger delay;
+ (NSArray*)calculateSteps:(Training*)training;
@end

@implementation Step
+ (NSArray *)calculateSteps:(Training *)training {
  NSMutableArray *array = [[NSMutableArray alloc] init];
  NSUInteger maxRound = 0;
  for (int i = 0; i < training.approaches.count; ++i) {
    Approach *approach = [training.approaches objectAtIndex:i];
    NSArray *exercises = approach.exercises;
    NSUInteger count = exercises.count;
    maxRound = MAX(maxRound, count);
  }
  NSUInteger delay = 0;
  for (int round = 0; round < maxRound; ++round) {
    for (int i = 0; i < training.approaches.count; ++i) {
      Approach *approach = [training.approaches objectAtIndex:i];
      NSArray *exercises = approach.exercises;
      NSUInteger count = exercises.count;
      if (round < count) {
        Step *step = [[Step alloc] init];
        step.approach = approach;
        NSNumber *count = [exercises objectAtIndex:round];
        step.count = [count unsignedIntegerValue];
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
@property (weak, nonatomic) IBOutlet UILabel *text;
@end

@implementation TimerViewController {
  NSArray *times;
  NSTimer *timer;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  if (self.training.approaches.count > 0) {
    times = [Step calculateSteps:self.training];
    [self schedule:0];
  } else {
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  [timer invalidate];
}

- (void)schedule:(NSUInteger)pos {
  Step *step = [times objectAtIndex:pos];
  self.text.text = [NSString stringWithFormat:@"round %lu, make '%@' %lu times, step %lu",
                    step.round, step.approach.name, step.count, pos + 1];
  if (pos + 1 < times.count) {
    step = [times objectAtIndex:pos + 1];
    timer = [NSTimer scheduledTimerWithTimeInterval:step.delay repeats:NO block:^(NSTimer *timer) {
      [self schedule:pos+1];
    }];
  } else {
    timer = [NSTimer scheduledTimerWithTimeInterval:self.training.largePeriod repeats:NO block:^(NSTimer *timer) {
      self.text.text = @"done!";
    }];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
