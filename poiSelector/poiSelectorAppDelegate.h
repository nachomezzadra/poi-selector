#import <Cocoa/Cocoa.h>

@interface poiSelectorAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    
    NSArray *names;
    NSMutableArray *states;
    NSMutableDictionary *myRows;
}

@property (assign) IBOutlet NSWindow *window;


- (IBAction)Close:(id)sender;

@end
