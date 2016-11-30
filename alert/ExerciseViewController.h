//
//  ExerciseViewController.h
//  alert
//
//  Created by Андрей on 23.11.16.
//  Copyright © 2016 Andrei Yangabishev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "AddExerciseViewController.h"

@interface ExerciseViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UILabel *pos;
@end

@interface ExerciseViewController : UITableViewController <AddExerciseViewControllerDelegate>
@property Approach *approach;
@end
