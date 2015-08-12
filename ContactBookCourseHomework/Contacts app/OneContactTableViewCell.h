//
//  OneContactTableViewCell.h
//  Contacts app
//
//  Created by Rumyana Atanasova on 29.05.15.
//  Copyright (c) 2015 г. Rumyana Atanasova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contactPicture;
@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *contactPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *contactEmail;

@end
