//
//  SecondViewController.m
//  TestAboutScreen
//
//  Created by Even André Fiskvik on 30/01/15.
//  Copyright (c) 2015 Even André Fiskvik. All rights reserved.
//

#import "SecondViewController.h"


@interface SecondViewController ()
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"About";
    // Do any additional setup after loading the view, typically from a nib.
    
/*    NSURL *url = [NSURL URLWithString:
                  @"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
*/
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 240);
    self.headerView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:self.headerView];
    
    // CGRect tableRect = CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height - _moviePlayer.view.frame.size.height);
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"aurora_short_new" ofType:@"mp4"]];
    NSLog(@"Loading URL: %@", url);
    
    self.moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:url];
    [self.moviePlayer.view setFrame:self.headerView.bounds];
    [self.headerView addSubview:_moviePlayer.view];

    UIImage *logo = [UIImage imageNamed:@"confr_logo_about"];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];
    // logoView.frame = CGRectMake( (self.view.frame.size.width - 481) / 2, 20, 481, 263);
    [self.headerView addSubview:logoView];
    logoView.frame = CGRectMake((self.view.frame.size.width - logoView.frame.size.width) / 2, 70, logoView.frame.size.width, logoView.frame.size.height);
    
    UILabel *descriptionLabel = [UILabel new];
    descriptionLabel.text = @"Used every day by consultants, professionals, lawywers";
    
    CGPoint center = logoView.center;
    center.y += 80;
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.font = [UIFont systemFontOfSize:12];
    [descriptionLabel sizeToFit];
    [self.headerView addSubview:descriptionLabel];
    descriptionLabel.center = center;
    
    UIView *tableViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];

    CGRect tableRect = CGRectMake(0, (240 - 64), self.view.frame.size.width, self.view.frame.size.height - (240 - 64));
    
    UIView *tableViewContainerTableBackground = [[UIView alloc] initWithFrame:tableRect];
    tableViewContainerTableBackground.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:244.0f/255.0f alpha:1.0];
    // [tableViewContainer addSubview:tableViewContainerTableBackground];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, tableViewContainer.frame.size.width, tableViewContainer.frame.size.height) style:UITableViewStyleGrouped];

//    [tableScrollView addSubview:tableView];
    tableView.alwaysBounceVertical = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.contentInset = UIEdgeInsetsMake(200 - 64, 0, 0, 0);
    //tableView.contentOffset = CGPointMake(0, _moviePlayer.view.frame.size.height);
    tableView.backgroundColor = [UIColor clearColor];

    tableView.sectionFooterHeight = 0.0;
    tableView.sectionHeaderHeight = 40.0;
    
    
//     tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 400, 0);
    
    // tableView.backgroundView = _moviePlayer.view;

    //tableView.alwaysBounceVertical = YES;
    
//     tableView.alignmentRectInsets = [UIRect]

    
    // [self.view addSubview:tableView];
    [tableViewContainer addSubview:tableView];
    [self.view addSubview:tableViewContainer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float zero = -(200 - 64);
    float diff = zero - scrollView.contentOffset.y;
    
    NSLog(@"Content offset is now: %.1f", scrollView.contentOffset.y);
    NSLog(@"Diff offset is now: %.1f", diff);
    if (scrollView.contentOffset.y <= zero) {
        float scaleFactor = 1 + (diff / 220);
        NSLog(@"Scale factor is: %.1f", scaleFactor);
//        [self.moviePlayer.view anim
        CGRect newFrame = self.headerView.frame;
        newFrame.size.height = 240 * scaleFactor;
        newFrame.size.width = self.view.frame.size.width * scaleFactor;
        NSLog(@"New x-pos = %.2f", newFrame.origin.x);
        self.headerView.frame = newFrame;
        
        newFrame.origin.x = (self.view.frame.size.width - newFrame.size.width) / 2;
        self.moviePlayer.view.frame = newFrame;
    }


}

/*- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // limit the bounceability!
    NSLog(@"Content offset is now: %.1f", scrollView.contentOffset.y);
    if (scrollView.contentOffset.y >= -64) {
        [scrollView setContentOffset:CGPointMake(0, -64) animated:NO];
//         scrollView.contentOffset = CGPointMake(0, -20);
    }
    
}*/

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0)];

    view.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:244.0f/255.0f alpha:1.0];
    // view.backgroundColor = [UIColor lightGrayColor];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"SettingsTableViewCell"];
    if (!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsTableViewCell"];
        tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    tableViewCell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            tableViewCell.textLabel.text = @"Privacy Policy";
        } else if (indexPath.row == 1) {
            tableViewCell.textLabel.text = @"Licenses";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            tableViewCell.textLabel.text = @"Facebook";
        } else if (indexPath.row == 1) {
            tableViewCell.textLabel.text = @"Twitter";
        }
        
    }
    
    return tableViewCell;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;

    self.moviePlayer.shouldAutoplay = YES;
    self.moviePlayer.allowsAirPlay = NO;
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.repeatMode = MPMovieRepeatModeOne;
//    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
//    self.moviePlayer.contentURL = url;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playBackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];

    [self.moviePlayer play];
}

-(void)playBackFinished:(id)something {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
