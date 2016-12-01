
#import "EditDoneNavigationItem.h"

@implementation EditDoneNavigationItem

static NSInteger kTag = 1;

- (void)awakeFromNib {
  [super awakeFromNib];
  NSMutableArray *buttons = [self.rightBarButtonItems mutableCopy];
  [buttons insertObject:[self editBarButtonItem] atIndex:0];
  self.rightBarButtonItems = buttons;
}

- (void)replaceWith:(UIBarButtonItem *)item {
  NSInteger idx = [self.rightBarButtonItems indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    UIBarButtonItem *item = obj;
    if (item.tag == kTag) {
      *stop = YES;
      return YES;
    }
    return NO;
  }];
  if (idx != NSNotFound) {
    NSMutableArray *buttons = [self.rightBarButtonItems mutableCopy];
    [buttons replaceObjectAtIndex:idx withObject:item];
    self.rightBarButtonItems = buttons;
  }
}

- (UIBarButtonItem *)barButtonItem:(UIBarButtonSystemItem)systemItem action:(SEL)action {
  UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:self action:action];
  barButtonItem.tag = kTag;
  return barButtonItem;
}

- (UIBarButtonItem *)doneBarButtonItem {
  return [self barButtonItem:UIBarButtonSystemItemDone action:@selector(done)];
}

- (UIBarButtonItem *)editBarButtonItem {
  return [self barButtonItem:UIBarButtonSystemItemEdit action:@selector(edit)];
}

- (void)edit {
  [self replaceWith:[self doneBarButtonItem]];
  [self.tableView setEditing:YES animated:NO];
}

- (void)done {
  [self replaceWith:[self editBarButtonItem]];
  [self.tableView setEditing:NO animated:NO];
  [self.tableView reloadData];
  
}

@end
