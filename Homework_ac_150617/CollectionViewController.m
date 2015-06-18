//
//  CollectionViewController.m
//  Homework_ac_150617
//
//  Created by Po-Hao Cheng on 2015/6/17.
//  Copyright (c) 2015年 phc. All rights reserved.
//

#import "CollectionViewController.h"
#import "DetailViewController.h"
@interface CollectionViewController ()<UIGestureRecognizerDelegate>
{
    NSArray *arrPic;
    NSIndexPath *clickedIndexPath;
    int clickedNum;
    
    NSMutableArray *arrDownloadPic;
    NSArray *arrPicURL;
    
//    UITapGestureRecognizer *tapGR;
}

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    clickedNum = 0;
    //準備好圖片
    arrPic = @[[UIImage imageNamed:@"ff7"],
               [UIImage imageNamed:@"photo_建嘉"],
               [UIImage imageNamed:@"photo_Abby_Hsu"],
               [UIImage imageNamed:@"photo_Amos_Chen"],
               [UIImage imageNamed:@"photo_Amos_Lee"],
               [UIImage imageNamed:@"photo_Anthony_Liu"]
               ];
   
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //example
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
 
    
    
    //Download pics from URL
    NSString *result = [self httpGet:@"http://www.lovistw.com/poda.json"];
//    NSLog(@"%@", result);
    NSError *e = nil;
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    
//    int i = 0;
    arrDownloadPic = [[NSMutableArray alloc]init];
    for (NSMutableDictionary *dictionary in arr) {
//    NSLog(@"%i", i);
//        arrPicURL[i] = dictionary[@"imgPath"];
//        NSString *str = @"http://www.finalfantasyviipc.com/images/media_cloud_big.jpg";
        NSURL *gurl = [NSURL URLWithString:dictionary[@"imgPath"]];
        NSData *data = [NSData dataWithContentsOfURL:gurl];
        [arrDownloadPic addObject:[UIImage imageWithData:data]];
//        arrDownloadPic[i] = [UIImage imageWithData:data];
//        i++;
//        NSLog(@"count = %i", arrDownloadPic.count);
    }
    NSLog(@"Load Pic done");
}

- (void)viewWillAppear:(BOOL)animated {
    clickedNum = 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




#pragma mark <UICollectionViewDataSource>

-(NSString *)httpGet:(NSString *)urllink{
    NSURL *url = [NSURL URLWithString:urllink];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    return str1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [arrPic count];
//    NSLog(@"%i", arrDownloadPic.count);
    return arrDownloadPic.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
//    imageView.image = arrPic[indexPath.row];
    imageView.image = arrDownloadPic[indexPath.row];
//    imageView.image = arrPic[0];
    
    clickedIndexPath = indexPath;
//    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showNum)];
//    tapGR.delegate = self;
//    [imageView addGestureRecognizer:tapGR];
//    imageView.userInteractionEnabled = 1;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    clickedNum = indexPath.row;
    [self performSegueWithIdentifier:@"change2Next" sender:self];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *detailVC = [segue destinationViewController];
//    detailVC.imageClicked = arrPic[clickedNum];
    detailVC.imageClicked = arrDownloadPic[clickedNum];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
