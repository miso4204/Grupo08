//
//  ProductCell.m
//  ShoppingCartExample
//
//  Created by Jose Gustavo Rodriguez Baldera on 5/31/14.
//  Copyright (c) 2014 Jose Gustavo Rodriguez Baldera. All rights reserved.
//

#import "ProductCell.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
@implementation ProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib
{
    [self.addToCartButton setStyle:BButtonStyleBootstrapV3];
    [self.addToCartButton setType:BButtonTypeWarning];
    
    [self.ViewDetailButton setStyle:BButtonStyleBootstrapV3];
    [self.ViewDetailButton setType:BButtonTypeWarning];
    
    

    

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
