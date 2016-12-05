
#import "AddExerciseViewController.h"
#import "UITextField+AppliedChanges.h"

@interface AddExerciseViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *singleRepeat;
@property (strong, nonatomic) IBOutlet UITextField *singleRepeatCount;
@property (strong, nonatomic) IBOutlet UITextField *rangeRepeatFrom;
@property (strong, nonatomic) IBOutlet UITextField *rangeRepeatTo;
@property (strong, nonatomic) IBOutlet UIView *footer1;
@property (strong, nonatomic) IBOutlet UIView *footer2;
@property (strong, nonatomic) IBOutlet UIButton *singleButton;
@property (strong, nonatomic) IBOutlet UIButton *rangeButton;

- (IBAction)addRepeat:(id)sender;
- (IBAction)addRange:(id)sender;

- (IBAction)cancel:(id)sender;

@end

@interface UIButton (Enable)
@end

@implementation UIButton (Enable)

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  self.alpha = enabled ? 1.0 : 0.5;
}

@end

@implementation AddExerciseViewController

#pragma mark - Table view data source

- (void)viewDidLoad {
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
  tap.cancelsTouchesInView = NO;
  [self.view addGestureRecognizer:tap];
}

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

- (void)viewWillDisappear:(BOOL)animated {
  [self.view endEditing:YES];
  [super viewWillDisappear:animated];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
  if (self.singleRepeat == textField || self.singleRepeatCount == textField) {
    self.singleButton.enabled = NO;
  } else {
    self.rangeButton.enabled = NO;
  }
  return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSString *text = [textField textAfterChangeCharactersInRange:range replacementString:string];
  NSString *singleRepeat = self.singleRepeat.text;
  NSString *rangeRepeatFrom = self.rangeRepeatFrom.text;
  NSString *rangeRepeatTo = self.rangeRepeatTo.text;
  if (self.singleRepeat == textField) {
    singleRepeat = text;
  } else if (self.rangeRepeatFrom == textField) {
    rangeRepeatFrom = text;
  } else if (self.rangeRepeatTo == textField) {
    rangeRepeatTo = text;
  }
  BOOL singleButtonEnabled = singleRepeat.length > 0;
  BOOL rangeButtonEnabled = rangeRepeatFrom.length > 0 && rangeRepeatTo.length > 0;
  self.singleButton.enabled = singleButtonEnabled;
  self.rangeButton.enabled = rangeButtonEnabled;
  return YES;
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
