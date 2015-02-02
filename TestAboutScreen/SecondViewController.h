//
//  SecondViewController.h
//  TestAboutScreen
//
//  Created by Even André Fiskvik on 30/01/15.
//  Copyright (c) 2015 Even André Fiskvik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SecondViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) UIView *headerView;

@end

