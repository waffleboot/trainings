
#import "AddExerciseViewController.h"

@interface AddExerciseViewController ()

@property (strong, nonatomic) IBOutlet UITextField *singleRepeat;
@property (strong, nonatomic) IBOutlet UITextField *singleRepeatCount;
@property (strong, nonatomic) IBOutlet UITextField *rangeRepeatFrom;
@property (strong, nonatomic) IBOutlet UITextField *rangeRepeatTo;
@property (strong, nonatomic) IBOutlet UIView *footer1;
@property (strong, nonatomic) IBOutlet UIView *footer2;

- (IBAction)addRepeat:(id)sender;
- (IBAction)addRange:(id)sender;

- (IBAction)cancel:(id)sender;

@end

@implementation AddExerciseViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  return section == 0 ? self.footer1 : self.footer2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 55;
}

- (void)addRepeat:(id)sender {
  NSString *repeatValue = self.singleRepeat.text;
  NSString *repeatCount = self.singleRepeatCount.text;
  if (repeatValue) {
    NSMutableArray<NSNumber*> *array = [NSMutableArray array];
    NSNumber *repeat = [NSNumber numberWithInteger:[repeatValue integerValue]];
    [array addObject:repeat];
    if (repeatCount) {
      NSInteger count = [repeatCount integerValue];
      for (int i = 1; i < count; ++i) {
        [array addObject:repeat];
      }
    }
    [self.delegate addExerciseViewController:self didAddExercise:array];
  }
}

- (void)addRange:(id)sender {
  NSString *repeatFrom = self.rangeRepeatFrom.text;
  NSString *repeatTo   = self.rangeRepeatTo.text;
  if (repeatFrom && repeatTo) {
    NSInteger from = [repeatFrom integerValue];
    NSInteger to   = [repeatTo integerValue];
    NSMutableArray<NSNumber*> *array = [NSMutableArray array];
    if (from < to) {
      for (int i = (unsigned) from; i <= to; ++i) {
        [array addObject:[NSNumber numberWithInt:i]];
      }
    } else {
      for (int i = (unsigned) from; i >= to; --i) {
        [array addObject:[NSNumber numberWithInt:i]];
      }
    }
    [self.delegate addExerciseViewController:self didAddExercise:array];
  }
}

- (void)cancel:(id)sender {
  [self.delegate addExerciseViewControllerDidCancel:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITextField *textField;
  switch (indexPath.section * 10 + indexPath.row) {
    case 00: textField = self.singleRepeat; break;
    case 01: textField = self.singleRepeatCount; break;
    case 10: textField = self.rangeRepeatFrom; break;
    case 11: textField = self.rangeRepeatTo; break;
  }
  [textField becomeFirstResponder];
}

@end
