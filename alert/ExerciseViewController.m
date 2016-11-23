
#import "ExerciseViewController.h"

@interface ExerciseViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *trainingName;
@property (weak, nonatomic) IBOutlet UILabel *approachName;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UITextField *singleRepeat;
@property (weak, nonatomic) IBOutlet UITextField *singleRepeatCount;
@property (weak, nonatomic) IBOutlet UITextField *rangeRepeatFrom;
@property (weak, nonatomic) IBOutlet UITextField *rangeRepeatTo;
@end

@implementation ExerciseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.trainingName.text = self.approach.training.name;
  self.approachName.text = self.approach.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addRepeat:(UIButton *)sender {
  NSString *repeatValue = self.singleRepeat.text;
  NSString *repeatCount = self.singleRepeatCount.text;
  if (repeatValue) {
    NSInteger repeat = labs([repeatValue integerValue]);
    [self.approach addExercise:repeat];
    if (repeatCount) {
      NSInteger count = labs([repeatCount integerValue]);
      for (int i = 1; i < count; ++i) {
        [self.approach addExercise:repeat];
      }
    } else {
    }
    [self.table reloadData];
  }
}

- (IBAction)addRange:(UIButton *)sender {
  NSString *repeatFrom = self.rangeRepeatFrom.text;
  NSString *repeatTo   = self.rangeRepeatTo.text;
  if (repeatFrom && repeatTo) {
    NSInteger from = labs([repeatFrom integerValue]);
    NSInteger to = labs([repeatTo integerValue]);
    if (from < to) {
      for (int i = from; i <= to; ++i) {
        [self.approach addExercise:i];
      }
    } else {
      for (int i = from; i >= to; --i) {
        [self.approach addExercise:i];
      }
    }
    [self.table reloadData];
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.approach.exercises.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ExerciseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExerciseViewCell"];
  if (!cell) {
    cell = [[ExerciseViewCell alloc] init];
  }
  NSNumber *count = [self.approach.exercises objectAtIndex:indexPath.row];
  cell.pos.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
  cell.value.text = [NSString stringWithFormat:@"%@", count];
  return cell;
}

@end

@implementation ExerciseViewCell
@end
