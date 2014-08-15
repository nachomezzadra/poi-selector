#import "poiSelectorAppDelegate.h"

@implementation poiSelectorAppDelegate;

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
            //initWithObjects:@"1", @"2", @"3", nil];
    
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *path = @"/Users/nacho/Downloads/POIs_Garmin_Argentina/Bancos";
        NSLog (@"%@%@", @"******** Retrieving objects from ", path);
        
        NSArray * elementList = [self getElementList:path];
        
        //ver que onda, como asignar el array de elementList a names para cargar los combo boxes en base a los elementos
       
        NSLog(@"Capacity: %ld", [elementList count]);

        names = [[NSMutableArray alloc] initWithCapacity:[elementList count]];
        
        
        NSUInteger count = [elementList count];
        for (NSUInteger index = 0; index < count ; index++) {
            NSLog(@"%@", [elementList objectAtIndex:index]);
            [names addObject:[elementList objectAtIndex:index]];
        }


    }
    return self;
}



- (IBAction)Close:(id)sender{
    [window close];
}


- (NSArray *) getElementList:(NSString *) baseDir {
    //names=[[NSArray alloc] initWithObjects:@"anoop", @"baban", @"chaman", @"nacho", nil];
    states=[[NSMutableArray alloc] initWithObjects:@"1", @"0", @"1", @"2", nil];
    
    NSArray *extensions = [NSArray arrayWithObjects:@"gpx", nil];
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:baseDir error:nil];
    NSArray *files = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@", extensions]];
    
    NSLog (@"%@", @"******** Files in Directory:");
    NSLog (@"%@", files);
    
    NSLog (@"%@", @"******** Trimmed files");
    
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    
    NSUInteger count = [files count];
    for (NSUInteger index = 0; index < count ; index++) {
        NSLog([self getElementFrom:[files objectAtIndex:index]]);
        [stringArray addObject:[self getElementFrom:[files objectAtIndex:index]]];
    }
    
//    return files;
    return stringArray;
}


- (NSString *) getElementFrom:(NSString *) fileName {
    //removes the first 'AR_'
    NSString* substrWithExtension = [fileName substringFromIndex:3];
    NSUInteger length = [substrWithExtension length];
    //removing the last '.gpx'
    return [substrWithExtension substringToIndex:length - 4];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSLog(@"Num of rows---- %ld", [names count]);
    return [names count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([[tableColumn identifier] isEqualTo:@"name"]) {
        return [names objectAtIndex:row];
    }
    else if ([[tableColumn identifier] isEqualTo:@"check"]) {
        
        return [states objectAtIndex:row];
    }
    //else if ([[tableColumn identifier] isEqualTo:@"states"]) {
    //    return [states objectAtIndex:row];
    //}
    return 0;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)value forTableColumn:(NSTableColumn *)column row:(NSInteger)row {          
    [states replaceObjectAtIndex:row withObject:value];
    [tableView reloadData];
}

@end
