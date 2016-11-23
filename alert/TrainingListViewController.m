
#import "TrainingListViewController.h"
#import "TrainingViewController.h"
#import "DataModel.h"
#import "const.h"

@interface TrainingListViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation TrainingListViewController

static NSString * const ADD_TRAINING_SEGUE  = @"AddTrainingViewController";

- (IBAction)addTraining:(UIButton *)sender {
  [self performSegueWithIdentifier:ADD_TRAINING_SEGUE sender:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
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
  return [DataModel sharedInstance].trainings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TrainingListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrainingListViewCell"];
  if (!cell) {
    cell = [[TrainingListViewCell alloc] init];
  }
  cell.name.text = [[[DataModel sharedInstance].trainings objectAtIndex:indexPath.row] name];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Training *training = [[DataModel sharedInstance].trainings objectAtIndex:indexPath.row];
  [self performSegueWithIdentifier:TRAINING_VIEW_SEGUE sender:training];
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

@implementation TrainingListViewCell

@end
