//
//  ViewController.m
//  instaKilo
//
//  Created by Krzysztof Kopytek on 2016-05-18.
//  Copyright © 2016 Krzysztof Kopytek. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "Photo.h"
#import "CustomCollectionReusableView.h"

@interface ViewController ()

// all photos
@property (strong, nonatomic) NSMutableArray *photos;
// set of subjects
@property (strong, nonatomic) NSMutableSet *allSubjects;
@property (strong, nonatomic) NSArray *listOfSubjects;
// photos sorted by subject
@property (strong, nonatomic) NSMutableArray *photosBySubject;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property int sortingMethodIndex;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.photos = [NSMutableArray new];
    self.allSubjects = [NSMutableSet new];
    self.photosBySubject = [NSMutableArray new];
    
    [self loadPhotos];
    [self sortBySubject];
    
    self.sortingMethodIndex = 0; // 0 -default; 1 - by subject
    // default is not working with headers itd ?
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"change view" style:UIBarButtonItemStylePlain target:self action:@selector(changeView)];
    self.navigationItem.rightBarButtonItem = addButton;
 

}


#pragma mark - setup
-(void) loadPhotos {
    
    Photo *photo1 = [[Photo alloc] initWithName:@"image1.jpg" subject:@"subject A" location:@"location A"];
    photo1.image = [UIImage imageNamed:photo1.name];
    [self.photos addObject:photo1];
    
    Photo *photo2 = [[Photo alloc] initWithName:@"image2.jpg" subject:@"subject A" location:@"location B"];
    photo2.image = [UIImage imageNamed:photo2.name];
    [self.photos addObject:photo2];
    
    Photo *photo3 = [[Photo alloc] initWithName:@"image3.jpg" subject:@"subject A" location:@"location A"];
    photo3.image = [UIImage imageNamed:photo3.name];
    [self.photos addObject:photo3];
    
    Photo *photo4 = [[Photo alloc] initWithName:@"image4.jpg" subject:@"subject B" location:@"location B"];
    photo4.image = [UIImage imageNamed:photo4.name];
    [self.photos addObject:photo4];
    
    Photo *photo5 = [[Photo alloc] initWithName:@"image5.jpg" subject:@"subject B" location:@"location A"];
    photo5.image = [UIImage imageNamed:photo5.name];
    [self.photos addObject:photo5];
    
    Photo *photo6 = [[Photo alloc] initWithName:@"image6.jpg" subject:@"subject B" location:@"location B"];
    photo6.image = [UIImage imageNamed:photo6.name];
    [self.photos addObject:photo6];
    
    Photo *photo7 = [[Photo alloc] initWithName:@"image7.jpg" subject:@"subject B" location:@"location A"];
    photo7.image = [UIImage imageNamed:photo7.name];
    [self.photos addObject:photo7];
    
    Photo *photo8 = [[Photo alloc] initWithName:@"image8.jpg" subject:@"subject C" location:@"location B"];
    photo8.image = [UIImage imageNamed:photo8.name];
    [self.photos addObject:photo8];
    
    Photo *photo9 = [[Photo alloc] initWithName:@"image9.jpg" subject:@"subject C" location:@"location A"];
    photo9.image = [UIImage imageNamed:photo9.name];
    [self.photos addObject:photo9];
    
    Photo *photo10 = [[Photo alloc] initWithName:@"image10.jpg" subject:@"subject C" location:@"location C"];
    photo10.image = [UIImage imageNamed:photo10.name];
    [self.photos addObject:photo10];
    
}


-(void)sortBySubject{

    // list of subjects
    for (Photo *photo in self.photos) {
        [self.allSubjects addObject:photo.subject];
    }
    
    self.listOfSubjects = [self.allSubjects allObjects];
 
    
    for (NSString *subject in self.allSubjects) {
        NSMutableArray *temp = [NSMutableArray new];
        for (Photo *photo in self.photos) {
            if ([photo.subject isEqualToString:subject]) {
                [temp addObject:photo];
            }
        }
        [self.photosBySubject addObject:temp];
    }
    
}

-(void)changeView {
    
    if(self.sortingMethodIndex == 0) self.sortingMethodIndex++;
    else self.sortingMethodIndex = 0;
    [self.collectionView reloadData];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    switch (self.sortingMethodIndex) {
        case 0:
            return 1;
            break;
        case 1:
            return self.allSubjects.count;
            break;
        default:
            return 1;
            break;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (self.sortingMethodIndex) {
        case 0:
            return self.photos.count;
            break;
        case 1:
            return [self.photosBySubject[section] count];
            break;
        default:
            return self.photos.count;
            break;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *current = [NSMutableArray new];
    
    switch (self.sortingMethodIndex) {
        case 0:
            current = self.photos;
            break;
        case 1:
            current = self.photosBySubject[indexPath.section];
            break;
        default:
            current = self.photos;
            break;
    }
    
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    Photo *photo = [Photo new];
    photo = current[indexPath.row];
    cell.imageInsideCell.image = photo.image;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CustomCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];

        if(self.sortingMethodIndex == 0) header.headerLabel.text = @"";
        else header.headerLabel.text = self.listOfSubjects[indexPath.section];
        
        return header;
        
    }
    
    return nil;
}

@end
