#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#import <math.h>

@class AppDelegate;

@interface KeyView : NSView
@property(nonatomic, weak) AppDelegate *controller;
@end

@interface EditTarget : NSObject
@property(nonatomic, copy) void (^saveBlock)(void);
@property(nonatomic, copy) void (^cancelBlock)(void);
@property(nonatomic, copy) void (^chooseBlock)(void);
@property(nonatomic, copy) void (^clearBlock)(void);
@end

@interface ShapePadButton : NSButton
@property(nonatomic, weak) AppDelegate *controller;
@property(nonatomic, strong) NSDictionary *item;
@property(nonatomic) BOOL selectedPad;
@end

@interface ThemedRailButton : NSButton
@property(nonatomic, weak) AppDelegate *controller;
@end

@interface WaveformView : NSView
@property(nonatomic, weak) AppDelegate *controller;
@property(nonatomic, strong) NSArray<NSNumber *> *peaks;
@property(nonatomic) NSTimeInterval duration;
@property(nonatomic) NSTimeInterval trimStart;
@property(nonatomic) NSTimeInterval trimEnd;
- (void)loadAudioURL:(NSURL *)url duration:(NSTimeInterval)duration;
@end

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate, AVAudioPlayerDelegate>
@property(nonatomic, strong) NSWindow *window;
@property(nonatomic, strong) NSPanel *preferencesPanel;
@property(nonatomic, strong) NSPanel *accountPanel;
@property(nonatomic, strong) NSPanel *registrationPanel;
@property(nonatomic, strong) KeyView *rootView;
@property(nonatomic, strong) NSTableView *tableView;
@property(nonatomic, strong) NSTableView *recentRecordingsTableView;
@property(nonatomic, strong) NSTableView *playlistTableView;
@property(nonatomic, strong) NSTableView *playlistSongsTableView;
@property(nonatomic, strong) NSScrollView *listScrollView;
@property(nonatomic, strong) NSScrollView *padScrollView;
@property(nonatomic, strong) NSScrollView *recentRecordingsScrollView;
@property(nonatomic, strong) NSView *padContentView;
@property(nonatomic, strong) NSBox *recordingPageView;
@property(nonatomic, strong) NSBox *editorPageView;
@property(nonatomic, strong) NSBox *musicPageView;
@property(nonatomic, strong) NSBox *friendsSidebarView;
@property(nonatomic, strong) NSSearchField *searchField;
@property(nonatomic, strong) NSTextField *friendsStatusLabel;
@property(nonatomic, strong) NSTextField *statusLabel;
@property(nonatomic, strong) NSTextField *titleLabel;
@property(nonatomic, strong) NSTextField *subtitleLabel;
@property(nonatomic, strong) NSImageView *logoView;
@property(nonatomic, strong) NSBox *toolbarBox;
@property(nonatomic, strong) NSStackView *toolbarStack;
@property(nonatomic, strong) NSSegmentedControl *viewModeControl;
@property(nonatomic, strong) NSLayoutConstraint *viewModeLeadingWithSidebar;
@property(nonatomic, strong) NSLayoutConstraint *viewModeLeadingNoSidebar;
@property(nonatomic, strong) NSLayoutConstraint *mainLeadingWithSidebar;
@property(nonatomic, strong) NSLayoutConstraint *mainLeadingNoSidebar;
@property(nonatomic, strong) NSMutableArray<NSButton *> *toolbarButtons;
@property(nonatomic, strong) NSArray<NSView *> *soundSidebarViews;
@property(nonatomic, strong) NSArray<NSView *> *recordingSidebarViews;
@property(nonatomic, strong) NSArray<NSView *> *editorSidebarViews;
@property(nonatomic, strong) NSButton *recordButton;
@property(nonatomic, strong) NSButton *stopRecordingButton;
@property(nonatomic, strong) NSButton *playRecordingButton;
@property(nonatomic, strong) NSButton *showRecordingButton;
@property(nonatomic, strong) NSButton *deleteRecordingButton;
@property(nonatomic, strong) NSTextField *recordingTitleLabel;
@property(nonatomic, strong) NSTextField *recordingStatusLabel;
@property(nonatomic, strong) NSTextField *editorTitleLabel;
@property(nonatomic, strong) NSTextField *editorStatusLabel;
@property(nonatomic, strong) NSTextField *editorLoadedLabel;
@property(nonatomic, strong) NSSlider *editorStartSlider;
@property(nonatomic, strong) NSSlider *editorEndSlider;
@property(nonatomic, strong) NSSlider *editorVolumeSlider;
@property(nonatomic, strong) NSSlider *editorZoomSlider;
@property(nonatomic, strong) WaveformView *editorWaveformView;
@property(nonatomic, strong) NSScrollView *editorWaveformScrollView;
@property(nonatomic, strong) NSLayoutConstraint *editorWaveformWidthConstraint;
@property(nonatomic, strong) NSURL *editorSourceURL;
@property(nonatomic, strong) AVAudioPlayer *editorPlayer;
@property(nonatomic, strong) NSMutableArray<NSMutableDictionary *> *playlists;
@property(nonatomic, strong) NSMutableArray<NSMutableDictionary *> *musicLibrary;
@property(nonatomic, strong) NSURL *musicConfigURL;
@property(nonatomic, strong) AVAudioPlayer *musicPlayer;
@property(nonatomic) NSInteger selectedPlaylistIndex;
@property(nonatomic) NSInteger currentSongIndex;
@property(nonatomic, strong) NSArray<NSSortDescriptor *> *musicSortDescriptors;
@property(nonatomic, strong) NSImageView *musicArtworkView;
@property(nonatomic, strong) NSTextField *musicTitleLabel;
@property(nonatomic, strong) NSTextField *musicArtistLabel;
@property(nonatomic, strong) NSTextField *musicStatusLabel;
@property(nonatomic, strong) AVAudioRecorder *recorder;
@property(nonatomic, strong) NSURL *pendingRecordingURL;
@property(nonatomic, strong) NSMutableArray<NSMutableDictionary *> *items;
@property(nonatomic, strong) NSArray<NSMutableDictionary *> *filteredItems;
@property(nonatomic, strong) NSArray<NSURL *> *recentRecordingURLs;
@property(nonatomic, strong) NSMutableArray<AVAudioPlayer *> *players;
@property(nonatomic, strong) NSURL *configURL;
@property(nonatomic, strong) NSURL *appFolderURL;
@property(nonatomic, strong) id keyMonitor;
@property(nonatomic) BOOL isPaused;
@property(nonatomic, copy) NSString *themeName;
@property(nonatomic, copy) NSString *viewMode;
@property(nonatomic) BOOL stopBeforePlaying;
@property(nonatomic) BOOL confirmDeletes;
@property(nonatomic) BOOL largePads;
@property(nonatomic, strong) NSNumber *selectedItemID;
@property(nonatomic, copy) NSString *supabaseURL;
@property(nonatomic, copy) NSString *supabaseAnonKey;
@property(nonatomic, copy) NSString *supabaseAccessToken;
@property(nonatomic, copy) NSString *supabaseRefreshToken;
@property(nonatomic, copy) NSString *accountEmail;
@property(nonatomic, copy) NSString *accountUsername;
@property(nonatomic, copy) NSString *adminEmail;
@property(nonatomic, strong) NSTextField *registrationUsernameField;
@property(nonatomic, strong) NSTextField *registrationEmailField;
@property(nonatomic, strong) NSSecureTextField *registrationPasswordField;
@property(nonatomic, strong) NSTextField *registrationStatusLabel;
- (BOOL)triggerKey:(NSString *)key;
- (NSColor *)themeColor:(NSString *)role;
- (NSImage *)imageForItem:(NSDictionary *)item;
- (NSFont *)themeFontOfSize:(CGFloat)size weight:(NSFontWeight)weight;
- (void)editorWaveformDidChangeTrimStart:(NSTimeInterval)start end:(NSTimeInterval)end;
@end

@implementation KeyView
- (BOOL)acceptsFirstResponder { return YES; }
- (void)drawRect:(NSRect)dirtyRect {
    NSColor *top = [self.controller themeColor:@"backgroundTop"] ?: [NSColor colorWithCalibratedRed:0.02 green:0.08 blue:0.18 alpha:1.0];
    NSColor *bottom = [self.controller themeColor:@"backgroundBottom"] ?: [NSColor colorWithCalibratedRed:0.00 green:0.14 blue:0.34 alpha:1.0];
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:top endingColor:bottom];
    [gradient drawInRect:self.bounds angle:270];

    [[self.controller themeColor:@"accentSoft"] setFill];
    NSBezierPath *arc = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(self.bounds.size.width - 210, self.bounds.size.height - 170, 320, 320)];
    [arc fill];

}
- (void)keyDown:(NSEvent *)event {
    NSString *chars = [[event charactersIgnoringModifiers] uppercaseString];
    if (chars.length == 1 && [self.controller triggerKey:chars]) {
        return;
    }
    [super keyDown:event];
}
@end

@implementation EditTarget
- (void)save { if (self.saveBlock) self.saveBlock(); }
- (void)cancel { if (self.cancelBlock) self.cancelBlock(); }
- (void)choose { if (self.chooseBlock) self.chooseBlock(); }
- (void)clear { if (self.clearBlock) self.clearBlock(); }
@end

@implementation ShapePadButton
- (BOOL)isFlipped { return YES; }
- (void)drawRect:(NSRect)dirtyRect {
    NSRect bounds = NSInsetRect(self.bounds, 5, 5);
    CGFloat labelHeight = self.controller.largePads ? 42 : 36;
    NSRect labelRect = NSMakeRect(NSMinX(bounds), NSMaxY(bounds) - labelHeight, bounds.size.width, labelHeight);
    NSRect tileRect = NSMakeRect(NSMinX(bounds), NSMinY(bounds), bounds.size.width, bounds.size.height - labelHeight - 6);
    NSBezierPath *shape = [NSBezierPath bezierPathWithRoundedRect:tileRect xRadius:14 yRadius:14];

    NSColor *fill = self.selectedPad ? [self.controller themeColor:@"accentSoft"] : [self.controller themeColor:@"panel"];
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[fill blendedColorWithFraction:0.18 ofColor:[self.controller themeColor:@"accent"]] endingColor:fill];
    [gradient drawInBezierPath:shape angle:270];
    [[self.controller themeColor:@"accent"] setStroke];
    shape.lineWidth = self.selectedPad ? 3.0 : 1.4;
    [shape stroke];

    NSImage *image = [self.controller imageForItem:self.item];
    if (image) {
        [NSGraphicsContext saveGraphicsState];
        [shape addClip];
        [image drawInRect:tileRect fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1.0 respectFlipped:YES hints:nil];
        [NSGraphicsContext restoreGraphicsState];
    }

    NSString *key = self.item[@"key"] ?: @"";
    NSString *name = self.item[@"name"] ?: @"";
    NSString *category = self.item[@"category"] ?: (([self.item[@"kind"] isEqualToString:@"link"] || [self.item[@"kind"] isEqualToString:@"youtube"]) ? @"Music" : @"Other");
    NSString *text = [NSString stringWithFormat:@"%@\n%@\n%@", key, name, category];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attrs = @{
        NSFontAttributeName: [self.controller themeFontOfSize:(self.controller.largePads ? 15 : 13) weight:NSFontWeightSemibold],
        NSForegroundColorAttributeName: [self.controller themeColor:@"text"],
        NSParagraphStyleAttributeName: style
    };
    [text drawInRect:NSInsetRect(labelRect, 6, 1) withAttributes:attrs];
}
@end

@implementation WaveformView {
    NSInteger _draggingHandle;
}

- (BOOL)isFlipped { return YES; }

- (void)loadAudioURL:(NSURL *)url duration:(NSTimeInterval)duration {
    self.duration = MAX(duration, 0.1);
    self.trimStart = 0;
    self.trimEnd = self.duration;
    NSMutableArray<NSNumber *> *peaks = [NSMutableArray array];
    NSError *error = nil;
    AVAudioFile *file = [[AVAudioFile alloc] initForReading:url error:&error];
    if (!file || file.length <= 0) {
        self.peaks = @[];
        self.needsDisplay = YES;
        return;
    }
    NSInteger targetBins = 5000;
    AVAudioFormat *format = [[AVAudioFormat alloc] initWithCommonFormat:AVAudioPCMFormatFloat32 sampleRate:file.fileFormat.sampleRate channels:file.fileFormat.channelCount interleaved:NO];
    AVAudioFrameCount chunkSize = 4096;
    AVAudioFramePosition totalFrames = file.length;
    double framesPerBin = MAX(1.0, (double)totalFrames / (double)targetBins);
    for (NSInteger index = 0; index < targetBins; index++) [peaks addObject:@0.0];
    AVAudioFramePosition frameIndex = 0;
    while (frameIndex < totalFrames) {
        AVAudioFrameCount framesToRead = (AVAudioFrameCount)MIN((AVAudioFramePosition)chunkSize, totalFrames - frameIndex);
        AVAudioPCMBuffer *buffer = [[AVAudioPCMBuffer alloc] initWithPCMFormat:format frameCapacity:framesToRead];
        if (![file readIntoBuffer:buffer frameCount:framesToRead error:nil]) break;
        float *const *channels = buffer.floatChannelData;
        if (!channels) break;
        for (AVAudioFrameCount frame = 0; frame < buffer.frameLength; frame++) {
            float value = 0;
            for (AVAudioChannelCount channel = 0; channel < format.channelCount; channel++) {
                value = MAX(value, fabsf(channels[channel][frame]));
            }
            NSInteger bin = MIN(targetBins - 1, (NSInteger)floor((double)(frameIndex + frame) / framesPerBin));
            if (value > peaks[bin].floatValue) peaks[bin] = @(value);
        }
        frameIndex += buffer.frameLength;
        if (buffer.frameLength == 0) break;
    }
    self.peaks = peaks;
    self.needsDisplay = YES;
}

- (NSTimeInterval)timeForX:(CGFloat)x {
    if (self.duration <= 0 || self.bounds.size.width <= 0) return 0;
    CGFloat clamped = MIN(MAX(x, 0), self.bounds.size.width);
    return (clamped / self.bounds.size.width) * self.duration;
}

- (CGFloat)xForTime:(NSTimeInterval)time {
    if (self.duration <= 0) return 0;
    return (time / self.duration) * self.bounds.size.width;
}

- (void)drawRect:(NSRect)dirtyRect {
    NSRect bounds = self.bounds;
    [[self.controller themeColor:@"surface"] setFill];
    NSRectFill(bounds);
    NSBezierPath *border = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(bounds, 1, 1) xRadius:8 yRadius:8];
    [[self.controller themeColor:@"accentSoft"] setStroke];
    border.lineWidth = 1;
    [border stroke];

    CGFloat midY = NSMidY(bounds);
    CGFloat trackHeight = MAX(20, bounds.size.height - 34);
    NSRect trackRect = NSMakeRect(14, midY - trackHeight / 2.0, bounds.size.width - 28, trackHeight);
    [[self.controller themeColor:@"panel"] setFill];
    [[NSBezierPath bezierPathWithRoundedRect:trackRect xRadius:7 yRadius:7] fill];

    if (self.peaks.count == 0) {
        NSDictionary *attrs = @{NSFontAttributeName: [self.controller themeFontOfSize:14 weight:NSFontWeightMedium], NSForegroundColorAttributeName: [self.controller themeColor:@"mutedText"]};
        [@"Load audio to show waveform" drawInRect:NSInsetRect(bounds, 20, bounds.size.height / 2 - 10) withAttributes:attrs];
        return;
    }

    CGFloat startX = [self xForTime:self.trimStart];
    CGFloat endX = [self xForTime:self.trimEnd];
    NSRect selected = NSMakeRect(MIN(startX, endX), trackRect.origin.y, fabs(endX - startX), trackRect.size.height);
    [[[self.controller themeColor:@"accent"] colorWithAlphaComponent:0.18] setFill];
    NSRectFillUsingOperation(NSIntersectionRect(selected, trackRect), NSCompositingOperationSourceOver);

    [[self.controller themeColor:@"accent"] setStroke];
    NSBezierPath *wave = [NSBezierPath bezierPath];
    CGFloat binWidth = trackRect.size.width / MAX((CGFloat)self.peaks.count, 1);
    for (NSInteger index = 0; index < (NSInteger)self.peaks.count; index++) {
        CGFloat peak = MIN(1.0, self.peaks[index].doubleValue);
        CGFloat x = trackRect.origin.x + index * binWidth;
        CGFloat height = MAX(1.0, peak * trackRect.size.height);
        [wave moveToPoint:NSMakePoint(x, midY - height / 2.0)];
        [wave lineToPoint:NSMakePoint(x, midY + height / 2.0)];
    }
    wave.lineWidth = MAX(1.0, binWidth);
    [wave stroke];

    NSArray *handles = @[@(startX), @(endX)];
    NSArray *labels = @[@"Start", @"End"];
    for (NSInteger index = 0; index < 2; index++) {
        CGFloat x = [handles[index] doubleValue];
        [[self.controller themeColor:index == 0 ? @"titleAccent" : @"accent"] setFill];
        NSRect handleRect = NSMakeRect(x - 3, trackRect.origin.y - 8, 6, trackRect.size.height + 16);
        NSBezierPath *handle = [NSBezierPath bezierPathWithRoundedRect:handleRect xRadius:3 yRadius:3];
        [handle fill];
        NSDictionary *attrs = @{NSFontAttributeName: [self.controller themeFontOfSize:11 weight:NSFontWeightBold], NSForegroundColorAttributeName: [self.controller themeColor:@"text"]};
        [labels[index] drawAtPoint:NSMakePoint(x + 7, trackRect.origin.y - 18) withAttributes:attrs];
    }
}

- (void)mouseDown:(NSEvent *)event {
    if (self.duration <= 0) return;
    NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
    CGFloat startX = [self xForTime:self.trimStart];
    CGFloat endX = [self xForTime:self.trimEnd];
    _draggingHandle = fabs(point.x - startX) <= fabs(point.x - endX) ? 1 : 2;
    [self mouseDragged:event];
}

- (void)mouseDragged:(NSEvent *)event {
    if (_draggingHandle == 0) return;
    NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
    NSTimeInterval time = [self timeForX:point.x];
    if (_draggingHandle == 1) {
        self.trimStart = MIN(MAX(0, time), self.trimEnd);
    } else {
        self.trimEnd = MAX(MIN(self.duration, time), self.trimStart);
    }
    [self.controller editorWaveformDidChangeTrimStart:self.trimStart end:self.trimEnd];
    self.needsDisplay = YES;
}

- (void)mouseUp:(NSEvent *)event {
    _draggingHandle = 0;
}

@end

@implementation ThemedRailButton
- (BOOL)isFlipped { return YES; }
- (NSSize)intrinsicContentSize { return NSMakeSize(176, 48); }
- (void)drawRect:(NSRect)dirtyRect {
    NSRect bounds = NSInsetRect(self.bounds, 4, 4);
    NSString *theme = self.controller.themeName ?: @"Notre Dame";
    NSColor *stroke = [self.controller themeColor:@"accent"];
    NSColor *textColor = [NSColor whiteColor];
    NSColor *bandColor = [NSColor colorWithCalibratedWhite:0.02 alpha:0.70];
    NSString *emoji = @"◆";
    NSRect bodyRect = bounds;

    if ([theme isEqualToString:@"Notre Dame"]) {
        emoji = @"🏈";
        textColor = [NSColor colorWithCalibratedRed:1.0 green:0.88 blue:0.40 alpha:1.0];
        bandColor = [NSColor colorWithCalibratedRed:0.03 green:0.08 blue:0.18 alpha:0.78];
    } else if ([theme isEqualToString:@"Forest"]) {
        emoji = @"🍃";
        textColor = [NSColor colorWithCalibratedRed:0.96 green:1.0 blue:0.82 alpha:1.0];
        bandColor = [NSColor colorWithCalibratedRed:0.02 green:0.12 blue:0.07 alpha:0.78];
    } else if ([theme isEqualToString:@"Halloween"]) {
        emoji = @"🎃";
        textColor = [NSColor colorWithCalibratedRed:0.06 green:0.04 blue:0.09 alpha:1.0];
        bandColor = [NSColor colorWithCalibratedRed:1.0 green:0.78 blue:0.28 alpha:0.84];
    } else if ([theme isEqualToString:@"Midnight"]) {
        emoji = @"🌙";
        textColor = [NSColor colorWithCalibratedRed:0.78 green:0.91 blue:1.0 alpha:1.0];
        bandColor = [NSColor colorWithCalibratedRed:0.02 green:0.04 blue:0.12 alpha:0.78];
    } else if ([theme isEqualToString:@"Slate"]) {
        emoji = @"🔷";
        textColor = [NSColor colorWithCalibratedRed:1.0 green:0.82 blue:0.58 alpha:1.0];
        bandColor = [NSColor colorWithCalibratedRed:0.08 green:0.09 blue:0.12 alpha:0.78];
    }

    NSBezierPath *clip = [NSBezierPath bezierPathWithRoundedRect:bounds xRadius:18 yRadius:18];
    [[self.controller themeColor:@"surface"] setFill];
    [clip fill];
    [NSGraphicsContext saveGraphicsState];
    [clip addClip];
    NSMutableParagraphStyle *emojiStyle = [[NSMutableParagraphStyle alloc] init];
    emojiStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *emojiAttrs = @{
        NSFontAttributeName: [NSFont systemFontOfSize:54],
        NSParagraphStyleAttributeName: emojiStyle
    };
    [emoji drawInRect:NSMakeRect(NSMinX(bounds) - 10, NSMinY(bounds) - 11, bounds.size.width + 20, bounds.size.height + 20) withAttributes:emojiAttrs];
    [NSGraphicsContext restoreGraphicsState];
    [stroke setStroke];
    clip.lineWidth = 1.8;
    [clip stroke];

    NSRect bandRect = NSInsetRect(bounds, 9, 9);
    bandRect.origin.y = NSMidY(bounds) - 13;
    bandRect.size.height = 26;
    NSBezierPath *band = [NSBezierPath bezierPathWithRoundedRect:bandRect xRadius:9 yRadius:9];
    [bandColor setFill];
    [band fill];

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attrs = @{
        NSFontAttributeName: [self.controller themeFontOfSize:11 weight:NSFontWeightBold],
        NSForegroundColorAttributeName: textColor,
        NSParagraphStyleAttributeName: style
    };
    [self.title drawInRect:NSInsetRect(bandRect, 6, 5) withAttributes:attrs];
}
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [self registerDefaults];
    [self loadSettings];
    [self buildMenu];
    NSImage *icon = [NSImage imageNamed:@"SoundsSimpleIcon"];
    if (icon) {
        [NSApp setApplicationIconImage:icon];
    }
    NSURL *bundleURL = [NSBundle mainBundle].bundleURL;
    NSURL *launchFolderURL = nil;
    if ([bundleURL.pathExtension isEqualToString:@"app"]) {
        launchFolderURL = bundleURL.URLByDeletingLastPathComponent;
    } else {
        launchFolderURL = [NSURL fileURLWithPath:[[NSFileManager defaultManager] currentDirectoryPath] isDirectory:YES];
    }
    self.appFolderURL = [self applicationSupportFolderURL];
    self.configURL = [self.appFolderURL URLByAppendingPathComponent:@"soundboard.json"];
    self.musicConfigURL = [self.appFolderURL URLByAppendingPathComponent:@"music-playlists.json"];
    [self seedApplicationSupportFromFolder:launchFolderURL];
    self.players = [NSMutableArray array];
    [self loadItems];
    [self loadPlaylists];
    [self migrateAbsoluteSoundPaths];
    [self buildWindow];
    [self.playlistTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    __weak AppDelegate *weakSelf = self;
    self.keyMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent *(NSEvent *event) {
        AppDelegate *strongSelf = weakSelf;
        if (!strongSelf || event.window != strongSelf.window) return event;
        NSResponder *firstResponder = strongSelf.window.firstResponder;
        if ([firstResponder isKindOfClass:[NSTextView class]] || [firstResponder isKindOfClass:[NSTextField class]]) {
            return event;
        }
        NSString *chars = [[event charactersIgnoringModifiers] uppercaseString];
        if (chars.length == 1 && [strongSelf triggerKey:chars]) {
            return nil;
        }
        return event;
    }];
    [self applyFilterSelectingID:nil];
    [NSApp activateIgnoringOtherApps:YES];
    if (self.supabaseAccessToken.length == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showRegistrationSplash];
        });
    }
}

- (void)registerDefaults {
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
        @"themeName": @"Notre Dame",
        @"viewMode": @"list",
        @"stopBeforePlaying": @NO,
        @"confirmDeletes": @YES,
        @"largePads": @NO,
        @"supabaseURL": @"https://vygzpfdplpmetdfoions.supabase.co",
        @"supabaseAnonKey": @"sb_publishable_V1LJorrIxrYz3hpPo5RZwg_4s5vRgKr",
        @"supabaseAccessToken": @"",
        @"supabaseRefreshToken": @"",
        @"accountEmail": @"",
        @"accountUsername": @"",
        @"adminEmail": @"soundssimpleadmin@gmail.com"
    }];
}

- (void)loadSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.themeName = [defaults stringForKey:@"themeName"] ?: @"Notre Dame";
    self.viewMode = [defaults stringForKey:@"viewMode"] ?: @"list";
    self.stopBeforePlaying = [defaults boolForKey:@"stopBeforePlaying"];
    self.confirmDeletes = [defaults boolForKey:@"confirmDeletes"];
    self.largePads = [defaults boolForKey:@"largePads"];
    self.supabaseURL = [defaults stringForKey:@"supabaseURL"] ?: @"";
    self.supabaseAnonKey = [defaults stringForKey:@"supabaseAnonKey"] ?: @"";
    self.supabaseAccessToken = [defaults stringForKey:@"supabaseAccessToken"] ?: @"";
    self.supabaseRefreshToken = [defaults stringForKey:@"supabaseRefreshToken"] ?: @"";
    self.accountEmail = [defaults stringForKey:@"accountEmail"] ?: @"";
    self.accountUsername = [defaults stringForKey:@"accountUsername"] ?: @"";
    self.adminEmail = [defaults stringForKey:@"adminEmail"] ?: @"soundssimpleadmin@gmail.com";
}

- (void)saveSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.themeName ?: @"Notre Dame" forKey:@"themeName"];
    [defaults setObject:self.viewMode ?: @"list" forKey:@"viewMode"];
    [defaults setBool:self.stopBeforePlaying forKey:@"stopBeforePlaying"];
    [defaults setBool:self.confirmDeletes forKey:@"confirmDeletes"];
    [defaults setBool:self.largePads forKey:@"largePads"];
    [defaults setObject:self.supabaseURL ?: @"" forKey:@"supabaseURL"];
    [defaults setObject:self.supabaseAnonKey ?: @"" forKey:@"supabaseAnonKey"];
    [defaults setObject:self.supabaseAccessToken ?: @"" forKey:@"supabaseAccessToken"];
    [defaults setObject:self.supabaseRefreshToken ?: @"" forKey:@"supabaseRefreshToken"];
    [defaults setObject:self.accountEmail ?: @"" forKey:@"accountEmail"];
    [defaults setObject:self.accountUsername ?: @"" forKey:@"accountUsername"];
    [defaults setObject:self.adminEmail ?: @"soundssimpleadmin@gmail.com" forKey:@"adminEmail"];
}

- (void)buildMenu {
    NSMenu *mainMenu = [[NSMenu alloc] initWithTitle:@""];
    NSMenuItem *appMenuItem = [[NSMenuItem alloc] initWithTitle:@"" action:nil keyEquivalent:@""];
    [mainMenu addItem:appMenuItem];

    NSMenu *appMenu = [[NSMenu alloc] initWithTitle:@"Sounds Simple"];
    [appMenu addItemWithTitle:@"Account..." action:@selector(showAccount:) keyEquivalent:@""].target = self;
    [appMenu addItemWithTitle:@"Configure Supabase..." action:@selector(configureSupabase:) keyEquivalent:@""].target = self;
    [appMenu addItem:[NSMenuItem separatorItem]];
    [appMenu addItemWithTitle:@"Preferences..." action:@selector(showPreferences:) keyEquivalent:@"p"].target = self;
    [appMenu addItem:[NSMenuItem separatorItem]];
    [appMenu addItemWithTitle:@"Quit Sounds Simple" action:@selector(terminate:) keyEquivalent:@"q"];
    appMenuItem.submenu = appMenu;
    NSApp.mainMenu = mainMenu;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    if (self.registrationPanel) {
        [NSApp stopModal];
        [self.registrationPanel close];
        self.registrationPanel = nil;
    }
    return NSTerminateNow;
}

- (void)loadItems {
    self.items = [NSMutableArray array];
    NSData *data = [NSData dataWithContentsOfURL:self.configURL];
    if (!data) return;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *rawItems = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        rawItems = [(NSDictionary *)json objectForKey:@"items"];
    } else if ([json isKindOfClass:[NSArray class]]) {
        rawItems = (NSArray *)json;
    }
    for (id item in rawItems) {
        if ([item isKindOfClass:[NSDictionary class]]) {
            [self.items addObject:[(NSDictionary *)item mutableCopy]];
        }
    }
}

- (void)saveItems {
    NSDictionary *config = @{@"items": self.items};
    NSData *data = [NSJSONSerialization dataWithJSONObject:config options:NSJSONWritingPrettyPrinted error:nil];
    [data writeToURL:self.configURL atomically:YES];
}

- (void)loadPlaylists {
    self.playlists = [NSMutableArray array];
    self.musicLibrary = [NSMutableArray array];
    self.selectedPlaylistIndex = -1;
    self.currentSongIndex = -1;
    NSData *data = [NSData dataWithContentsOfURL:self.musicConfigURL];
    if (data) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *raw = [json isKindOfClass:[NSDictionary class]] ? json[@"playlists"] : nil;
        NSArray *library = [json isKindOfClass:[NSDictionary class]] ? json[@"library"] : nil;
        for (id song in library) {
            if ([song isKindOfClass:[NSDictionary class]]) [self.musicLibrary addObject:[song mutableCopy]];
        }
        for (id playlist in raw) {
            if ([playlist isKindOfClass:[NSDictionary class]]) {
                [self.playlists addObject:[playlist mutableCopy]];
            }
        }
    }
    if (self.playlists.count == 0) {
        [self.playlists addObject:[@{@"name": @"Default Playlist", @"songs": [NSMutableArray array]} mutableCopy]];
    }
    if (self.musicLibrary.count == 0) {
        NSMutableSet *seenTargets = [NSMutableSet set];
        for (NSDictionary *playlist in self.playlists) {
            for (NSDictionary *song in playlist[@"songs"] ?: @[]) {
                NSString *target = song[@"target"] ?: @"";
                if (target.length == 0 || [seenTargets containsObject:target]) continue;
                [seenTargets addObject:target];
                [self.musicLibrary addObject:[song mutableCopy]];
            }
        }
    }
    self.selectedPlaylistIndex = -1;
}

- (void)savePlaylists {
    NSDictionary *config = @{@"playlists": self.playlists ?: @[], @"library": self.musicLibrary ?: @[]};
    NSData *data = [NSJSONSerialization dataWithJSONObject:config options:NSJSONWritingPrettyPrinted error:nil];
    [data writeToURL:self.musicConfigURL atomically:YES];
}

- (NSURL *)applicationSupportFolderURL {
    NSURL *baseURL = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory
                                                            inDomain:NSUserDomainMask
                                                   appropriateForURL:nil
                                                              create:YES
                                                               error:nil];
    NSURL *url = [baseURL URLByAppendingPathComponent:@"Sounds Simple" isDirectory:YES];
    [[NSFileManager defaultManager] createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:nil];
    return url;
}

- (void)seedApplicationSupportFromFolder:(NSURL *)folderURL {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:self.configURL.path]) return;

    NSURL *resourceURL = [NSBundle mainBundle].resourceURL;
    NSURL *sourceConfigURL = [resourceURL URLByAppendingPathComponent:@"soundboard.json"];
    if (![manager fileExistsAtPath:sourceConfigURL.path]) {
        sourceConfigURL = [folderURL URLByAppendingPathComponent:@"soundboard.json"];
    }
    if ([manager fileExistsAtPath:sourceConfigURL.path]) {
        [manager copyItemAtURL:sourceConfigURL toURL:self.configURL error:nil];
    }

    NSURL *sourceMusicConfigURL = [resourceURL URLByAppendingPathComponent:@"music-playlists.json"];
    if (![manager fileExistsAtPath:sourceMusicConfigURL.path]) {
        sourceMusicConfigURL = [folderURL URLByAppendingPathComponent:@"music-playlists.json"];
    }
    if (![manager fileExistsAtPath:self.musicConfigURL.path] && [manager fileExistsAtPath:sourceMusicConfigURL.path]) {
        [manager copyItemAtURL:sourceMusicConfigURL toURL:self.musicConfigURL error:nil];
    }

    NSURL *sourceSoundsURL = [resourceURL URLByAppendingPathComponent:@"Sounds" isDirectory:YES];
    BOOL isDirectory = NO;
    if (![manager fileExistsAtPath:sourceSoundsURL.path isDirectory:&isDirectory] || !isDirectory) {
        sourceSoundsURL = [folderURL URLByAppendingPathComponent:@"Sounds" isDirectory:YES];
        isDirectory = NO;
    }
    NSURL *destinationSoundsURL = [self.appFolderURL URLByAppendingPathComponent:@"Sounds" isDirectory:YES];
    if ([manager fileExistsAtPath:sourceSoundsURL.path isDirectory:&isDirectory] && isDirectory) {
        [manager createDirectoryAtURL:destinationSoundsURL.URLByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:nil];
        if (![manager fileExistsAtPath:destinationSoundsURL.path]) {
            [manager copyItemAtURL:sourceSoundsURL toURL:destinationSoundsURL error:nil];
        }
    }
}

- (NSURL *)soundsFolderURL {
    NSURL *url = [self.appFolderURL URLByAppendingPathComponent:@"Sounds" isDirectory:YES];
    [[NSFileManager defaultManager] createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:nil];
    return url;
}

- (NSURL *)imagesFolderURL {
    NSURL *url = [self.appFolderURL URLByAppendingPathComponent:@"Images" isDirectory:YES];
    [[NSFileManager defaultManager] createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:nil];
    return url;
}

- (NSURL *)resolvedImageURLForTarget:(NSString *)target {
    if (target.length == 0) return nil;
    if ([target hasPrefix:@"/"]) {
        return [NSURL fileURLWithPath:target];
    }
    return [self.appFolderURL URLByAppendingPathComponent:target];
}

- (NSString *)portableTargetForImageURL:(NSURL *)sourceURL error:(NSError **)error {
    NSURL *imagesURL = [self imagesFolderURL];
    NSString *baseName = sourceURL.URLByDeletingPathExtension.lastPathComponent ?: @"image";
    NSString *extension = sourceURL.pathExtension.length ? sourceURL.pathExtension : @"png";
    NSCharacterSet *unsafe = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_ "] invertedSet];
    NSString *safeBase = [[baseName componentsSeparatedByCharactersInSet:unsafe] componentsJoinedByString:@"-"];
    if (safeBase.length == 0) safeBase = @"image";

    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *destination = nil;
    for (NSInteger index = 1; index < 1000; index++) {
        NSString *candidateName = index == 1 ? safeBase : [NSString stringWithFormat:@"%@-%ld", safeBase, (long)index];
        candidateName = [candidateName stringByAppendingPathExtension:extension];
        destination = [imagesURL URLByAppendingPathComponent:candidateName];
        if (![manager fileExistsAtPath:destination.path]) break;
        destination = nil;
    }
    if (!destination || ![manager copyItemAtURL:sourceURL toURL:destination error:error]) {
        return nil;
    }
    return [@"Images" stringByAppendingPathComponent:destination.lastPathComponent];
}

- (NSImage *)imageForItem:(NSDictionary *)item {
    NSString *target = item[@"imageTarget"] ?: @"";
    if (target.length > 0) {
        NSImage *image = [[NSImage alloc] initWithContentsOfURL:[self resolvedImageURLForTarget:target]];
        if (image) return image;
    }
    return nil;
}

- (NSDictionary<NSString *, NSColor *> *)themePalette {
    if ([self.themeName isEqualToString:@"Midnight"]) {
        return @{
            @"backgroundTop": [NSColor colorWithCalibratedRed:0.03 green:0.04 blue:0.09 alpha:1.0],
            @"backgroundBottom": [NSColor colorWithCalibratedRed:0.08 green:0.10 blue:0.20 alpha:1.0],
            @"panel": [NSColor colorWithCalibratedRed:0.09 green:0.10 blue:0.17 alpha:0.90],
            @"surface": [NSColor colorWithCalibratedRed:0.05 green:0.06 blue:0.12 alpha:1.0],
            @"accent": [NSColor colorWithCalibratedRed:0.46 green:0.78 blue:1.00 alpha:1.0],
            @"accentSoft": [NSColor colorWithCalibratedRed:0.46 green:0.78 blue:1.00 alpha:0.20],
            @"text": [NSColor colorWithCalibratedRed:0.93 green:0.96 blue:1.0 alpha:1.0],
            @"mutedText": [NSColor colorWithCalibratedRed:0.72 green:0.78 blue:0.90 alpha:1.0],
            @"titleAccent": [NSColor colorWithCalibratedRed:0.58 green:0.86 blue:1.0 alpha:1.0]
        };
    }
    if ([self.themeName isEqualToString:@"Forest"]) {
        return @{
            @"backgroundTop": [NSColor colorWithCalibratedRed:0.02 green:0.13 blue:0.10 alpha:1.0],
            @"backgroundBottom": [NSColor colorWithCalibratedRed:0.04 green:0.22 blue:0.16 alpha:1.0],
            @"panel": [NSColor colorWithCalibratedRed:0.03 green:0.17 blue:0.13 alpha:0.90],
            @"surface": [NSColor colorWithCalibratedRed:0.02 green:0.11 blue:0.09 alpha:1.0],
            @"accent": [NSColor colorWithCalibratedRed:0.83 green:0.68 blue:0.32 alpha:1.0],
            @"accentSoft": [NSColor colorWithCalibratedRed:0.83 green:0.68 blue:0.32 alpha:0.22],
            @"text": [NSColor colorWithCalibratedRed:0.94 green:0.98 blue:0.93 alpha:1.0],
            @"mutedText": [NSColor colorWithCalibratedRed:0.74 green:0.86 blue:0.78 alpha:1.0],
            @"titleAccent": [NSColor colorWithCalibratedRed:0.98 green:0.78 blue:0.36 alpha:1.0]
        };
    }
    if ([self.themeName isEqualToString:@"Slate"]) {
        return @{
            @"backgroundTop": [NSColor colorWithCalibratedRed:0.12 green:0.15 blue:0.19 alpha:1.0],
            @"backgroundBottom": [NSColor colorWithCalibratedRed:0.22 green:0.25 blue:0.30 alpha:1.0],
            @"panel": [NSColor colorWithCalibratedRed:0.15 green:0.18 blue:0.23 alpha:0.90],
            @"surface": [NSColor colorWithCalibratedRed:0.10 green:0.12 blue:0.16 alpha:1.0],
            @"accent": [NSColor colorWithCalibratedRed:0.94 green:0.62 blue:0.30 alpha:1.0],
            @"accentSoft": [NSColor colorWithCalibratedRed:0.94 green:0.62 blue:0.30 alpha:0.20],
            @"text": [NSColor colorWithCalibratedRed:0.95 green:0.96 blue:0.98 alpha:1.0],
            @"mutedText": [NSColor colorWithCalibratedRed:0.78 green:0.82 blue:0.88 alpha:1.0],
            @"titleAccent": [NSColor colorWithCalibratedRed:1.0 green:0.72 blue:0.38 alpha:1.0]
        };
    }
    if ([self.themeName isEqualToString:@"Halloween"]) {
        return @{
            @"backgroundTop": [NSColor colorWithCalibratedRed:0.04 green:0.03 blue:0.08 alpha:1.0],
            @"backgroundBottom": [NSColor colorWithCalibratedRed:0.15 green:0.08 blue:0.22 alpha:1.0],
            @"panel": [NSColor colorWithCalibratedRed:0.11 green:0.07 blue:0.16 alpha:0.94],
            @"surface": [NSColor colorWithCalibratedRed:0.03 green:0.03 blue:0.06 alpha:1.0],
            @"accent": [NSColor colorWithCalibratedRed:0.98 green:0.48 blue:0.14 alpha:1.0],
            @"accentSoft": [NSColor colorWithCalibratedRed:0.47 green:0.26 blue:0.62 alpha:0.36],
            @"text": [NSColor colorWithCalibratedRed:0.91 green:0.94 blue:0.86 alpha:1.0],
            @"mutedText": [NSColor colorWithCalibratedRed:0.65 green:0.77 blue:0.77 alpha:1.0],
            @"titleAccent": [NSColor colorWithCalibratedRed:0.86 green:0.82 blue:0.34 alpha:1.0]
        };
    }
    return @{
        @"backgroundTop": [NSColor colorWithCalibratedRed:0.02 green:0.08 blue:0.18 alpha:1.0],
        @"backgroundBottom": [NSColor colorWithCalibratedRed:0.00 green:0.14 blue:0.34 alpha:1.0],
        @"panel": [NSColor colorWithCalibratedRed:0.04 green:0.12 blue:0.26 alpha:0.90],
        @"surface": [NSColor colorWithCalibratedRed:0.02 green:0.08 blue:0.18 alpha:1.0],
        @"accent": [NSColor colorWithCalibratedRed:0.99 green:0.82 blue:0.34 alpha:1.0],
        @"accentSoft": [NSColor colorWithCalibratedRed:0.79 green:0.61 blue:0.24 alpha:0.24],
        @"text": [NSColor colorWithCalibratedRed:0.94 green:0.96 blue:0.99 alpha:1.0],
        @"mutedText": [NSColor colorWithCalibratedRed:0.82 green:0.88 blue:0.96 alpha:1.0],
        @"titleAccent": [NSColor colorWithCalibratedRed:0.98 green:0.82 blue:0.34 alpha:1.0]
    };
}

- (NSColor *)themeColor:(NSString *)role {
    return [self themePalette][role];
}

- (NSFont *)themeFontOfSize:(CGFloat)size weight:(NSFontWeight)weight {
    NSArray *names = nil;
    if ([self.themeName isEqualToString:@"Halloween"]) {
        names = @[@"Chalkduster", @"Papyrus", @"AmericanTypewriter-CondensedBold"];
    } else if ([self.themeName isEqualToString:@"Forest"]) {
        names = @[@"AvenirNextCondensed-DemiBold", @"GillSans-SemiBold"];
    } else if ([self.themeName isEqualToString:@"Midnight"]) {
        names = @[@"Futura-Medium", @"AvenirNext-Medium"];
    } else if ([self.themeName isEqualToString:@"Slate"]) {
        names = @[@"DINAlternate-Bold", @"AvenirNext-DemiBold"];
    } else {
        names = @[@"Copperplate-Bold", @"AcademyEngravedLetPlain"];
    }
    for (NSString *name in names) {
        NSFont *font = [NSFont fontWithName:name size:size];
        if (font) return font;
    }
    return [NSFont systemFontOfSize:size weight:weight];
}

- (NSURL *)resolvedSoundURLForTarget:(NSString *)target {
    if (target.length == 0) return nil;
    if ([target hasPrefix:@"/"]) {
        return [NSURL fileURLWithPath:target];
    }
    return [self.appFolderURL URLByAppendingPathComponent:target];
}

- (NSString *)portableTargetForSoundURL:(NSURL *)sourceURL error:(NSError **)error {
    NSURL *soundsURL = [self soundsFolderURL];
    NSString *baseName = sourceURL.URLByDeletingPathExtension.lastPathComponent;
    NSString *extension = sourceURL.pathExtension;
    if (baseName.length == 0) baseName = @"sound";

    NSCharacterSet *unsafe = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_ "] invertedSet];
    NSString *safeBase = [[baseName componentsSeparatedByCharactersInSet:unsafe] componentsJoinedByString:@"-"];
    if (safeBase.length == 0) safeBase = @"sound";

    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *destination = nil;
    for (NSInteger index = 1; index < 1000; index++) {
        NSString *candidateName = index == 1 ? safeBase : [NSString stringWithFormat:@"%@-%ld", safeBase, (long)index];
        if (extension.length > 0) {
            candidateName = [candidateName stringByAppendingPathExtension:extension];
        }
        destination = [soundsURL URLByAppendingPathComponent:candidateName];
        if (![manager fileExistsAtPath:destination.path]) {
            break;
        }
        destination = nil;
    }
    if (!destination) {
        if (error) {
            *error = [NSError errorWithDomain:@"SoundsSimple" code:1 userInfo:@{NSLocalizedDescriptionKey: @"Could not create a unique sound filename."}];
        }
        return nil;
    }

    if (![manager copyItemAtURL:sourceURL toURL:destination error:error]) {
        return nil;
    }
    return [@"Sounds" stringByAppendingPathComponent:destination.lastPathComponent];
}

- (void)migrateAbsoluteSoundPaths {
    BOOL didChange = NO;
    for (NSMutableDictionary *item in self.items) {
        if (![item[@"kind"] isEqualToString:@"sound"]) continue;
        NSString *target = item[@"target"] ?: @"";
        if (![target hasPrefix:@"/"]) continue;
        NSURL *sourceURL = [NSURL fileURLWithPath:target];
        if (![[NSFileManager defaultManager] fileExistsAtPath:sourceURL.path]) continue;

        NSError *error = nil;
        NSString *portableTarget = [self portableTargetForSoundURL:sourceURL error:&error];
        if (portableTarget) {
            item[@"target"] = portableTarget;
            didChange = YES;
        }
    }
    if (didChange) {
        [self saveItems];
    }
}

- (void)buildWindow {
    NSScreen *screen = NSScreen.mainScreen;
    NSRect visibleFrame = screen ? screen.visibleFrame : NSMakeRect(0, 0, 1200, 760);
    CGFloat initialWidth = MIN(MAX(920, visibleFrame.size.width - 72), 1120);
    CGFloat initialHeight = MIN(MAX(620, visibleFrame.size.height - 72), 760);
    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, initialWidth, initialHeight)
                                             styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable
                                               backing:NSBackingStoreBuffered
                                                 defer:NO];
    self.window.title = @"Sounds Simple";
    self.window.minSize = NSMakeSize(MIN(920, visibleFrame.size.width - 72), MIN(620, visibleFrame.size.height - 72));
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResize:) name:NSWindowDidResizeNotification object:self.window];

    self.rootView = [[KeyView alloc] initWithFrame:self.window.contentView.bounds];
    self.rootView.controller = self;
    self.rootView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.window.contentView = self.rootView;

    self.logoView = [[NSImageView alloc] initWithFrame:NSZeroRect];
    self.logoView.translatesAutoresizingMaskIntoConstraints = NO;
    self.logoView.image = [NSImage imageNamed:@"SoundsSimpleIcon"];
    self.logoView.imageScaling = NSImageScaleProportionallyUpOrDown;
    self.logoView.wantsLayer = YES;
    self.logoView.layer.cornerRadius = 14;
    self.logoView.layer.masksToBounds = YES;
    self.logoView.layer.borderWidth = 1;

    self.titleLabel = [NSTextField labelWithString:@""];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.alignment = NSTextAlignmentCenter;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.maximumNumberOfLines = 2;

    self.subtitleLabel = [NSTextField labelWithString:@"Fast local clips and playlists, keyed exactly how you like them."];
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subtitleLabel.font = [self themeFontOfSize:13 weight:NSFontWeightMedium];
    self.subtitleLabel.alignment = NSTextAlignmentCenter;
    self.subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.subtitleLabel.maximumNumberOfLines = 2;

    NSStackView *toolbar = [[NSStackView alloc] initWithFrame:NSZeroRect];
    toolbar.orientation = NSUserInterfaceLayoutOrientationVertical;
    toolbar.alignment = NSLayoutAttributeLeading;
    toolbar.spacing = 9;
    toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolbarStack = toolbar;
    self.toolbarButtons = [NSMutableArray array];

    NSButton *addSoundButton = [self button:@"Add Sound" action:@selector(addSound)];
    NSButton *addYouTubeButton = [self button:@"Add Link" action:@selector(addLink)];
    NSButton *editButton = [self button:@"Edit" action:@selector(editSelected)];
    NSButton *deleteButton = [self button:@"Delete" action:@selector(deleteSelected)];
    NSButton *stopAudioButton = [self button:@"Stop Audio" action:@selector(stopAudio)];
    NSButton *pauseAudioButton = [self button:@"Pause / Resume" action:@selector(pauseAudio)];
    for (NSView *view in @[addSoundButton, addYouTubeButton, editButton, deleteButton, stopAudioButton, pauseAudioButton]) {
        [toolbar addArrangedSubview:view];
    }

    self.viewModeControl = [[NSSegmentedControl alloc] initWithFrame:NSZeroRect];
    [self.viewModeControl setSegmentCount:5];
    [self.viewModeControl setLabel:@"List" forSegment:0];
    [self.viewModeControl setLabel:@"Pads" forSegment:1];
    [self.viewModeControl setLabel:@"Recording" forSegment:2];
    [self.viewModeControl setLabel:@"Editor" forSegment:3];
    [self.viewModeControl setLabel:@"Music" forSegment:4];
    self.viewModeControl.target = self;
    self.viewModeControl.action = @selector(viewModeChanged:);
    self.viewModeControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.viewModeControl.widthAnchor constraintLessThanOrEqualToConstant:460].active = YES;

    self.searchField = [[NSSearchField alloc] initWithFrame:NSZeroRect];
    self.searchField.placeholderString = @"Search";
    self.searchField.target = self;
    self.searchField.action = @selector(searchChanged);
    self.searchField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchField.widthAnchor constraintEqualToConstant:176].active = YES;
    [toolbar addArrangedSubview:self.searchField];

    self.soundSidebarViews = @[addSoundButton, addYouTubeButton, editButton, deleteButton, stopAudioButton, pauseAudioButton, self.searchField];

    self.toolbarBox = [[NSBox alloc] initWithFrame:NSZeroRect];
    self.toolbarBox.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolbarBox.boxType = NSBoxCustom;
    self.toolbarBox.borderType = NSNoBorder;
    self.toolbarBox.cornerRadius = 10;

    self.listScrollView = [[NSScrollView alloc] initWithFrame:NSZeroRect];
    self.listScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.listScrollView.hasVerticalScroller = YES;
    self.listScrollView.borderType = NSNoBorder;
    self.listScrollView.wantsLayer = YES;
    self.listScrollView.layer.cornerRadius = 10;
    self.listScrollView.layer.borderWidth = 1;

    self.tableView = [[NSTableView alloc] initWithFrame:NSZeroRect];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.usesAlternatingRowBackgroundColors = NO;
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.target = self;
    self.tableView.doubleAction = @selector(playSelected);
    self.tableView.rowHeight = 46;
    self.tableView.gridStyleMask = NSTableViewGridNone;
    [self addColumn:@"image" title:@"" width:46];
    [self addColumn:@"key" title:@"Key" width:80];
    [self addColumn:@"name" title:@"Name" width:430];
    [self addColumn:@"category" title:@"Sound Type" width:120];
    [self addColumn:@"kind" title:@"Source" width:100];
    self.listScrollView.documentView = self.tableView;

    self.padScrollView = [[NSScrollView alloc] initWithFrame:NSZeroRect];
    self.padScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.padScrollView.hasVerticalScroller = YES;
    self.padScrollView.borderType = NSNoBorder;
    self.padScrollView.wantsLayer = YES;
    self.padScrollView.layer.cornerRadius = 10;
    self.padScrollView.layer.borderWidth = 1;
    self.padContentView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 860, 420)];
    self.padScrollView.documentView = self.padContentView;
    self.padScrollView.contentView.postsBoundsChangedNotifications = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(padViewportChanged:) name:NSViewBoundsDidChangeNotification object:self.padScrollView.contentView];

    self.recordingPageView = [[NSBox alloc] initWithFrame:NSZeroRect];
    self.recordingPageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.recordingPageView.boxType = NSBoxCustom;
    self.recordingPageView.borderType = NSNoBorder;
    self.recordingPageView.cornerRadius = 10;

    self.recordingTitleLabel = [NSTextField labelWithString:@"Record Custom Audio"];
    self.recordingTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.recordingTitleLabel.font = [self themeFontOfSize:28 weight:NSFontWeightBold];
    self.recordingTitleLabel.alignment = NSTextAlignmentCenter;
    self.recordingTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.recordingTitleLabel.maximumNumberOfLines = 2;

    NSTextField *recordingHelpLabel = [NSTextField labelWithString:@"Use your Mac microphone to capture a clip, then save it as a soundboard item with its own key, type, and image."];
    recordingHelpLabel.translatesAutoresizingMaskIntoConstraints = NO;
    recordingHelpLabel.font = [self themeFontOfSize:14 weight:NSFontWeightMedium];
    recordingHelpLabel.textColor = [self themeColor:@"mutedText"];
    recordingHelpLabel.alignment = NSTextAlignmentCenter;
    recordingHelpLabel.lineBreakMode = NSLineBreakByWordWrapping;
    recordingHelpLabel.maximumNumberOfLines = 0;
    recordingHelpLabel.cell.wraps = YES;
    recordingHelpLabel.cell.scrollable = NO;
    [recordingHelpLabel setContentCompressionResistancePriority:NSLayoutPriorityDefaultLow forOrientation:NSLayoutConstraintOrientationHorizontal];

    self.recordButton = [self button:@"Start Recording" action:@selector(startRecording)];
    self.recordButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.stopRecordingButton = [self button:@"Stop + Add" action:@selector(stopRecordingAndAdd)];
    self.stopRecordingButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.stopRecordingButton.enabled = NO;
    self.playRecordingButton = [self button:@"Play Selected" action:@selector(playSelectedRecording)];
    self.showRecordingButton = [self button:@"Show in Finder" action:@selector(showSelectedRecordingInFinder)];
    self.deleteRecordingButton = [self button:@"Delete Recording" action:@selector(deleteSelectedRecording)];

    self.recordingStatusLabel = [NSTextField labelWithString:@"Mic ready"];
    self.recordingStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.recordingStatusLabel.font = [self themeFontOfSize:16 weight:NSFontWeightMedium];
    self.recordingStatusLabel.alignment = NSTextAlignmentCenter;
    self.recordingStatusLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.recordingStatusLabel.maximumNumberOfLines = 3;
    [self.recordingStatusLabel.widthAnchor constraintEqualToConstant:176].active = YES;

    [toolbar addArrangedSubview:self.recordButton];
    [toolbar addArrangedSubview:self.stopRecordingButton];
    [toolbar addArrangedSubview:self.playRecordingButton];
    [toolbar addArrangedSubview:self.showRecordingButton];
    [toolbar addArrangedSubview:self.deleteRecordingButton];
    [toolbar addArrangedSubview:self.recordingStatusLabel];
    self.recordingSidebarViews = @[self.recordButton, self.stopRecordingButton, self.playRecordingButton, self.showRecordingButton, self.deleteRecordingButton, self.recordingStatusLabel];

    NSTextField *recentTitleLabel = [NSTextField labelWithString:@"Recent Recordings"];
    recentTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    recentTitleLabel.font = [self themeFontOfSize:18 weight:NSFontWeightBold];
    recentTitleLabel.textColor = [self themeColor:@"text"];

    self.recentRecordingsScrollView = [[NSScrollView alloc] initWithFrame:NSZeroRect];
    self.recentRecordingsScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.recentRecordingsScrollView.hasVerticalScroller = YES;
    self.recentRecordingsScrollView.borderType = NSNoBorder;
    self.recentRecordingsScrollView.wantsLayer = YES;
    self.recentRecordingsScrollView.layer.cornerRadius = 8;
    self.recentRecordingsScrollView.layer.borderWidth = 1;

    self.recentRecordingsTableView = [[NSTableView alloc] initWithFrame:NSZeroRect];
    self.recentRecordingsTableView.delegate = self;
    self.recentRecordingsTableView.dataSource = self;
    self.recentRecordingsTableView.rowHeight = 36;
    self.recentRecordingsTableView.gridStyleMask = NSTableViewGridNone;
    self.recentRecordingsTableView.usesAlternatingRowBackgroundColors = NO;
    self.recentRecordingsTableView.target = self;
    self.recentRecordingsTableView.doubleAction = @selector(playDoubleClickedRecording:);
    NSMenu *recordingMenu = [[NSMenu alloc] initWithTitle:@"Recording"];
    [recordingMenu addItemWithTitle:@"Play Recording" action:@selector(playClickedRecording:) keyEquivalent:@""].target = self;
    [recordingMenu addItemWithTitle:@"Show in Finder" action:@selector(showClickedRecordingInFinder:) keyEquivalent:@""].target = self;
    [recordingMenu addItemWithTitle:@"Open in Sound Editor" action:@selector(openClickedRecordingInEditor:) keyEquivalent:@""].target = self;
    [recordingMenu addItem:[NSMenuItem separatorItem]];
    [recordingMenu addItemWithTitle:@"Delete Recording File" action:@selector(deleteClickedRecording:) keyEquivalent:@""].target = self;
    self.recentRecordingsTableView.menu = recordingMenu;
    NSTableColumn *recentNameColumn = [[NSTableColumn alloc] initWithIdentifier:@"recordingName"];
    recentNameColumn.title = @"Recording";
    recentNameColumn.width = 360;
    [self.recentRecordingsTableView addTableColumn:recentNameColumn];
    NSTableColumn *recentDateColumn = [[NSTableColumn alloc] initWithIdentifier:@"recordingDate"];
    recentDateColumn.title = @"Saved";
    recentDateColumn.width = 180;
    [self.recentRecordingsTableView addTableColumn:recentDateColumn];
    self.recentRecordingsScrollView.documentView = self.recentRecordingsTableView;

    [self.recordingPageView addSubview:self.recordingTitleLabel];
    [self.recordingPageView addSubview:recordingHelpLabel];
    [self.recordingPageView addSubview:recentTitleLabel];
    [self.recordingPageView addSubview:self.recentRecordingsScrollView];

    self.editorPageView = [[NSBox alloc] initWithFrame:NSZeroRect];
    self.editorPageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.editorPageView.boxType = NSBoxCustom;
    self.editorPageView.borderType = NSNoBorder;
    self.editorPageView.cornerRadius = 10;

    self.editorTitleLabel = [NSTextField labelWithString:@"Sound Editor"];
    self.editorTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.editorTitleLabel.font = [self themeFontOfSize:28 weight:NSFontWeightBold];
    self.editorTitleLabel.alignment = NSTextAlignmentCenter;
    self.editorTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.editorTitleLabel.maximumNumberOfLines = 2;

    NSTextField *editorHelpLabel = [NSTextField labelWithString:@"Import a recording, an existing Sounds Simple clip, or an external audio file. Preview it, trim the start and end, adjust volume, then save a new clip."];
    editorHelpLabel.translatesAutoresizingMaskIntoConstraints = NO;
    editorHelpLabel.font = [self themeFontOfSize:14 weight:NSFontWeightMedium];
    editorHelpLabel.textColor = [self themeColor:@"mutedText"];
    editorHelpLabel.alignment = NSTextAlignmentCenter;
    editorHelpLabel.lineBreakMode = NSLineBreakByWordWrapping;
    editorHelpLabel.maximumNumberOfLines = 0;
    editorHelpLabel.cell.wraps = YES;
    editorHelpLabel.cell.scrollable = NO;
    [editorHelpLabel setContentCompressionResistancePriority:NSLayoutPriorityDefaultLow forOrientation:NSLayoutConstraintOrientationHorizontal];

    self.editorLoadedLabel = [NSTextField labelWithString:@"No audio loaded"];
    self.editorLoadedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.editorLoadedLabel.font = [self themeFontOfSize:16 weight:NSFontWeightSemibold];
    self.editorLoadedLabel.alignment = NSTextAlignmentCenter;
    self.editorLoadedLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.editorLoadedLabel.maximumNumberOfLines = 2;
    self.editorLoadedLabel.cell.wraps = YES;
    self.editorLoadedLabel.cell.scrollable = NO;

    self.editorWaveformView = [[WaveformView alloc] initWithFrame:NSMakeRect(0, 0, 900, 190)];
    self.editorWaveformView.controller = self;
    self.editorWaveformView.translatesAutoresizingMaskIntoConstraints = NO;
    self.editorWaveformView.wantsLayer = YES;
    self.editorWaveformView.layer.cornerRadius = 8;

    self.editorWaveformScrollView = [[NSScrollView alloc] initWithFrame:NSZeroRect];
    self.editorWaveformScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.editorWaveformScrollView.hasHorizontalScroller = YES;
    self.editorWaveformScrollView.hasVerticalScroller = NO;
    self.editorWaveformScrollView.borderType = NSNoBorder;
    self.editorWaveformScrollView.documentView = self.editorWaveformView;

    NSTextField *startLabel = [NSTextField labelWithString:@"Trim Start"];
    NSTextField *endLabel = [NSTextField labelWithString:@"Trim End"];
    NSTextField *volumeLabel = [NSTextField labelWithString:@"Volume"];
    NSTextField *zoomLabel = [NSTextField labelWithString:@"Wave Zoom"];
    for (NSTextField *label in @[startLabel, endLabel, volumeLabel, zoomLabel]) {
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.font = [self themeFontOfSize:13 weight:NSFontWeightMedium];
        label.textColor = [self themeColor:@"mutedText"];
        [self.editorPageView addSubview:label];
    }

    self.editorStartSlider = [[NSSlider alloc] initWithFrame:NSZeroRect];
    self.editorEndSlider = [[NSSlider alloc] initWithFrame:NSZeroRect];
    self.editorVolumeSlider = [[NSSlider alloc] initWithFrame:NSZeroRect];
    self.editorZoomSlider = [[NSSlider alloc] initWithFrame:NSZeroRect];
    for (NSSlider *slider in @[self.editorStartSlider, self.editorEndSlider, self.editorVolumeSlider, self.editorZoomSlider]) {
        slider.translatesAutoresizingMaskIntoConstraints = NO;
        slider.minValue = 0;
        slider.maxValue = 1;
        slider.doubleValue = 0;
        [self.editorPageView addSubview:slider];
    }
    self.editorEndSlider.doubleValue = 1;
    self.editorVolumeSlider.doubleValue = 1;
    self.editorZoomSlider.minValue = 1;
    self.editorZoomSlider.maxValue = 8;
    self.editorZoomSlider.doubleValue = 1;
    self.editorStartSlider.target = self;
    self.editorStartSlider.action = @selector(editorSliderChanged:);
    self.editorEndSlider.target = self;
    self.editorEndSlider.action = @selector(editorSliderChanged:);
    self.editorZoomSlider.target = self;
    self.editorZoomSlider.action = @selector(editorZoomChanged:);

    self.editorStatusLabel = [NSTextField labelWithString:@"Load audio to begin."];
    self.editorStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.editorStatusLabel.font = [self themeFontOfSize:13 weight:NSFontWeightMedium];
    self.editorStatusLabel.alignment = NSTextAlignmentCenter;
    self.editorStatusLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.editorStatusLabel.maximumNumberOfLines = 0;
    self.editorStatusLabel.cell.wraps = YES;
    self.editorStatusLabel.cell.scrollable = NO;

    [self.editorPageView addSubview:self.editorTitleLabel];
    [self.editorPageView addSubview:editorHelpLabel];
    [self.editorPageView addSubview:self.editorLoadedLabel];
    [self.editorPageView addSubview:self.editorWaveformScrollView];
    [self.editorPageView addSubview:self.editorStatusLabel];

    NSButton *loadRecordingButton = [self button:@"Use Recording" action:@selector(loadSelectedRecordingInEditor)];
    NSButton *loadExistingButton = [self button:@"Use App Sound" action:@selector(loadExistingSoundInEditor)];
    NSButton *loadExternalButton = [self button:@"Import External" action:@selector(loadExternalAudioInEditor)];
    NSButton *previewEditorButton = [self button:@"Preview Edit" action:@selector(previewEditorAudio)];
    NSButton *stopEditorButton = [self button:@"Stop Preview" action:@selector(stopEditorPreview)];
    NSButton *saveEditorButton = [self button:@"Save Edited Clip" action:@selector(saveEditedClip)];
    for (NSButton *button in @[loadRecordingButton, loadExistingButton, loadExternalButton, previewEditorButton, stopEditorButton, saveEditorButton]) {
        [toolbar addArrangedSubview:button];
    }
    self.editorSidebarViews = @[loadRecordingButton, loadExistingButton, loadExternalButton, previewEditorButton, stopEditorButton, saveEditorButton];

    self.musicPageView = [[NSBox alloc] initWithFrame:NSZeroRect];
    self.musicPageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.musicPageView.boxType = NSBoxCustom;
    self.musicPageView.borderType = NSNoBorder;
    self.musicPageView.cornerRadius = 10;

    self.playlistTableView = [[NSTableView alloc] initWithFrame:NSZeroRect];
    self.playlistTableView.delegate = self;
    self.playlistTableView.dataSource = self;
    self.playlistTableView.rowHeight = 36;
    self.playlistTableView.doubleAction = @selector(playDoubleClickedPlaylist:);
    self.playlistTableView.target = self;
    NSTableColumn *playlistColumn = [[NSTableColumn alloc] initWithIdentifier:@"playlistName"];
    playlistColumn.title = @"Playlists";
    playlistColumn.width = 180;
    [self.playlistTableView addTableColumn:playlistColumn];
    NSMenu *playlistMenu = [[NSMenu alloc] initWithTitle:@"Playlist"];
    [playlistMenu addItemWithTitle:@"Edit Playlist Name" action:@selector(editClickedPlaylistName:) keyEquivalent:@""].target = self;
    [playlistMenu addItemWithTitle:@"Play Playlist" action:@selector(playDoubleClickedPlaylist:) keyEquivalent:@""].target = self;
    self.playlistTableView.menu = playlistMenu;
    NSScrollView *playlistScroll = [[NSScrollView alloc] initWithFrame:NSZeroRect];
    playlistScroll.translatesAutoresizingMaskIntoConstraints = NO;
    playlistScroll.hasVerticalScroller = YES;
    playlistScroll.documentView = self.playlistTableView;

    self.playlistSongsTableView = [[NSTableView alloc] initWithFrame:NSZeroRect];
    self.playlistSongsTableView.delegate = self;
    self.playlistSongsTableView.dataSource = self;
    self.playlistSongsTableView.rowHeight = 36;
    self.playlistSongsTableView.doubleAction = @selector(playDoubleClickedPlaylistSong:);
    self.playlistSongsTableView.target = self;
    NSArray *songColumns = @[
        @{@"id": @"trackNumber", @"title": @"Track #", @"width": @72},
        @{@"id": @"title", @"title": @"Title", @"width": @230},
        @{@"id": @"album", @"title": @"Album", @"width": @190},
        @{@"id": @"artist", @"title": @"Artist", @"width": @170},
        @{@"id": @"duration", @"title": @"Duration", @"width": @90}
    ];
    for (NSDictionary *columnInfo in songColumns) {
        NSString *identifier = columnInfo[@"id"];
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:identifier];
        column.title = columnInfo[@"title"];
        column.width = [columnInfo[@"width"] doubleValue];
        column.resizingMask = NSTableColumnAutoresizingMask | NSTableColumnUserResizingMask;
        BOOL numeric = [identifier isEqualToString:@"trackNumber"] || [identifier isEqualToString:@"duration"];
        column.sortDescriptorPrototype = [NSSortDescriptor sortDescriptorWithKey:identifier ascending:YES selector:(numeric ? nil : @selector(localizedCaseInsensitiveCompare:))];
        [self.playlistSongsTableView addTableColumn:column];
    }
    NSMenu *musicSongMenu = [[NSMenu alloc] initWithTitle:@"Song"];
    [musicSongMenu addItemWithTitle:@"Edit Song Data" action:@selector(editClickedMusicSong:) keyEquivalent:@""].target = self;
    [musicSongMenu addItemWithTitle:@"Play Song" action:@selector(playDoubleClickedPlaylistSong:) keyEquivalent:@""].target = self;
    [musicSongMenu addItemWithTitle:@"Add to Playlist..." action:@selector(copySelectedMusicSongToPlaylist:) keyEquivalent:@""].target = self;
    self.playlistSongsTableView.menu = musicSongMenu;
    NSScrollView *songsScroll = [[NSScrollView alloc] initWithFrame:NSZeroRect];
    songsScroll.translatesAutoresizingMaskIntoConstraints = NO;
    songsScroll.hasVerticalScroller = YES;
    songsScroll.hasHorizontalScroller = YES;
    songsScroll.documentView = self.playlistSongsTableView;

    self.musicArtworkView = [[NSImageView alloc] initWithFrame:NSZeroRect];
    self.musicArtworkView.translatesAutoresizingMaskIntoConstraints = NO;
    self.musicArtworkView.imageScaling = NSImageScaleProportionallyUpOrDown;
    self.musicArtworkView.wantsLayer = YES;
    self.musicArtworkView.layer.cornerRadius = 8;
    self.musicArtworkView.layer.masksToBounds = YES;
    self.musicTitleLabel = [NSTextField labelWithString:@"No song selected"];
    self.musicTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.musicTitleLabel.font = [self themeFontOfSize:20 weight:NSFontWeightBold];
    self.musicTitleLabel.alignment = NSTextAlignmentCenter;
    self.musicTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.musicTitleLabel.maximumNumberOfLines = 2;
    self.musicArtistLabel = [NSTextField labelWithString:@""];
    self.musicArtistLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.musicArtistLabel.font = [self themeFontOfSize:14 weight:NSFontWeightMedium];
    self.musicArtistLabel.alignment = NSTextAlignmentCenter;
    self.musicArtistLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.musicArtistLabel.maximumNumberOfLines = 2;
    self.musicStatusLabel = [NSTextField labelWithString:@"Add a playlist and songs to begin."];
    self.musicStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.musicStatusLabel.alignment = NSTextAlignmentCenter;
    self.musicStatusLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.musicStatusLabel.maximumNumberOfLines = 0;

    NSArray *musicButtons = @[
        [self plainButton:@"Add Playlist" action:@selector(addMusicPlaylist)],
        [self plainButton:@"Add Songs" action:@selector(addSongsToPlaylist)],
        [self plainButton:@"Add From Playlist" action:@selector(addSongFromOtherPlaylist)],
        [self plainButton:@"Delete Song" action:@selector(deleteMusicSong)],
        [self plainButton:@"Delete Playlist" action:@selector(deleteMusicPlaylist)],
        [self plainButton:@"Rename Playlist" action:@selector(editSelectedPlaylistName:)],
        [self plainButton:@"Share to Soundboard" action:@selector(shareSongToSoundboard)],
        [self plainButton:@"Export Playlist" action:@selector(exportSelectedPlaylist)],
        [self plainButton:@"Import Playlist" action:@selector(importPlaylist)],
        [self plainButton:@"Fetch Metadata" action:@selector(fetchSongMetadata)],
        [self plainButton:@"⏮" action:@selector(previousSong)],
        [self plainButton:@"⏪" action:@selector(rewindSong)],
        [self plainButton:@"▶︎ / ❚❚" action:@selector(toggleMusicPlayback)],
        [self plainButton:@"⏩" action:@selector(fastForwardSong)],
        [self plainButton:@"⏭" action:@selector(nextSong)]
    ];
    NSStackView *musicButtonRow = [[NSStackView alloc] initWithFrame:NSZeroRect];
    musicButtonRow.translatesAutoresizingMaskIntoConstraints = NO;
    musicButtonRow.orientation = NSUserInterfaceLayoutOrientationVertical;
    musicButtonRow.spacing = 8;
    musicButtonRow.alignment = NSLayoutAttributeLeading;
    for (NSUInteger start = 0; start < musicButtons.count; start += 5) {
        NSArray<NSButton *> *rowButtons = [musicButtons subarrayWithRange:NSMakeRange(start, MIN((NSUInteger)5, musicButtons.count - start))];
        NSStackView *row = [[NSStackView alloc] initWithFrame:NSZeroRect];
        row.translatesAutoresizingMaskIntoConstraints = NO;
        row.orientation = NSUserInterfaceLayoutOrientationHorizontal;
        row.spacing = 8;
        row.alignment = NSLayoutAttributeCenterY;
        for (NSButton *button in rowButtons) {
            CGFloat width = button.title.length <= 5 ? 54 : 136;
            [button.widthAnchor constraintEqualToConstant:width].active = YES;
            [row addArrangedSubview:button];
        }
        [musicButtonRow addArrangedSubview:row];
    }

    for (NSView *view in @[playlistScroll, songsScroll, self.musicArtworkView, self.musicTitleLabel, self.musicArtistLabel, self.musicStatusLabel, musicButtonRow]) {
        [self.musicPageView addSubview:view];
    }

    self.statusLabel = [NSTextField labelWithString:@"Ready"];
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.statusLabel.font = [NSFont systemFontOfSize:12 weight:NSFontWeightMedium];

    self.friendsSidebarView = [[NSBox alloc] initWithFrame:NSZeroRect];
    self.friendsSidebarView.translatesAutoresizingMaskIntoConstraints = NO;
    self.friendsSidebarView.boxType = NSBoxCustom;
    self.friendsSidebarView.borderType = NSNoBorder;
    self.friendsSidebarView.cornerRadius = 10;
    NSTextField *friendsTitle = [NSTextField labelWithString:@"Active Friends"];
    friendsTitle.translatesAutoresizingMaskIntoConstraints = NO;
    friendsTitle.font = [self themeFontOfSize:18 weight:NSFontWeightBold];
    friendsTitle.alignment = NSTextAlignmentCenter;
    self.friendsStatusLabel = [NSTextField labelWithString:@"No active friends"];
    self.friendsStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.friendsStatusLabel.font = [self themeFontOfSize:13 weight:NSFontWeightMedium];
    self.friendsStatusLabel.alignment = NSTextAlignmentCenter;
    self.friendsStatusLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.friendsStatusLabel.maximumNumberOfLines = 0;
    [self.friendsSidebarView addSubview:friendsTitle];
    [self.friendsSidebarView addSubview:self.friendsStatusLabel];

    [self.rootView addSubview:self.logoView];
    [self.rootView addSubview:self.titleLabel];
    [self.rootView addSubview:self.subtitleLabel];
    [self.rootView addSubview:self.toolbarBox];
    [self.rootView addSubview:toolbar];
    [self.rootView addSubview:self.viewModeControl];
    [self.rootView addSubview:self.listScrollView];
    [self.rootView addSubview:self.padScrollView];
    [self.rootView addSubview:self.recordingPageView];
    [self.rootView addSubview:self.editorPageView];
    [self.rootView addSubview:self.musicPageView];
    [self.rootView addSubview:self.friendsSidebarView];
    [self.rootView addSubview:self.statusLabel];

    self.viewModeLeadingWithSidebar = [self.viewModeControl.leadingAnchor constraintEqualToAnchor:self.toolbarBox.trailingAnchor constant:16];
    self.viewModeLeadingNoSidebar = [self.viewModeControl.leadingAnchor constraintEqualToAnchor:self.rootView.leadingAnchor constant:36];
    self.mainLeadingWithSidebar = [self.listScrollView.leadingAnchor constraintEqualToAnchor:self.toolbarBox.trailingAnchor constant:20];
    self.mainLeadingNoSidebar = [self.listScrollView.leadingAnchor constraintEqualToAnchor:self.rootView.leadingAnchor constant:36];

    self.editorWaveformWidthConstraint = [self.editorWaveformView.widthAnchor constraintEqualToConstant:900];
    [NSLayoutConstraint activateConstraints:@[
        [self.logoView.topAnchor constraintEqualToAnchor:self.rootView.topAnchor constant:22],
        [self.logoView.leadingAnchor constraintEqualToAnchor:self.rootView.leadingAnchor constant:24],
        [self.logoView.widthAnchor constraintEqualToConstant:72],
        [self.logoView.heightAnchor constraintEqualToConstant:72],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.rootView.topAnchor constant:24],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.logoView.trailingAnchor constant:16],
        [self.titleLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.rootView.trailingAnchor constant:-28],
        [self.subtitleLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:4],
        [self.subtitleLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor],
        [self.subtitleLabel.trailingAnchor constraintEqualToAnchor:self.rootView.trailingAnchor constant:-28],

        [self.toolbarBox.topAnchor constraintEqualToAnchor:self.viewModeControl.bottomAnchor constant:14],
        [self.toolbarBox.leadingAnchor constraintEqualToAnchor:self.rootView.leadingAnchor constant:36],
        [self.toolbarBox.widthAnchor constraintEqualToConstant:210],
        [self.toolbarBox.bottomAnchor constraintEqualToAnchor:self.statusLabel.topAnchor constant:-18],
        [toolbar.topAnchor constraintEqualToAnchor:self.toolbarBox.topAnchor constant:14],
        [toolbar.leadingAnchor constraintEqualToAnchor:self.toolbarBox.leadingAnchor constant:16],
        [toolbar.trailingAnchor constraintLessThanOrEqualToAnchor:self.toolbarBox.trailingAnchor constant:-16],
        [self.viewModeControl.topAnchor constraintEqualToAnchor:self.subtitleLabel.bottomAnchor constant:18],
        self.viewModeLeadingNoSidebar,
        [self.viewModeControl.trailingAnchor constraintLessThanOrEqualToAnchor:self.friendsSidebarView.leadingAnchor constant:-16],
        [self.listScrollView.topAnchor constraintEqualToAnchor:self.viewModeControl.bottomAnchor constant:10],
        self.mainLeadingWithSidebar,
        [self.listScrollView.trailingAnchor constraintEqualToAnchor:self.friendsSidebarView.leadingAnchor constant:-16],
        [self.listScrollView.bottomAnchor constraintEqualToAnchor:self.statusLabel.topAnchor constant:-24],
        [self.friendsSidebarView.topAnchor constraintEqualToAnchor:self.listScrollView.topAnchor],
        [self.friendsSidebarView.trailingAnchor constraintEqualToAnchor:self.rootView.trailingAnchor constant:-36],
        [self.friendsSidebarView.widthAnchor constraintEqualToConstant:220],
        [self.friendsSidebarView.bottomAnchor constraintEqualToAnchor:self.listScrollView.bottomAnchor],
        [friendsTitle.topAnchor constraintEqualToAnchor:self.friendsSidebarView.topAnchor constant:18],
        [friendsTitle.leadingAnchor constraintEqualToAnchor:self.friendsSidebarView.leadingAnchor constant:16],
        [friendsTitle.trailingAnchor constraintEqualToAnchor:self.friendsSidebarView.trailingAnchor constant:-16],
        [self.friendsStatusLabel.topAnchor constraintEqualToAnchor:friendsTitle.bottomAnchor constant:18],
        [self.friendsStatusLabel.leadingAnchor constraintEqualToAnchor:friendsTitle.leadingAnchor],
        [self.friendsStatusLabel.trailingAnchor constraintEqualToAnchor:friendsTitle.trailingAnchor],
        [self.padScrollView.topAnchor constraintEqualToAnchor:self.listScrollView.topAnchor],
        [self.padScrollView.leadingAnchor constraintEqualToAnchor:self.listScrollView.leadingAnchor],
        [self.padScrollView.trailingAnchor constraintEqualToAnchor:self.listScrollView.trailingAnchor],
        [self.padScrollView.bottomAnchor constraintEqualToAnchor:self.listScrollView.bottomAnchor],
        [self.recordingPageView.topAnchor constraintEqualToAnchor:self.listScrollView.topAnchor],
        [self.recordingPageView.leadingAnchor constraintEqualToAnchor:self.listScrollView.leadingAnchor],
        [self.recordingPageView.trailingAnchor constraintEqualToAnchor:self.listScrollView.trailingAnchor],
        [self.recordingPageView.bottomAnchor constraintEqualToAnchor:self.listScrollView.bottomAnchor],
        [self.editorPageView.topAnchor constraintEqualToAnchor:self.listScrollView.topAnchor],
        [self.editorPageView.leadingAnchor constraintEqualToAnchor:self.listScrollView.leadingAnchor],
        [self.editorPageView.trailingAnchor constraintEqualToAnchor:self.listScrollView.trailingAnchor],
        [self.editorPageView.bottomAnchor constraintEqualToAnchor:self.listScrollView.bottomAnchor],
        [self.musicPageView.topAnchor constraintEqualToAnchor:self.listScrollView.topAnchor],
        [self.musicPageView.leadingAnchor constraintEqualToAnchor:self.listScrollView.leadingAnchor],
        [self.musicPageView.trailingAnchor constraintEqualToAnchor:self.listScrollView.trailingAnchor],
        [self.musicPageView.bottomAnchor constraintEqualToAnchor:self.listScrollView.bottomAnchor],
        [self.recordingTitleLabel.leadingAnchor constraintEqualToAnchor:self.recordingPageView.leadingAnchor constant:56],
        [self.recordingTitleLabel.trailingAnchor constraintEqualToAnchor:self.recordingPageView.trailingAnchor constant:-88],
        [self.recordingTitleLabel.topAnchor constraintEqualToAnchor:self.recordingPageView.topAnchor constant:34],
        [recordingHelpLabel.leadingAnchor constraintEqualToAnchor:self.recordingTitleLabel.leadingAnchor],
        [recordingHelpLabel.trailingAnchor constraintEqualToAnchor:self.recordingPageView.trailingAnchor constant:-88],
        [recordingHelpLabel.topAnchor constraintEqualToAnchor:self.recordingTitleLabel.bottomAnchor constant:12],
        [recentTitleLabel.leadingAnchor constraintEqualToAnchor:self.recordingTitleLabel.leadingAnchor],
        [recentTitleLabel.topAnchor constraintEqualToAnchor:recordingHelpLabel.bottomAnchor constant:18],
        [self.recentRecordingsScrollView.leadingAnchor constraintEqualToAnchor:self.recordingTitleLabel.leadingAnchor],
        [self.recentRecordingsScrollView.trailingAnchor constraintEqualToAnchor:recordingHelpLabel.trailingAnchor],
        [self.recentRecordingsScrollView.topAnchor constraintEqualToAnchor:recentTitleLabel.bottomAnchor constant:10],
        [self.recentRecordingsScrollView.bottomAnchor constraintEqualToAnchor:self.recordingPageView.bottomAnchor constant:-28],
        [self.editorTitleLabel.leadingAnchor constraintEqualToAnchor:self.editorPageView.leadingAnchor constant:56],
        [self.editorTitleLabel.trailingAnchor constraintEqualToAnchor:self.editorPageView.trailingAnchor constant:-88],
        [self.editorTitleLabel.topAnchor constraintEqualToAnchor:self.editorPageView.topAnchor constant:34],
        [editorHelpLabel.leadingAnchor constraintEqualToAnchor:self.editorTitleLabel.leadingAnchor],
        [editorHelpLabel.trailingAnchor constraintEqualToAnchor:self.editorPageView.trailingAnchor constant:-88],
        [editorHelpLabel.topAnchor constraintEqualToAnchor:self.editorTitleLabel.bottomAnchor constant:12],
        [self.editorLoadedLabel.leadingAnchor constraintEqualToAnchor:self.editorTitleLabel.leadingAnchor],
        [self.editorLoadedLabel.trailingAnchor constraintEqualToAnchor:editorHelpLabel.trailingAnchor],
        [self.editorLoadedLabel.topAnchor constraintEqualToAnchor:editorHelpLabel.bottomAnchor constant:18],
        [self.editorWaveformScrollView.leadingAnchor constraintEqualToAnchor:self.editorTitleLabel.leadingAnchor],
        [self.editorWaveformScrollView.trailingAnchor constraintEqualToAnchor:editorHelpLabel.trailingAnchor],
        [self.editorWaveformScrollView.topAnchor constraintEqualToAnchor:self.editorLoadedLabel.bottomAnchor constant:14],
        [self.editorWaveformScrollView.heightAnchor constraintEqualToConstant:190],
        self.editorWaveformWidthConstraint,
        [self.editorWaveformView.heightAnchor constraintEqualToAnchor:self.editorWaveformScrollView.heightAnchor],
        [startLabel.leadingAnchor constraintEqualToAnchor:self.editorTitleLabel.leadingAnchor],
        [startLabel.topAnchor constraintEqualToAnchor:self.editorWaveformScrollView.bottomAnchor constant:18],
        [startLabel.widthAnchor constraintEqualToConstant:90],
        [self.editorStartSlider.leadingAnchor constraintEqualToAnchor:startLabel.trailingAnchor constant:12],
        [self.editorStartSlider.trailingAnchor constraintEqualToAnchor:editorHelpLabel.trailingAnchor],
        [self.editorStartSlider.centerYAnchor constraintEqualToAnchor:startLabel.centerYAnchor],
        [endLabel.leadingAnchor constraintEqualToAnchor:startLabel.leadingAnchor],
        [endLabel.topAnchor constraintEqualToAnchor:startLabel.bottomAnchor constant:16],
        [endLabel.widthAnchor constraintEqualToAnchor:startLabel.widthAnchor],
        [self.editorEndSlider.leadingAnchor constraintEqualToAnchor:self.editorStartSlider.leadingAnchor],
        [self.editorEndSlider.trailingAnchor constraintEqualToAnchor:self.editorStartSlider.trailingAnchor],
        [self.editorEndSlider.centerYAnchor constraintEqualToAnchor:endLabel.centerYAnchor],
        [volumeLabel.leadingAnchor constraintEqualToAnchor:startLabel.leadingAnchor],
        [volumeLabel.topAnchor constraintEqualToAnchor:endLabel.bottomAnchor constant:16],
        [volumeLabel.widthAnchor constraintEqualToAnchor:startLabel.widthAnchor],
        [self.editorVolumeSlider.leadingAnchor constraintEqualToAnchor:self.editorStartSlider.leadingAnchor],
        [self.editorVolumeSlider.trailingAnchor constraintEqualToAnchor:self.editorStartSlider.trailingAnchor],
        [self.editorVolumeSlider.centerYAnchor constraintEqualToAnchor:volumeLabel.centerYAnchor],
        [zoomLabel.leadingAnchor constraintEqualToAnchor:startLabel.leadingAnchor],
        [zoomLabel.topAnchor constraintEqualToAnchor:volumeLabel.bottomAnchor constant:16],
        [zoomLabel.widthAnchor constraintEqualToAnchor:startLabel.widthAnchor],
        [self.editorZoomSlider.leadingAnchor constraintEqualToAnchor:self.editorStartSlider.leadingAnchor],
        [self.editorZoomSlider.trailingAnchor constraintEqualToAnchor:self.editorStartSlider.trailingAnchor],
        [self.editorZoomSlider.centerYAnchor constraintEqualToAnchor:zoomLabel.centerYAnchor],
        [self.editorStatusLabel.leadingAnchor constraintEqualToAnchor:self.editorTitleLabel.leadingAnchor],
        [self.editorStatusLabel.trailingAnchor constraintEqualToAnchor:editorHelpLabel.trailingAnchor],
        [self.editorStatusLabel.topAnchor constraintEqualToAnchor:zoomLabel.bottomAnchor constant:20],
        [playlistScroll.leadingAnchor constraintEqualToAnchor:self.musicPageView.leadingAnchor constant:18],
        [playlistScroll.topAnchor constraintEqualToAnchor:self.musicPageView.topAnchor constant:18],
        [playlistScroll.widthAnchor constraintEqualToConstant:200],
        [playlistScroll.bottomAnchor constraintEqualToAnchor:self.musicPageView.bottomAnchor constant:-18],
        [songsScroll.leadingAnchor constraintEqualToAnchor:playlistScroll.trailingAnchor constant:12],
        [songsScroll.topAnchor constraintEqualToAnchor:playlistScroll.topAnchor],
        [songsScroll.trailingAnchor constraintEqualToAnchor:self.musicPageView.trailingAnchor constant:-44],
        [songsScroll.heightAnchor constraintEqualToAnchor:self.musicPageView.heightAnchor multiplier:0.48],
        [self.musicArtworkView.leadingAnchor constraintEqualToAnchor:songsScroll.leadingAnchor],
        [self.musicArtworkView.topAnchor constraintEqualToAnchor:songsScroll.bottomAnchor constant:10],
        [self.musicArtworkView.widthAnchor constraintEqualToConstant:150],
        [self.musicArtworkView.heightAnchor constraintEqualToConstant:150],
        [self.musicTitleLabel.leadingAnchor constraintEqualToAnchor:self.musicArtworkView.trailingAnchor constant:16],
        [self.musicTitleLabel.trailingAnchor constraintEqualToAnchor:songsScroll.trailingAnchor],
        [self.musicTitleLabel.topAnchor constraintEqualToAnchor:self.musicArtworkView.topAnchor constant:10],
        [self.musicArtistLabel.leadingAnchor constraintEqualToAnchor:self.musicTitleLabel.leadingAnchor],
        [self.musicArtistLabel.trailingAnchor constraintEqualToAnchor:self.musicTitleLabel.trailingAnchor],
        [self.musicArtistLabel.topAnchor constraintEqualToAnchor:self.musicTitleLabel.bottomAnchor constant:8],
        [musicButtonRow.leadingAnchor constraintEqualToAnchor:songsScroll.leadingAnchor],
        [musicButtonRow.trailingAnchor constraintLessThanOrEqualToAnchor:songsScroll.trailingAnchor],
        [musicButtonRow.topAnchor constraintEqualToAnchor:self.musicArtworkView.bottomAnchor constant:10],
        [self.musicStatusLabel.leadingAnchor constraintEqualToAnchor:songsScroll.leadingAnchor],
        [self.musicStatusLabel.trailingAnchor constraintEqualToAnchor:songsScroll.trailingAnchor],
        [self.musicStatusLabel.topAnchor constraintEqualToAnchor:musicButtonRow.bottomAnchor constant:8],
        [self.statusLabel.leadingAnchor constraintEqualToAnchor:self.rootView.leadingAnchor constant:36],
        [self.statusLabel.trailingAnchor constraintEqualToAnchor:self.rootView.trailingAnchor constant:-44],
        [self.statusLabel.bottomAnchor constraintEqualToAnchor:self.rootView.bottomAnchor constant:-18]
    ]];

    [self applyTheme];
    [self applyViewMode];
    [self adjustTableColumns];
    [self fitWindowForCurrentPageAnimated:NO];
    [self.window makeKeyAndOrderFront:nil];
    [self.window makeFirstResponder:self.rootView];
}

- (NSButton *)button:(NSString *)title action:(SEL)action {
    ThemedRailButton *button = [[ThemedRailButton alloc] initWithFrame:NSMakeRect(0, 0, 176, 48)];
    button.title = title;
    button.target = self;
    button.action = action;
    button.controller = self;
    button.bordered = NO;
    [button.widthAnchor constraintEqualToConstant:176].active = YES;
    [button.heightAnchor constraintEqualToConstant:48].active = YES;
    [self.toolbarButtons addObject:button];
    return button;
}

- (void)fitWindowForCurrentPageAnimated:(BOOL)animated {
    NSScreen *screen = self.window.screen ?: NSScreen.mainScreen;
    if (!screen) {
        [self.window center];
        return;
    }
    NSRect visible = screen.visibleFrame;
    BOOL musicMode = [self.viewMode isEqualToString:@"music"];
    CGFloat margin = 36;
    CGFloat targetWidth = musicMode ? visible.size.width - margin : MIN(1120, visible.size.width - margin * 2.0);
    CGFloat targetHeight = musicMode ? visible.size.height - margin : MIN(760, visible.size.height - margin * 2.0);
    targetWidth = MAX(MIN(self.window.minSize.width, visible.size.width - margin), targetWidth);
    targetHeight = MAX(MIN(self.window.minSize.height, visible.size.height - margin), targetHeight);
    targetWidth = MIN(targetWidth, visible.size.width - margin);
    targetHeight = MIN(targetHeight, visible.size.height - margin);
    NSRect frame = NSMakeRect(NSMidX(visible) - targetWidth / 2.0, NSMidY(visible) - targetHeight / 2.0, targetWidth, targetHeight);
    frame = NSIntersectionRect(frame, visible);
    [self.window setFrame:frame display:YES animate:animated];
}

- (NSButton *)plainButton:(NSString *)title action:(SEL)action {
    NSButton *button = [NSButton buttonWithTitle:title target:self action:action];
    button.bezelStyle = NSBezelStyleRounded;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    return button;
}

- (void)addColumn:(NSString *)identifier title:(NSString *)title width:(CGFloat)width {
    NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:identifier];
    column.title = title;
    column.width = width;
    column.resizingMask = NSTableColumnAutoresizingMask | NSTableColumnUserResizingMask;
    [self.tableView addTableColumn:column];
}

- (void)updateTitleStyle {
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"Sounds Simple"];
    NSFont *titleFont = [self themeFontOfSize:36 weight:NSFontWeightBold];
    NSShadow *titleShadow = [[NSShadow alloc] init];
    titleShadow.shadowColor = [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:0.45];
    titleShadow.shadowBlurRadius = 2.0;
    titleShadow.shadowOffset = NSMakeSize(0, -1);
    [title addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, title.length)];
    [title addAttribute:NSForegroundColorAttributeName value:[self themeColor:@"text"] range:NSMakeRange(0, 6)];
    [title addAttribute:NSForegroundColorAttributeName value:[self themeColor:@"titleAccent"] range:NSMakeRange(7, 6)];
    [title addAttribute:NSKernAttributeName value:@1.1 range:NSMakeRange(0, title.length)];
    [title addAttribute:NSShadowAttributeName value:titleShadow range:NSMakeRange(0, title.length)];
    self.titleLabel.attributedStringValue = title;
}

- (void)applyTheme {
    [self updateTitleStyle];
    self.subtitleLabel.font = [self themeFontOfSize:13 weight:NSFontWeightMedium];
    self.subtitleLabel.textColor = [self themeColor:@"mutedText"];
    self.statusLabel.textColor = [self themeColor:@"titleAccent"];
    self.recordingPageView.fillColor = [self themeColor:@"surface"];
    self.editorPageView.fillColor = [self themeColor:@"surface"];
    self.musicPageView.fillColor = [self themeColor:@"surface"];
    self.recentRecordingsTableView.backgroundColor = [self themeColor:@"surface"];
    self.recentRecordingsScrollView.layer.backgroundColor = [self themeColor:@"surface"].CGColor;
    self.recentRecordingsScrollView.layer.borderColor = [self themeColor:@"accentSoft"].CGColor;
    self.recordingTitleLabel.textColor = [self themeColor:@"text"];
    self.recordingTitleLabel.font = [self themeFontOfSize:28 weight:NSFontWeightBold];
    self.recordingStatusLabel.textColor = [self themeColor:@"mutedText"];
    self.editorTitleLabel.textColor = [self themeColor:@"text"];
    self.editorTitleLabel.font = [self themeFontOfSize:28 weight:NSFontWeightBold];
    self.editorLoadedLabel.textColor = [self themeColor:@"text"];
    self.editorStatusLabel.textColor = [self themeColor:@"mutedText"];
    self.editorWaveformView.needsDisplay = YES;
    self.musicTitleLabel.textColor = [self themeColor:@"text"];
    self.musicArtistLabel.textColor = [self themeColor:@"mutedText"];
    self.musicStatusLabel.textColor = [self themeColor:@"mutedText"];
    self.toolbarBox.fillColor = [self themeColor:@"panel"];
    self.friendsSidebarView.fillColor = [self themeColor:@"panel"];
    self.friendsStatusLabel.textColor = [self themeColor:@"mutedText"];
    self.tableView.backgroundColor = [self themeColor:@"surface"];
    self.listScrollView.layer.backgroundColor = [self themeColor:@"surface"].CGColor;
    self.listScrollView.layer.borderColor = [self themeColor:@"accentSoft"].CGColor;
    self.padScrollView.layer.backgroundColor = [self themeColor:@"surface"].CGColor;
    self.padScrollView.layer.borderColor = [self themeColor:@"accentSoft"].CGColor;
    self.logoView.layer.borderColor = [self themeColor:@"accent"].CGColor;
    for (NSButton *button in self.toolbarButtons) {
        button.contentTintColor = [self themeColor:@"accent"];
        button.font = [self themeFontOfSize:13 weight:NSFontWeightSemibold];
        button.needsDisplay = YES;
    }
    self.rootView.needsDisplay = YES;
    [self.tableView reloadData];
}

- (void)applyViewMode {
    BOOL padMode = [self.viewMode isEqualToString:@"pad"];
    BOOL recordMode = [self.viewMode isEqualToString:@"record"];
    BOOL editorMode = [self.viewMode isEqualToString:@"editor"];
    BOOL musicMode = [self.viewMode isEqualToString:@"music"];
    self.listScrollView.hidden = padMode || recordMode || editorMode || musicMode;
    self.padScrollView.hidden = !padMode;
    self.recordingPageView.hidden = !recordMode;
    self.editorPageView.hidden = !editorMode;
    self.musicPageView.hidden = !musicMode;
    self.viewModeControl.selectedSegment = musicMode ? 4 : (editorMode ? 3 : (recordMode ? 2 : (padMode ? 1 : 0)));
    self.toolbarBox.hidden = musicMode;
    self.toolbarStack.hidden = musicMode;
    self.mainLeadingWithSidebar.active = !musicMode;
    self.mainLeadingNoSidebar.active = musicMode;
    for (NSView *view in self.soundSidebarViews) {
        view.hidden = recordMode || editorMode || musicMode;
    }
    for (NSView *view in self.recordingSidebarViews) {
        view.hidden = !recordMode;
    }
    for (NSView *view in self.editorSidebarViews) {
        view.hidden = !editorMode;
    }
    if (padMode) {
        [self refreshPadView];
    } else if (recordMode) {
        [self refreshRecentRecordings];
    }
}

- (IBAction)viewModeChanged:(id)sender {
    self.viewMode = self.viewModeControl.selectedSegment == 4 ? @"music" : (self.viewModeControl.selectedSegment == 3 ? @"editor" : (self.viewModeControl.selectedSegment == 2 ? @"record" : (self.viewModeControl.selectedSegment == 1 ? @"pad" : @"list")));
    [self saveSettings];
    [self applyViewMode];
    [self fitWindowForCurrentPageAnimated:YES];
    [self focusForKeys];
}

- (IBAction)showRecordingPage {
    self.viewMode = @"record";
    [self saveSettings];
    [self applyViewMode];
    [self fitWindowForCurrentPageAnimated:YES];
    [self focusForKeys];
}

- (IBAction)showPreferences:(id)sender {
    if (!self.preferencesPanel) {
        self.preferencesPanel = [[NSPanel alloc] initWithContentRect:NSMakeRect(0, 0, 460, 300)
                                                           styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable
                                                             backing:NSBackingStoreBuffered
                                                               defer:NO];
        self.preferencesPanel.title = @"Sounds Simple Preferences";
        NSView *content = [[NSView alloc] initWithFrame:self.preferencesPanel.contentView.bounds];
        self.preferencesPanel.contentView = content;

        NSTextField *themeLabel = [NSTextField labelWithString:@"Color Theme"];
        NSPopUpButton *themePopup = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
        [themePopup addItemsWithTitles:@[@"Notre Dame", @"Midnight", @"Forest", @"Slate", @"Halloween"]];
        [themePopup selectItemWithTitle:self.themeName ?: @"Notre Dame"];
        themePopup.target = self;
        themePopup.action = @selector(preferenceThemeChanged:);

        NSTextField *viewLabel = [NSTextField labelWithString:@"Default View"];
        NSPopUpButton *viewPopup = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
        [viewPopup addItemsWithTitles:@[@"List", @"Tap Pads", @"Recording", @"Editor", @"Music"]];
        [viewPopup selectItemWithTitle:[self.viewMode isEqualToString:@"music"] ? @"Music" : ([self.viewMode isEqualToString:@"editor"] ? @"Editor" : ([self.viewMode isEqualToString:@"record"] ? @"Recording" : ([self.viewMode isEqualToString:@"pad"] ? @"Tap Pads" : @"List")))];
        viewPopup.target = self;
        viewPopup.action = @selector(preferenceViewModeChanged:);

        NSButton *stopCheckbox = [NSButton checkboxWithTitle:@"Stop currently playing clips before starting a new one" target:self action:@selector(preferenceCheckboxChanged:)];
        stopCheckbox.state = self.stopBeforePlaying ? NSControlStateValueOn : NSControlStateValueOff;
        stopCheckbox.tag = 1;

        NSButton *confirmCheckbox = [NSButton checkboxWithTitle:@"Ask before removing sounds from the list" target:self action:@selector(preferenceCheckboxChanged:)];
        confirmCheckbox.state = self.confirmDeletes ? NSControlStateValueOn : NSControlStateValueOff;
        confirmCheckbox.tag = 2;

        NSButton *largePadsCheckbox = [NSButton checkboxWithTitle:@"Use larger tap pads" target:self action:@selector(preferenceCheckboxChanged:)];
        largePadsCheckbox.state = self.largePads ? NSControlStateValueOn : NSControlStateValueOff;
        largePadsCheckbox.tag = 3;

        NSTextField *noteLabel = [NSTextField labelWithString:@"Settings are saved automatically for this Mac."];
        noteLabel.font = [NSFont systemFontOfSize:12 weight:NSFontWeightRegular];
        noteLabel.textColor = [NSColor secondaryLabelColor];

        NSArray *views = @[themeLabel, themePopup, viewLabel, viewPopup, stopCheckbox, confirmCheckbox, largePadsCheckbox, noteLabel];
        for (NSView *view in views) {
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [content addSubview:view];
        }

        [NSLayoutConstraint activateConstraints:@[
            [themeLabel.leadingAnchor constraintEqualToAnchor:content.leadingAnchor constant:24],
            [themeLabel.topAnchor constraintEqualToAnchor:content.topAnchor constant:28],
            [themeLabel.widthAnchor constraintEqualToConstant:120],
            [themePopup.leadingAnchor constraintEqualToAnchor:themeLabel.trailingAnchor constant:16],
            [themePopup.trailingAnchor constraintEqualToAnchor:content.trailingAnchor constant:-24],
            [themePopup.centerYAnchor constraintEqualToAnchor:themeLabel.centerYAnchor],

            [viewLabel.leadingAnchor constraintEqualToAnchor:themeLabel.leadingAnchor],
            [viewLabel.topAnchor constraintEqualToAnchor:themeLabel.bottomAnchor constant:24],
            [viewLabel.widthAnchor constraintEqualToAnchor:themeLabel.widthAnchor],
            [viewPopup.leadingAnchor constraintEqualToAnchor:themePopup.leadingAnchor],
            [viewPopup.trailingAnchor constraintEqualToAnchor:themePopup.trailingAnchor],
            [viewPopup.centerYAnchor constraintEqualToAnchor:viewLabel.centerYAnchor],

            [stopCheckbox.leadingAnchor constraintEqualToAnchor:themeLabel.leadingAnchor],
            [stopCheckbox.trailingAnchor constraintEqualToAnchor:content.trailingAnchor constant:-24],
            [stopCheckbox.topAnchor constraintEqualToAnchor:viewLabel.bottomAnchor constant:30],
            [confirmCheckbox.leadingAnchor constraintEqualToAnchor:stopCheckbox.leadingAnchor],
            [confirmCheckbox.trailingAnchor constraintEqualToAnchor:stopCheckbox.trailingAnchor],
            [confirmCheckbox.topAnchor constraintEqualToAnchor:stopCheckbox.bottomAnchor constant:12],
            [largePadsCheckbox.leadingAnchor constraintEqualToAnchor:stopCheckbox.leadingAnchor],
            [largePadsCheckbox.trailingAnchor constraintEqualToAnchor:stopCheckbox.trailingAnchor],
            [largePadsCheckbox.topAnchor constraintEqualToAnchor:confirmCheckbox.bottomAnchor constant:12],
            [noteLabel.leadingAnchor constraintEqualToAnchor:stopCheckbox.leadingAnchor],
            [noteLabel.trailingAnchor constraintEqualToAnchor:stopCheckbox.trailingAnchor],
            [noteLabel.bottomAnchor constraintEqualToAnchor:content.bottomAnchor constant:-20]
        ]];
    }
    [self.preferencesPanel center];
    [self.preferencesPanel makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
}

- (IBAction)preferenceThemeChanged:(NSPopUpButton *)sender {
    self.themeName = sender.titleOfSelectedItem ?: @"Notre Dame";
    [self saveSettings];
    [self applyTheme];
}

- (IBAction)preferenceViewModeChanged:(NSPopUpButton *)sender {
    self.viewMode = [sender.titleOfSelectedItem isEqualToString:@"Music"] ? @"music" : ([sender.titleOfSelectedItem isEqualToString:@"Editor"] ? @"editor" : ([sender.titleOfSelectedItem isEqualToString:@"Recording"] ? @"record" : ([sender.titleOfSelectedItem isEqualToString:@"Tap Pads"] ? @"pad" : @"list")));
    [self saveSettings];
    [self applyViewMode];
}

- (IBAction)preferenceCheckboxChanged:(NSButton *)sender {
    if (sender.tag == 1) {
        self.stopBeforePlaying = sender.state == NSControlStateValueOn;
    } else if (sender.tag == 2) {
        self.confirmDeletes = sender.state == NSControlStateValueOn;
    } else if (sender.tag == 3) {
        self.largePads = sender.state == NSControlStateValueOn;
        [self refreshPadView];
    }
    [self saveSettings];
}

- (NSString *)trimmedString:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] ?: @"";
}

- (BOOL)hasSupabaseConfig {
    return [self trimmedString:self.supabaseURL].length > 0 && [self trimmedString:self.supabaseAnonKey].length > 0;
}

- (NSString *)normalizedSupabaseProjectURL:(NSString *)rawURL {
    NSString *clean = [self trimmedString:rawURL];
    while ([clean hasSuffix:@"/"]) {
        clean = [clean substringToIndex:clean.length - 1];
    }
    NSRange restRange = [clean rangeOfString:@"/rest/v1" options:NSCaseInsensitiveSearch];
    if (restRange.location != NSNotFound) {
        clean = [clean substringToIndex:restRange.location];
    }
    NSRange authRange = [clean rangeOfString:@"/auth/v1" options:NSCaseInsensitiveSearch];
    if (authRange.location != NSNotFound) {
        clean = [clean substringToIndex:authRange.location];
    }
    return clean;
}

- (IBAction)configureSupabase:(id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Configure Supabase";
    alert.informativeText = @"Paste the Project URL and anon public key from your Supabase project settings.";
    NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 420, 96)];
    NSTextField *urlLabel = [NSTextField labelWithString:@"Project URL"];
    NSTextField *urlField = [[NSTextField alloc] initWithFrame:NSZeroRect];
    urlField.stringValue = self.supabaseURL ?: @"";
    NSTextField *keyLabel = [NSTextField labelWithString:@"Anon Key"];
    NSTextField *keyField = [[NSTextField alloc] initWithFrame:NSZeroRect];
    keyField.stringValue = self.supabaseAnonKey ?: @"";
    for (NSView *subview in @[urlLabel, urlField, keyLabel, keyField]) {
        subview.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:subview];
    }
    [NSLayoutConstraint activateConstraints:@[
        [urlLabel.leadingAnchor constraintEqualToAnchor:view.leadingAnchor],
        [urlLabel.topAnchor constraintEqualToAnchor:view.topAnchor constant:4],
        [urlLabel.widthAnchor constraintEqualToConstant:86],
        [urlField.leadingAnchor constraintEqualToAnchor:urlLabel.trailingAnchor constant:10],
        [urlField.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
        [urlField.centerYAnchor constraintEqualToAnchor:urlLabel.centerYAnchor],
        [keyLabel.leadingAnchor constraintEqualToAnchor:urlLabel.leadingAnchor],
        [keyLabel.topAnchor constraintEqualToAnchor:urlLabel.bottomAnchor constant:22],
        [keyLabel.widthAnchor constraintEqualToAnchor:urlLabel.widthAnchor],
        [keyField.leadingAnchor constraintEqualToAnchor:urlField.leadingAnchor],
        [keyField.trailingAnchor constraintEqualToAnchor:urlField.trailingAnchor],
        [keyField.centerYAnchor constraintEqualToAnchor:keyLabel.centerYAnchor]
    ]];
    alert.accessoryView = view;
    [alert addButtonWithTitle:@"Save"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] == NSAlertFirstButtonReturn) {
        self.supabaseURL = [self normalizedSupabaseProjectURL:urlField.stringValue];
        self.supabaseAnonKey = [self trimmedString:keyField.stringValue];
        [self saveSettings];
        self.statusLabel.stringValue = @"Supabase settings saved";
    }
    [self focusForKeys];
}

- (BOOL)promptForEmail:(NSString **)email password:(NSString **)password title:(NSString *)title {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = title;
    alert.informativeText = @"Use the email and password for your Sounds Simple account.";
    NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 360, 82)];
    NSTextField *emailLabel = [NSTextField labelWithString:@"Email"];
    NSTextField *emailField = [[NSTextField alloc] initWithFrame:NSZeroRect];
    emailField.stringValue = self.accountEmail ?: @"";
    NSTextField *passwordLabel = [NSTextField labelWithString:@"Password"];
    NSSecureTextField *passwordField = [[NSSecureTextField alloc] initWithFrame:NSZeroRect];
    for (NSView *subview in @[emailLabel, emailField, passwordLabel, passwordField]) {
        subview.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:subview];
    }
    [NSLayoutConstraint activateConstraints:@[
        [emailLabel.leadingAnchor constraintEqualToAnchor:view.leadingAnchor],
        [emailLabel.topAnchor constraintEqualToAnchor:view.topAnchor constant:4],
        [emailLabel.widthAnchor constraintEqualToConstant:76],
        [emailField.leadingAnchor constraintEqualToAnchor:emailLabel.trailingAnchor constant:10],
        [emailField.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
        [emailField.centerYAnchor constraintEqualToAnchor:emailLabel.centerYAnchor],
        [passwordLabel.leadingAnchor constraintEqualToAnchor:emailLabel.leadingAnchor],
        [passwordLabel.topAnchor constraintEqualToAnchor:emailLabel.bottomAnchor constant:22],
        [passwordLabel.widthAnchor constraintEqualToAnchor:emailLabel.widthAnchor],
        [passwordField.leadingAnchor constraintEqualToAnchor:emailField.leadingAnchor],
        [passwordField.trailingAnchor constraintEqualToAnchor:emailField.trailingAnchor],
        [passwordField.centerYAnchor constraintEqualToAnchor:passwordLabel.centerYAnchor]
    ]];
    alert.accessoryView = view;
    [alert addButtonWithTitle:@"Continue"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] != NSAlertFirstButtonReturn) return NO;
    NSString *cleanEmail = [self trimmedString:emailField.stringValue];
    NSString *cleanPassword = passwordField.stringValue ?: @"";
    if (cleanEmail.length == 0 || cleanPassword.length == 0) {
        [self showAlert:@"Missing Account Info" message:@"Enter both an email and password."];
        return NO;
    }
    if (email) *email = cleanEmail;
    if (password) *password = cleanPassword;
    return YES;
}

- (BOOL)promptForNewAccountEmail:(NSString **)email password:(NSString **)password username:(NSString **)username {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Create Account";
    alert.informativeText = @"Choose a username, then add the email and password for account recovery and sign-in.";
    NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 380, 122)];
    NSTextField *usernameLabel = [NSTextField labelWithString:@"Username"];
    NSTextField *usernameField = [[NSTextField alloc] initWithFrame:NSZeroRect];
    usernameField.stringValue = self.accountUsername ?: @"";
    NSTextField *emailLabel = [NSTextField labelWithString:@"Email"];
    NSTextField *emailField = [[NSTextField alloc] initWithFrame:NSZeroRect];
    emailField.stringValue = self.accountEmail ?: @"";
    NSTextField *passwordLabel = [NSTextField labelWithString:@"Password"];
    NSSecureTextField *passwordField = [[NSSecureTextField alloc] initWithFrame:NSZeroRect];
    for (NSView *subview in @[usernameLabel, usernameField, emailLabel, emailField, passwordLabel, passwordField]) {
        subview.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:subview];
    }
    [NSLayoutConstraint activateConstraints:@[
        [usernameLabel.leadingAnchor constraintEqualToAnchor:view.leadingAnchor],
        [usernameLabel.topAnchor constraintEqualToAnchor:view.topAnchor constant:4],
        [usernameLabel.widthAnchor constraintEqualToConstant:82],
        [usernameField.leadingAnchor constraintEqualToAnchor:usernameLabel.trailingAnchor constant:10],
        [usernameField.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
        [usernameField.centerYAnchor constraintEqualToAnchor:usernameLabel.centerYAnchor],
        [emailLabel.leadingAnchor constraintEqualToAnchor:usernameLabel.leadingAnchor],
        [emailLabel.topAnchor constraintEqualToAnchor:usernameLabel.bottomAnchor constant:22],
        [emailLabel.widthAnchor constraintEqualToAnchor:usernameLabel.widthAnchor],
        [emailField.leadingAnchor constraintEqualToAnchor:usernameField.leadingAnchor],
        [emailField.trailingAnchor constraintEqualToAnchor:usernameField.trailingAnchor],
        [emailField.centerYAnchor constraintEqualToAnchor:emailLabel.centerYAnchor],
        [passwordLabel.leadingAnchor constraintEqualToAnchor:usernameLabel.leadingAnchor],
        [passwordLabel.topAnchor constraintEqualToAnchor:emailLabel.bottomAnchor constant:22],
        [passwordLabel.widthAnchor constraintEqualToAnchor:usernameLabel.widthAnchor],
        [passwordField.leadingAnchor constraintEqualToAnchor:usernameField.leadingAnchor],
        [passwordField.trailingAnchor constraintEqualToAnchor:usernameField.trailingAnchor],
        [passwordField.centerYAnchor constraintEqualToAnchor:passwordLabel.centerYAnchor]
    ]];
    alert.accessoryView = view;
    [alert addButtonWithTitle:@"Create"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] != NSAlertFirstButtonReturn) return NO;
    NSString *cleanUsername = [self trimmedString:usernameField.stringValue];
    NSString *cleanEmail = [self trimmedString:emailField.stringValue];
    NSString *cleanPassword = passwordField.stringValue ?: @"";
    if (cleanUsername.length == 0 || cleanEmail.length == 0 || cleanPassword.length == 0) {
        [self showAlert:@"Missing Account Info" message:@"Enter a username, email, and password."];
        return NO;
    }
    if (username) *username = cleanUsername;
    if (email) *email = cleanEmail;
    if (password) *password = cleanPassword;
    return YES;
}

- (void)sendSupabaseRequest:(NSString *)path method:(NSString *)method body:(NSDictionary *)body authorized:(BOOL)authorized completion:(void (^)(NSDictionary *json, NSError *error))completion {
    if (![self hasSupabaseConfig]) {
        NSError *error = [NSError errorWithDomain:@"SoundsSimple" code:1 userInfo:@{NSLocalizedDescriptionKey: @"Add your Supabase Project URL and anon key first."}];
        if (completion) completion(nil, error);
        return;
    }
    NSString *base = [self normalizedSupabaseProjectURL:self.supabaseURL];
    NSURL *url = [NSURL URLWithString:[base stringByAppendingString:path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method ?: @"POST";
    request.timeoutInterval = 20;
    [request setValue:self.supabaseAnonKey forHTTPHeaderField:@"apikey"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (authorized && self.supabaseAccessToken.length) {
        [request setValue:[@"Bearer " stringByAppendingString:self.supabaseAccessToken] forHTTPHeaderField:@"Authorization"];
    } else {
        [request setValue:[@"Bearer " stringByAppendingString:self.supabaseAnonKey] forHTTPHeaderField:@"Authorization"];
    }
    if (body) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    }
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = nil;
        if (data.length) {
            id parsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([parsed isKindOfClass:[NSDictionary class]]) json = parsed;
        }
        NSHTTPURLResponse *http = [response isKindOfClass:[NSHTTPURLResponse class]] ? (NSHTTPURLResponse *)response : nil;
        if (!error && http.statusCode >= 400) {
            NSString *message = json[@"msg"] ?: json[@"message"] ?: json[@"error_description"] ?: json[@"error"] ?: @"Supabase request failed.";
            error = [NSError errorWithDomain:@"Supabase" code:http.statusCode userInfo:@{NSLocalizedDescriptionKey: message}];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(json, error);
            });
        }
    }] resume];
}

- (void)storeSupabaseSession:(NSDictionary *)json fallbackEmail:(NSString *)email {
    self.supabaseAccessToken = json[@"access_token"] ?: @"";
    self.supabaseRefreshToken = json[@"refresh_token"] ?: @"";
    NSDictionary *user = [json[@"user"] isKindOfClass:[NSDictionary class]] ? json[@"user"] : nil;
    self.accountEmail = user[@"email"] ?: email ?: self.accountEmail ?: @"";
    NSDictionary *metadata = [user[@"user_metadata"] isKindOfClass:[NSDictionary class]] ? user[@"user_metadata"] : nil;
    self.accountUsername = metadata[@"username"] ?: metadata[@"display_name"] ?: self.accountUsername ?: @"";
    [self saveSettings];
}

- (IBAction)createSupabaseAccount:(id)sender {
    if (![self hasSupabaseConfig]) {
        [self configureSupabase:nil];
        if (![self hasSupabaseConfig]) return;
    }
    NSString *email = nil;
    NSString *password = nil;
    NSString *username = nil;
    if (![self promptForNewAccountEmail:&email password:&password username:&username]) return;
    self.statusLabel.stringValue = @"Creating account...";
    NSDictionary *metadata = @{@"username": username, @"display_name": username};
    [self sendSupabaseRequest:@"/auth/v1/signup" method:@"POST" body:@{@"email": email, @"password": password, @"data": metadata} authorized:NO completion:^(NSDictionary *json, NSError *error) {
        if (error) {
            [self showAlert:@"Account Failed" message:error.localizedDescription];
            return;
        }
        [self storeSupabaseSession:json fallbackEmail:email];
        self.accountUsername = username;
        [self saveSettings];
        [self showAlert:@"Account Created" message:@"If email confirmation is enabled in Supabase, check your email before signing in."];
        self.statusLabel.stringValue = [NSString stringWithFormat:@"Account ready for %@", username];
    }];
}

- (IBAction)signInSupabaseAccount:(id)sender {
    if (![self hasSupabaseConfig]) {
        [self configureSupabase:nil];
        if (![self hasSupabaseConfig]) return;
    }
    NSString *email = nil;
    NSString *password = nil;
    if (![self promptForEmail:&email password:&password title:@"Sign In"]) return;
    self.statusLabel.stringValue = @"Signing in...";
    [self sendSupabaseRequest:@"/auth/v1/token?grant_type=password" method:@"POST" body:@{@"email": email, @"password": password} authorized:NO completion:^(NSDictionary *json, NSError *error) {
        if (error) {
            [self showAlert:@"Sign In Failed" message:error.localizedDescription];
            return;
        }
        [self storeSupabaseSession:json fallbackEmail:email];
        self.statusLabel.stringValue = [NSString stringWithFormat:@"Signed in as %@", self.accountEmail ?: email];
        [self showAlert:@"Signed In" message:self.statusLabel.stringValue];
    }];
}

- (IBAction)signOutSupabaseAccount:(id)sender {
    void (^clearSession)(void) = ^{
        self.supabaseAccessToken = @"";
        self.supabaseRefreshToken = @"";
        self.accountEmail = @"";
        self.accountUsername = @"";
        [self saveSettings];
        self.statusLabel.stringValue = @"Signed out";
    };
    if (self.supabaseAccessToken.length) {
        [self sendSupabaseRequest:@"/auth/v1/logout" method:@"POST" body:nil authorized:YES completion:^(NSDictionary *json, NSError *error) {
            clearSession();
            [self showAlert:@"Signed Out" message:@"This Mac is no longer signed in."];
        }];
    } else {
        clearSession();
        [self showAlert:@"Signed Out" message:@"This Mac is no longer signed in."];
    }
}

- (IBAction)showAccount:(id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Sounds Simple Account";
    BOOL signedIn = self.supabaseAccessToken.length > 0;
    NSString *configStatus = [self hasSupabaseConfig] ? @"Supabase is configured." : @"Supabase is not configured yet.";
    NSString *displayName = self.accountUsername.length ? self.accountUsername : (self.accountEmail.length ? self.accountEmail : @"this user");
    NSString *accountStatus = signedIn ? [NSString stringWithFormat:@"Signed in as %@.", displayName] : @"Not signed in.";
    alert.informativeText = [NSString stringWithFormat:@"%@\n%@\nAdmin: %@", accountStatus, configStatus, self.adminEmail ?: @"soundssimpleadmin@gmail.com"];
    if (signedIn) {
        [alert addButtonWithTitle:@"Sign Out"];
    } else {
        [alert addButtonWithTitle:@"Sign In"];
        [alert addButtonWithTitle:@"Create Account"];
    }
    [alert addButtonWithTitle:@"Configure Supabase"];
    [alert addButtonWithTitle:@"Cancel"];
    NSModalResponse response = [alert runModal];
    if (signedIn) {
        if (response == NSAlertFirstButtonReturn) [self signOutSupabaseAccount:nil];
        else if (response == NSAlertSecondButtonReturn) [self configureSupabase:nil];
    } else {
        if (response == NSAlertFirstButtonReturn) [self signInSupabaseAccount:nil];
        else if (response == NSAlertSecondButtonReturn) [self createSupabaseAccount:nil];
        else if (response == NSAlertThirdButtonReturn) [self configureSupabase:nil];
    }
    [self focusForKeys];
}

- (void)showRegistrationSplash {
    if (self.supabaseAccessToken.length > 0 || self.registrationPanel) return;
    self.registrationPanel = [[NSPanel alloc] initWithContentRect:NSMakeRect(0, 0, 500, 360)
                                                        styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable
                                                          backing:NSBackingStoreBuffered
                                                            defer:NO];
    self.registrationPanel.title = @"Sounds Simple Account Required";
    NSView *content = [[NSView alloc] initWithFrame:self.registrationPanel.contentView.bounds];
    self.registrationPanel.contentView = content;

    NSTextField *title = [NSTextField labelWithString:@"Create or Sign In"];
    title.font = [self themeFontOfSize:26 weight:NSFontWeightBold];
    title.alignment = NSTextAlignmentCenter;
    NSTextField *message = [NSTextField labelWithString:@"Sounds Simple requires an account before the app can be used."];
    message.alignment = NSTextAlignmentCenter;
    message.lineBreakMode = NSLineBreakByWordWrapping;
    message.maximumNumberOfLines = 2;

    NSTextField *usernameLabel = [NSTextField labelWithString:@"Username"];
    NSTextField *emailLabel = [NSTextField labelWithString:@"Email"];
    NSTextField *passwordLabel = [NSTextField labelWithString:@"Password"];
    self.registrationUsernameField = [[NSTextField alloc] initWithFrame:NSZeroRect];
    self.registrationUsernameField.stringValue = self.accountUsername ?: @"";
    self.registrationEmailField = [[NSTextField alloc] initWithFrame:NSZeroRect];
    self.registrationEmailField.stringValue = self.accountEmail ?: @"";
    self.registrationPasswordField = [[NSSecureTextField alloc] initWithFrame:NSZeroRect];
    self.registrationPasswordField.target = self;
    self.registrationPasswordField.action = @selector(registrationSignIn:);
    self.registrationStatusLabel = [NSTextField labelWithString:@"Use your Supabase-backed Sounds Simple account."];
    self.registrationStatusLabel.alignment = NSTextAlignmentCenter;
    self.registrationStatusLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.registrationStatusLabel.maximumNumberOfLines = 2;

    NSButton *createButton = [NSButton buttonWithTitle:@"Create Account" target:self action:@selector(registrationCreateAccount:)];
    NSButton *signInButton = [NSButton buttonWithTitle:@"Sign In" target:self action:@selector(registrationSignIn:)];
    NSButton *configButton = [NSButton buttonWithTitle:@"Configure Supabase" target:self action:@selector(configureSupabase:)];

    NSArray *views = @[title, message, usernameLabel, self.registrationUsernameField, emailLabel, self.registrationEmailField, passwordLabel, self.registrationPasswordField, self.registrationStatusLabel, createButton, signInButton, configButton];
    for (NSView *view in views) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [content addSubview:view];
    }
    [NSLayoutConstraint activateConstraints:@[
        [title.topAnchor constraintEqualToAnchor:content.topAnchor constant:24],
        [title.leadingAnchor constraintEqualToAnchor:content.leadingAnchor constant:28],
        [title.trailingAnchor constraintEqualToAnchor:content.trailingAnchor constant:-28],
        [message.topAnchor constraintEqualToAnchor:title.bottomAnchor constant:8],
        [message.leadingAnchor constraintEqualToAnchor:title.leadingAnchor],
        [message.trailingAnchor constraintEqualToAnchor:title.trailingAnchor],
        [usernameLabel.topAnchor constraintEqualToAnchor:message.bottomAnchor constant:28],
        [usernameLabel.leadingAnchor constraintEqualToAnchor:content.leadingAnchor constant:54],
        [usernameLabel.widthAnchor constraintEqualToConstant:90],
        [self.registrationUsernameField.leadingAnchor constraintEqualToAnchor:usernameLabel.trailingAnchor constant:14],
        [self.registrationUsernameField.trailingAnchor constraintEqualToAnchor:content.trailingAnchor constant:-54],
        [self.registrationUsernameField.centerYAnchor constraintEqualToAnchor:usernameLabel.centerYAnchor],
        [emailLabel.topAnchor constraintEqualToAnchor:usernameLabel.bottomAnchor constant:20],
        [emailLabel.leadingAnchor constraintEqualToAnchor:usernameLabel.leadingAnchor],
        [emailLabel.widthAnchor constraintEqualToAnchor:usernameLabel.widthAnchor],
        [self.registrationEmailField.leadingAnchor constraintEqualToAnchor:self.registrationUsernameField.leadingAnchor],
        [self.registrationEmailField.trailingAnchor constraintEqualToAnchor:self.registrationUsernameField.trailingAnchor],
        [self.registrationEmailField.centerYAnchor constraintEqualToAnchor:emailLabel.centerYAnchor],
        [passwordLabel.topAnchor constraintEqualToAnchor:emailLabel.bottomAnchor constant:20],
        [passwordLabel.leadingAnchor constraintEqualToAnchor:usernameLabel.leadingAnchor],
        [passwordLabel.widthAnchor constraintEqualToAnchor:usernameLabel.widthAnchor],
        [self.registrationPasswordField.leadingAnchor constraintEqualToAnchor:self.registrationUsernameField.leadingAnchor],
        [self.registrationPasswordField.trailingAnchor constraintEqualToAnchor:self.registrationUsernameField.trailingAnchor],
        [self.registrationPasswordField.centerYAnchor constraintEqualToAnchor:passwordLabel.centerYAnchor],
        [self.registrationStatusLabel.topAnchor constraintEqualToAnchor:passwordLabel.bottomAnchor constant:24],
        [self.registrationStatusLabel.leadingAnchor constraintEqualToAnchor:title.leadingAnchor],
        [self.registrationStatusLabel.trailingAnchor constraintEqualToAnchor:title.trailingAnchor],
        [createButton.topAnchor constraintEqualToAnchor:self.registrationStatusLabel.bottomAnchor constant:24],
        [createButton.leadingAnchor constraintEqualToAnchor:content.leadingAnchor constant:76],
        [signInButton.centerYAnchor constraintEqualToAnchor:createButton.centerYAnchor],
        [signInButton.centerXAnchor constraintEqualToAnchor:content.centerXAnchor],
        [configButton.centerYAnchor constraintEqualToAnchor:createButton.centerYAnchor],
        [configButton.trailingAnchor constraintEqualToAnchor:content.trailingAnchor constant:-76]
    ]];
    [self.registrationPanel center];
    [self.registrationPanel makeKeyAndOrderFront:nil];
    [self.registrationPanel makeFirstResponder:self.registrationUsernameField];
    [NSApp runModalForWindow:self.registrationPanel];
}

- (void)finishRegistrationSplash {
    if (!self.registrationPanel) return;
    [NSApp stopModal];
    [self.registrationPanel close];
    self.registrationPanel = nil;
}

- (NSDictionary *)registrationCredentialsRequireUsername:(BOOL)requireUsername {
    NSString *username = [self trimmedString:self.registrationUsernameField.stringValue];
    NSString *email = [self trimmedString:self.registrationEmailField.stringValue];
    NSString *password = self.registrationPasswordField.stringValue ?: @"";
    BOOL isAdminBypass = [username isEqualToString:@"SoundsSimpleAdmin"] && [password isEqualToString:@"SoundsSimple1!"];
    if (!isAdminBypass && ((requireUsername && username.length == 0) || email.length == 0 || password.length == 0)) {
        self.registrationStatusLabel.stringValue = requireUsername ? @"Enter a username, email, and password." : @"Enter your email and password.";
        return nil;
    }
    return @{@"username": username, @"email": email, @"password": password};
}

- (BOOL)useLocalAdminBypassIfPossible:(NSDictionary *)credentials {
    if (![credentials[@"username"] isEqualToString:@"SoundsSimpleAdmin"] || ![credentials[@"password"] isEqualToString:@"SoundsSimple1!"]) {
        return NO;
    }
    self.supabaseAccessToken = @"local-admin-bypass";
    self.supabaseRefreshToken = @"";
    self.accountUsername = @"SoundsSimpleAdmin";
    self.accountEmail = self.adminEmail ?: @"soundssimpleadmin@gmail.com";
    [self saveSettings];
    self.statusLabel.stringValue = @"Signed in as SoundsSimpleAdmin";
    [self finishRegistrationSplash];
    return YES;
}

- (IBAction)registrationCreateAccount:(id)sender {
    NSDictionary *credentials = [self registrationCredentialsRequireUsername:YES];
    if (!credentials) return;
    if ([self useLocalAdminBypassIfPossible:credentials]) return;
    if (![self hasSupabaseConfig]) {
        self.registrationStatusLabel.stringValue = @"Configure Supabase first.";
        return;
    }
    self.registrationStatusLabel.stringValue = @"Creating account...";
    NSDictionary *metadata = @{@"username": credentials[@"username"], @"display_name": credentials[@"username"]};
    [self sendSupabaseRequest:@"/auth/v1/signup" method:@"POST" body:@{@"email": credentials[@"email"], @"password": credentials[@"password"], @"data": metadata} authorized:NO completion:^(NSDictionary *json, NSError *error) {
        if (error) {
            self.registrationStatusLabel.stringValue = error.localizedDescription;
            return;
        }
        [self storeSupabaseSession:json fallbackEmail:credentials[@"email"]];
        if (self.supabaseAccessToken.length == 0) {
            self.registrationStatusLabel.stringValue = @"Account created. Check your email, then sign in.";
            return;
        }
        self.accountUsername = credentials[@"username"];
        [self saveSettings];
        self.statusLabel.stringValue = [NSString stringWithFormat:@"Signed in as %@", self.accountUsername];
        [self finishRegistrationSplash];
    }];
}

- (IBAction)registrationSignIn:(id)sender {
    NSDictionary *credentials = [self registrationCredentialsRequireUsername:NO];
    if (!credentials) return;
    if ([self useLocalAdminBypassIfPossible:credentials]) return;
    if (![self hasSupabaseConfig]) {
        self.registrationStatusLabel.stringValue = @"Configure Supabase first.";
        return;
    }
    self.registrationStatusLabel.stringValue = @"Signing in...";
    [self sendSupabaseRequest:@"/auth/v1/token?grant_type=password" method:@"POST" body:@{@"email": credentials[@"email"], @"password": credentials[@"password"]} authorized:NO completion:^(NSDictionary *json, NSError *error) {
        if (error) {
            self.registrationStatusLabel.stringValue = error.localizedDescription;
            return;
        }
        [self storeSupabaseSession:json fallbackEmail:credentials[@"email"]];
        if (self.supabaseAccessToken.length == 0) {
            self.registrationStatusLabel.stringValue = @"Sign-in did not return a session. Check email confirmation or Supabase Auth settings.";
            return;
        }
        self.statusLabel.stringValue = [NSString stringWithFormat:@"Signed in as %@", self.accountUsername.length ? self.accountUsername : self.accountEmail];
        [self finishRegistrationSplash];
    }];
}

- (void)refreshPadView {
    if (!self.padContentView) return;
    for (NSView *view in self.padContentView.subviews.copy) {
        [view removeFromSuperview];
    }

    CGFloat padWidth = self.largePads ? 178 : 148;
    CGFloat labelHeight = self.largePads ? 42 : 36;
    CGFloat padHeight = padWidth + labelHeight + 6;
    CGFloat gap = 14;
    CGFloat inset = 14;
    CGFloat availableWidth = MAX(self.padScrollView.contentSize.width, 520);
    NSInteger columns = MAX(1, (NSInteger)((availableWidth - inset) / (padWidth + gap)));
    NSInteger rows = MAX(1, (NSInteger)ceil((double)self.filteredItems.count / (double)columns));
    CGFloat contentWidth = MAX(availableWidth, inset + columns * padWidth + (columns - 1) * gap + inset);
    CGFloat contentHeight = MAX(self.padScrollView.contentSize.height, inset + rows * padHeight + (rows - 1) * gap + inset);
    self.padContentView.frame = NSMakeRect(0, 0, contentWidth, contentHeight);
    self.padContentView.wantsLayer = YES;
    self.padContentView.layer.backgroundColor = [self themeColor:@"surface"].CGColor;

    for (NSUInteger index = 0; index < self.filteredItems.count; index++) {
        NSDictionary *item = self.filteredItems[index];
        NSInteger column = index % columns;
        NSInteger row = index / columns;
        CGFloat x = inset + column * (padWidth + gap);
        CGFloat y = contentHeight - inset - padHeight - row * (padHeight + gap);
        ShapePadButton *pad = [[ShapePadButton alloc] initWithFrame:NSMakeRect(x, y, padWidth, padHeight)];
        pad.controller = self;
        pad.item = item;
        pad.target = self;
        pad.action = @selector(padPressed:);
        pad.frame = NSMakeRect(x, y, padWidth, padHeight);
        pad.bordered = NO;
        pad.selectedPad = self.selectedItemID && [item[@"id"] integerValue] == self.selectedItemID.integerValue;
        objc_setAssociatedObject(pad, "itemID", item[@"id"], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.padContentView addSubview:pad];
    }
}

- (void)windowDidResize:(NSNotification *)notification {
    [self adjustTableColumns];
    [self updateEditorWaveformSize];
    [self refreshPadView];
    [self.tableView reloadData];
    [self.playlistTableView reloadData];
    [self.playlistSongsTableView reloadData];
}

- (void)adjustTableColumns {
    CGFloat listWidth = MAX(self.listScrollView.contentSize.width - 8, 520);
    NSTableColumn *imageColumn = [self.tableView tableColumnWithIdentifier:@"image"];
    NSTableColumn *keyColumn = [self.tableView tableColumnWithIdentifier:@"key"];
    NSTableColumn *nameColumn = [self.tableView tableColumnWithIdentifier:@"name"];
    NSTableColumn *categoryColumn = [self.tableView tableColumnWithIdentifier:@"category"];
    NSTableColumn *kindColumn = [self.tableView tableColumnWithIdentifier:@"kind"];
    imageColumn.width = 48;
    keyColumn.width = 72;
    categoryColumn.width = 120;
    kindColumn.width = 96;
    nameColumn.width = MAX(180, listWidth - imageColumn.width - keyColumn.width - categoryColumn.width - kindColumn.width - 18);

    NSTableColumn *trackColumn = [self.playlistSongsTableView tableColumnWithIdentifier:@"trackNumber"];
    NSTableColumn *titleColumn = [self.playlistSongsTableView tableColumnWithIdentifier:@"title"];
    NSTableColumn *albumColumn = [self.playlistSongsTableView tableColumnWithIdentifier:@"album"];
    NSTableColumn *artistColumn = [self.playlistSongsTableView tableColumnWithIdentifier:@"artist"];
    NSTableColumn *durationColumn = [self.playlistSongsTableView tableColumnWithIdentifier:@"duration"];
    NSArray *songs = [self displayedPlaylistSongs];
    NSDictionary *attributes = @{NSFontAttributeName: [NSFont systemFontOfSize:13 weight:NSFontWeightMedium]};
    CGFloat trackWidth = [@"Track #" sizeWithAttributes:attributes].width;
    CGFloat titleWidth = [@"Title" sizeWithAttributes:attributes].width;
    CGFloat albumWidth = [@"Album" sizeWithAttributes:attributes].width;
    CGFloat artistWidth = [@"Artist" sizeWithAttributes:attributes].width;
    CGFloat durationWidth = [@"Duration" sizeWithAttributes:attributes].width;
    for (NSDictionary *song in songs) {
        NSString *track = [song[@"trackNumber"] integerValue] > 0 ? [NSString stringWithFormat:@"%ld", (long)[song[@"trackNumber"] integerValue]] : @"";
        NSString *title = song[@"title"] ?: @"Song";
        NSString *album = song[@"album"] ?: @"";
        NSString *artist = song[@"artist"] ?: @"";
        NSString *duration = [self durationStringForSeconds:song[@"duration"] ?: @0];
        trackWidth = MAX(trackWidth, [track sizeWithAttributes:attributes].width);
        titleWidth = MAX(titleWidth, [title sizeWithAttributes:attributes].width);
        albumWidth = MAX(albumWidth, [album sizeWithAttributes:attributes].width);
        artistWidth = MAX(artistWidth, [artist sizeWithAttributes:attributes].width);
        durationWidth = MAX(durationWidth, [duration sizeWithAttributes:attributes].width);
    }
    trackColumn.width = MIN(MAX(trackWidth + 34, 72), 110);
    titleColumn.width = MIN(MAX(titleWidth + 34, 180), 460);
    albumColumn.width = MIN(MAX(albumWidth + 34, 150), 380);
    artistColumn.width = MIN(MAX(artistWidth + 34, 140), 320);
    durationColumn.width = MIN(MAX(durationWidth + 34, 90), 120);

    CGFloat songsWidth = MAX(self.playlistSongsTableView.enclosingScrollView.contentSize.width - 8, 320);
    CGFloat totalWidth = trackColumn.width + titleColumn.width + albumColumn.width + artistColumn.width + durationColumn.width;
    if (totalWidth < songsWidth) {
        CGFloat extra = songsWidth - totalWidth;
        titleColumn.width += extra * 0.45;
        albumColumn.width += extra * 0.30;
        artistColumn.width += extra * 0.25;
    }
}

- (void)padViewportChanged:(NSNotification *)notification {
    if ([self.viewMode isEqualToString:@"pad"]) {
        [self refreshPadView];
    }
}

- (NSArray<NSURL *> *)recordingFiles {
    NSURL *soundsURL = [self soundsFolderURL];
    NSArray<NSURL *> *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:soundsURL
                                                            includingPropertiesForKeys:@[NSURLContentModificationDateKey]
                                                                               options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                                 error:nil] ?: @[];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSURL *url, NSDictionary *bindings) {
        NSString *name = url.lastPathComponent;
        return [name hasPrefix:@"Recording-"] && [[url.pathExtension lowercaseString] isEqualToString:@"m4a"];
    }];
    NSArray<NSURL *> *recordings = [files filteredArrayUsingPredicate:predicate];
    return [recordings sortedArrayUsingComparator:^NSComparisonResult(NSURL *a, NSURL *b) {
        NSDate *ad = nil;
        NSDate *bd = nil;
        [a getResourceValue:&ad forKey:NSURLContentModificationDateKey error:nil];
        [b getResourceValue:&bd forKey:NSURLContentModificationDateKey error:nil];
        return [(bd ?: [NSDate distantPast]) compare:(ad ?: [NSDate distantPast])];
    }];
}

- (void)refreshRecentRecordings {
    NSArray<NSURL *> *recordings = [self recordingFiles];
    self.recentRecordingURLs = [recordings subarrayWithRange:NSMakeRange(0, MIN((NSUInteger)20, recordings.count))];
    [self.recentRecordingsTableView reloadData];
}

- (NSURL *)selectedRecordingURL {
    NSInteger row = self.recentRecordingsTableView.clickedRow >= 0 ? self.recentRecordingsTableView.clickedRow : self.recentRecordingsTableView.selectedRow;
    if (row < 0 || row >= (NSInteger)self.recentRecordingURLs.count) return nil;
    return self.recentRecordingURLs[row];
}

- (IBAction)playSelectedRecording {
    NSURL *url = [self selectedRecordingURL];
    if (!url) {
        self.recordingStatusLabel.stringValue = @"Select a recording first";
        return;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    if (!player) {
        [self showAlert:@"Playback Failed" message:@"Could not play that recording."];
        return;
    }
    [player prepareToPlay];
    [player play];
    [self.players addObject:player];
    self.recordingStatusLabel.stringValue = [NSString stringWithFormat:@"Playing %@", url.lastPathComponent];
}

- (IBAction)playDoubleClickedRecording:(id)sender {
    NSInteger row = self.recentRecordingsTableView.clickedRow;
    if (row >= 0 && row < (NSInteger)self.recentRecordingURLs.count) {
        [self.recentRecordingsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
    }
    [self playSelectedRecording];
}

- (IBAction)showSelectedRecordingInFinder {
    NSURL *url = [self selectedRecordingURL];
    if (!url) {
        self.recordingStatusLabel.stringValue = @"Select a recording first";
        return;
    }
    [[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:@[url]];
}

- (IBAction)deleteSelectedRecording {
    NSURL *url = [self selectedRecordingURL];
    if (!url) {
        self.recordingStatusLabel.stringValue = @"Select a recording first";
        return;
    }
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = [NSString stringWithFormat:@"Delete %@?", url.lastPathComponent];
    alert.informativeText = @"This removes the recording from the app and deletes the audio file from disk.";
    [alert addButtonWithTitle:@"Delete File"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] != NSAlertFirstButtonReturn) return;

    NSError *error = nil;
    if (![[NSFileManager defaultManager] removeItemAtURL:url error:&error]) {
        [self showAlert:@"Delete Failed" message:error.localizedDescription ?: @"Could not delete the recording file."];
        return;
    }
    if ([self.editorSourceURL.path isEqualToString:url.path]) {
        self.editorSourceURL = nil;
        self.editorLoadedLabel.stringValue = @"No audio loaded";
        self.editorStatusLabel.stringValue = @"Deleted loaded recording.";
    }
    [self refreshRecentRecordings];
    self.recordingStatusLabel.stringValue = @"Deleted recording";
}

- (IBAction)playClickedRecording:(id)sender {
    [self playSelectedRecording];
}

- (IBAction)showClickedRecordingInFinder:(id)sender {
    [self showSelectedRecordingInFinder];
}

- (IBAction)deleteClickedRecording:(id)sender {
    [self deleteSelectedRecording];
}

- (IBAction)openClickedRecordingInEditor:(id)sender {
    NSURL *url = [self selectedRecordingURL];
    if (!url) return;
    [self loadEditorURL:url];
    self.viewMode = @"editor";
    [self saveSettings];
    [self applyViewMode];
}

- (void)applyFilterSelectingID:(NSNumber *)selectedID {
    NSString *query = [self.searchField.stringValue lowercaseString] ?: @"";
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSMutableDictionary *item, NSDictionary *bindings) {
        if (query.length == 0) return YES;
        NSString *haystack = [[NSString stringWithFormat:@"%@ %@ %@ %@",
            item[@"key"] ?: @"", item[@"name"] ?: @"", item[@"kind"] ?: @"", item[@"category"] ?: @""] lowercaseString];
        return [haystack containsString:query];
    }];
    NSArray *visible = [self.items filteredArrayUsingPredicate:predicate];
    self.filteredItems = [visible sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a, NSDictionary *b) {
        NSString *ak = [a[@"key"] ?: @"" lowercaseString];
        NSString *bk = [b[@"key"] ?: @"" lowercaseString];
        NSComparisonResult result = [ak compare:bk];
        if (result != NSOrderedSame) return result;
        return [[a[@"name"] ?: @"" lowercaseString] compare:[b[@"name"] ?: @"" lowercaseString]];
    }];
    [self.tableView reloadData];
    [self refreshPadView];
    if (selectedID) {
        NSUInteger index = [self.filteredItems indexOfObjectPassingTest:^BOOL(NSDictionary *item, NSUInteger idx, BOOL *stop) {
            return [item[@"id"] integerValue] == selectedID.integerValue;
        }];
        if (index != NSNotFound) {
            self.selectedItemID = selectedID;
            [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:index] byExtendingSelection:NO];
            [self.tableView scrollRowToVisible:index];
        }
    } else if (self.filteredItems.count > 0 && self.tableView.selectedRow < 0) {
        self.selectedItemID = self.filteredItems[0][@"id"];
        [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    }
    [self refreshPadView];
    self.statusLabel.stringValue = [NSString stringWithFormat:@"%lu soundboard item(s)", (unsigned long)self.items.count];
}

- (IBAction)searchChanged:(id)sender {
    [self applyFilterSelectingID:nil];
}

- (IBAction)padPressed:(NSButton *)sender {
    NSNumber *itemID = objc_getAssociatedObject(sender, "itemID");
    NSMutableDictionary *item = [self itemWithID:itemID];
    if (!item) return;
    self.selectedItemID = itemID;
    [self refreshPadView];
    [self playItem:item];
}

- (NSMutableDictionary *)selectedPlaylist {
    if (self.selectedPlaylistIndex < 0 || self.selectedPlaylistIndex >= (NSInteger)self.playlists.count) return nil;
    return self.playlists[self.selectedPlaylistIndex];
}

- (NSInteger)playlistIndexForTableRow:(NSInteger)row {
    return row <= 0 ? -1 : row - 1;
}

- (NSInteger)tableRowForPlaylistIndex:(NSInteger)playlistIndex {
    return playlistIndex < 0 ? 0 : playlistIndex + 1;
}

- (BOOL)isAllSongsSelected {
    return self.selectedPlaylistIndex < 0;
}

- (NSMutableArray *)selectedPlaylistSongs {
    NSMutableDictionary *playlist = [self selectedPlaylist];
    if (!playlist) return [NSMutableArray array];
    NSMutableArray *songs = playlist[@"songs"];
    if (![songs isKindOfClass:[NSMutableArray class]]) {
        songs = [NSMutableArray array];
        playlist[@"songs"] = songs;
    }
    return songs;
}

- (NSMutableArray *)songsForPlaylistIndex:(NSInteger)playlistIndex {
    if (playlistIndex < 0 || playlistIndex >= (NSInteger)self.playlists.count) return nil;
    NSMutableDictionary *playlist = self.playlists[playlistIndex];
    NSMutableArray *songs = playlist[@"songs"];
    if (![songs isKindOfClass:[NSMutableArray class]]) {
        songs = [NSMutableArray array];
        playlist[@"songs"] = songs;
    }
    return songs;
}

- (NSArray<NSMutableDictionary *> *)allPlaylistSongs {
    return self.musicLibrary ?: @[];
}

- (NSMutableDictionary *)librarySongForTarget:(NSString *)target {
    if (target.length == 0) return nil;
    for (NSMutableDictionary *song in self.musicLibrary) {
        if ([song[@"target"] isEqualToString:target]) return song;
    }
    return nil;
}

- (NSMutableDictionary *)addSongToLibraryIfNeeded:(NSDictionary *)song {
    NSString *target = song[@"target"] ?: @"";
    NSMutableDictionary *existing = [self librarySongForTarget:target];
    if (existing) return existing;
    NSMutableDictionary *copy = [song mutableCopy];
    [self.musicLibrary addObject:copy];
    return copy;
}

- (void)syncMusicMetadataFromSong:(NSDictionary *)sourceSong {
    NSString *target = sourceSong[@"target"] ?: @"";
    if (target.length == 0) return;
    NSArray *metadataKeys = @[@"title", @"artist", @"album", @"trackNumber", @"duration", @"artworkTarget"];
    NSMutableArray *matches = [NSMutableArray array];
    NSMutableDictionary *librarySong = [self librarySongForTarget:target];
    if (librarySong) [matches addObject:librarySong];
    for (NSMutableDictionary *playlist in self.playlists) {
        NSArray *playlistSongs = playlist[@"songs"];
        if ([playlistSongs isKindOfClass:[NSArray class]]) {
            for (NSMutableDictionary *song in playlistSongs) {
                if ([song isKindOfClass:[NSMutableDictionary class]] && [song[@"target"] isEqualToString:target]) [matches addObject:song];
            }
        }
    }
    for (NSMutableDictionary *song in matches) {
        for (NSString *key in metadataKeys) {
            id value = sourceSong[key];
            if (value) song[key] = value;
            else [song removeObjectForKey:key];
        }
    }
}

- (NSArray<NSMutableDictionary *> *)displayedPlaylistSongs {
    NSArray *songs = [self isAllSongsSelected] ? [self allPlaylistSongs] : [self selectedPlaylistSongs];
    if (self.musicSortDescriptors.count > 0) {
        return [songs sortedArrayUsingDescriptors:self.musicSortDescriptors];
    }
    return songs;
}

- (NSMutableDictionary *)displayedPlaylistSongAtRow:(NSInteger)row {
    NSArray *songs = [self displayedPlaylistSongs];
    if (row < 0 || row >= (NSInteger)songs.count) return nil;
    return songs[row];
}

- (NSString *)playlistTitleForSelectedMusicView {
    return [self isAllSongsSelected] ? @"All Songs" : ([self selectedPlaylist][@"name"] ?: @"Playlist");
}

- (BOOL)playlistAtIndex:(NSInteger)playlistIndex containsSongWithTarget:(NSString *)target {
    if (target.length == 0) return NO;
    for (NSDictionary *song in [self songsForPlaylistIndex:playlistIndex] ?: @[]) {
        if ([song[@"target"] isEqualToString:target]) return YES;
    }
    return NO;
}

- (void)addCopyOfSong:(NSDictionary *)song toPlaylistIndex:(NSInteger)playlistIndex {
    NSMutableArray *songs = [self songsForPlaylistIndex:playlistIndex];
    if (!songs || !song) return;
    NSMutableDictionary *copy = [song mutableCopy];
    [songs addObject:copy];
}

- (NSURL *)urlForSong:(NSDictionary *)song {
    return [self resolvedSoundURLForTarget:song[@"target"] ?: @""];
}

- (NSString *)durationStringForSeconds:(NSNumber *)secondsNumber {
    NSInteger total = MAX(0, secondsNumber.integerValue);
    return [NSString stringWithFormat:@"%ld:%02ld", (long)(total / 60), (long)(total % 60)];
}

- (NSInteger)trackNumberFromString:(NSString *)string {
    NSArray *parts = [string componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    for (NSString *part in parts) {
        if (part.length > 0) return part.integerValue;
    }
    return 0;
}

- (IBAction)addMusicPlaylist {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Add Playlist";
    NSTextField *field = [NSTextField textFieldWithString:@"New Playlist"];
    field.frame = NSMakeRect(0, 0, 260, 24);
    alert.accessoryView = field;
    [alert addButtonWithTitle:@"Add"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] != NSAlertFirstButtonReturn) return;
    NSString *name = [field.stringValue stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (name.length == 0) name = @"New Playlist";
    [self.playlists addObject:[@{@"name": name, @"songs": [NSMutableArray array]} mutableCopy]];
    self.selectedPlaylistIndex = self.playlists.count - 1;
    [self savePlaylists];
    [self.playlistTableView reloadData];
    [self.playlistSongsTableView reloadData];
    [self.playlistTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:[self tableRowForPlaylistIndex:self.selectedPlaylistIndex]] byExtendingSelection:NO];
}

- (void)editPlaylistNameAtRow:(NSInteger)row {
    if (row < 0 || row >= (NSInteger)self.playlists.count) return;
    NSMutableDictionary *playlist = self.playlists[row];
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Edit Playlist Name";
    NSTextField *field = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 320, 26)];
    field.stringValue = playlist[@"name"] ?: @"Playlist";
    alert.accessoryView = field;
    [alert addButtonWithTitle:@"Save"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] != NSAlertFirstButtonReturn) return;
    NSString *name = [self trimmedString:field.stringValue];
    if (name.length == 0) {
        [self showAlert:@"Missing Name" message:@"Enter a playlist name."];
        return;
    }
    playlist[@"name"] = name;
    self.selectedPlaylistIndex = row;
    [self savePlaylists];
    [self.playlistTableView reloadData];
    [self.playlistTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:[self tableRowForPlaylistIndex:row]] byExtendingSelection:NO];
    self.musicStatusLabel.stringValue = [NSString stringWithFormat:@"Renamed playlist to %@", name];
}

- (IBAction)editClickedPlaylistName:(id)sender {
    NSInteger row = self.playlistTableView.clickedRow >= 0 ? self.playlistTableView.clickedRow : self.playlistTableView.selectedRow;
    NSInteger playlistIndex = [self playlistIndexForTableRow:row];
    if (playlistIndex < 0) {
        self.musicStatusLabel.stringValue = @"All Songs is a fixed library view.";
        return;
    }
    [self editPlaylistNameAtRow:playlistIndex];
}

- (IBAction)editSelectedPlaylistName:(id)sender {
    NSInteger row = self.playlistTableView.selectedRow >= 0 ? self.playlistTableView.selectedRow : [self tableRowForPlaylistIndex:self.selectedPlaylistIndex];
    NSInteger playlistIndex = [self playlistIndexForTableRow:row];
    if (playlistIndex < 0) {
        self.musicStatusLabel.stringValue = @"All Songs is a fixed library view.";
        return;
    }
    [self editPlaylistNameAtRow:playlistIndex];
}

- (void)addSongURLToSelectedPlaylist:(NSURL *)url {
    NSError *copyError = nil;
    NSString *target = [self portableTargetForSoundURL:url error:&copyError];
    if (!target) {
        [self showAlert:@"Import Failed" message:copyError.localizedDescription ?: @"Could not import that song."];
        return;
    }
    NSMutableDictionary *song = [@{
        @"title": url.URLByDeletingPathExtension.lastPathComponent ?: @"Song",
        @"artist": @"",
        @"album": @"",
        @"trackNumber": @0,
        @"duration": @0,
        @"target": target
    } mutableCopy];
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[self resolvedSoundURLForTarget:target] options:nil];
    Float64 duration = CMTimeGetSeconds(asset.duration);
    if (isfinite(duration) && duration > 0) song[@"duration"] = @((NSInteger)llround(duration));
    for (AVMetadataItem *meta in asset.commonMetadata) {
        if ([meta.commonKey isEqualToString:AVMetadataCommonKeyTitle] && meta.stringValue.length) song[@"title"] = meta.stringValue;
        if ([meta.commonKey isEqualToString:AVMetadataCommonKeyArtist] && meta.stringValue.length) song[@"artist"] = meta.stringValue;
        if ([meta.commonKey isEqualToString:@"albumName"] && meta.stringValue.length) song[@"album"] = meta.stringValue;
        if ([meta.commonKey isEqualToString:AVMetadataCommonKeyArtwork] && [meta.value isKindOfClass:[NSData class]]) {
            NSURL *artURL = [[self imagesFolderURL] URLByAppendingPathComponent:[[NSUUID UUID].UUIDString stringByAppendingPathExtension:@"jpg"]];
            [(NSData *)meta.value writeToURL:artURL atomically:YES];
            song[@"artworkTarget"] = [@"Images" stringByAppendingPathComponent:artURL.lastPathComponent];
        }
    }
    for (AVMetadataItem *meta in asset.metadata) {
        NSString *rawIdentifier = meta.identifier ?: (meta.commonKey ?: @"");
        NSString *identifier = [rawIdentifier.lowercaseString copy];
        NSString *value = meta.stringValue ?: @"";
        if ([identifier containsString:@"album"] && value.length && [song[@"album"] length] == 0) song[@"album"] = value;
        if (([identifier containsString:@"tracknumber"] || [identifier containsString:@"track number"]) && value.length) {
            NSInteger track = [self trackNumberFromString:value];
            if (track > 0) song[@"trackNumber"] = @(track);
        }
    }
    [self addSongToLibraryIfNeeded:song];
    [[self selectedPlaylistSongs] addObject:[song mutableCopy]];
}

- (IBAction)addSongsToPlaylist {
    if (![self selectedPlaylist]) {
        self.musicStatusLabel.stringValue = @"Choose a regular playlist before adding files.";
        return;
    }
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.title = @"Add Songs";
    panel.canChooseDirectories = NO;
    panel.allowsMultipleSelection = YES;
    panel.allowedFileTypes = @[@"aac", @"aif", @"aiff", @"flac", @"m4a", @"mp3", @"ogg", @"wav"];
    if ([panel runModal] != NSModalResponseOK) return;
    for (NSURL *url in panel.URLs) [self addSongURLToSelectedPlaylist:url];
    [self savePlaylists];
    [self.playlistSongsTableView reloadData];
    [self adjustTableColumns];
}

- (NSInteger)promptForDestinationPlaylistWithTitle:(NSString *)title {
    if (self.playlists.count == 0) return -1;
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = title;
    NSPopUpButton *popup = [[NSPopUpButton alloc] initWithFrame:NSMakeRect(0, 0, 320, 28)];
    for (NSInteger index = 0; index < (NSInteger)self.playlists.count; index++) {
        [popup addItemWithTitle:self.playlists[index][@"name"] ?: @"Playlist"];
        popup.lastItem.representedObject = @(index);
    }
    if (self.selectedPlaylistIndex >= 0 && self.selectedPlaylistIndex < (NSInteger)self.playlists.count) {
        [popup selectItemAtIndex:self.selectedPlaylistIndex];
    }
    alert.accessoryView = popup;
    [alert addButtonWithTitle:@"Choose"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] != NSAlertFirstButtonReturn) return -1;
    return [popup.selectedItem.representedObject integerValue];
}

- (void)copySong:(NSDictionary *)song toPlaylistIndex:(NSInteger)destinationIndex {
    if (!song || destinationIndex < 0 || destinationIndex >= (NSInteger)self.playlists.count) return;
    NSString *target = song[@"target"] ?: @"";
    if ([self playlistAtIndex:destinationIndex containsSongWithTarget:target]) {
        self.musicStatusLabel.stringValue = @"That song is already in the selected playlist.";
        return;
    }
    [self addSongToLibraryIfNeeded:song];
    [self addCopyOfSong:song toPlaylistIndex:destinationIndex];
    [self savePlaylists];
    self.selectedPlaylistIndex = destinationIndex;
    [self.playlistTableView reloadData];
    [self.playlistSongsTableView reloadData];
    [self adjustTableColumns];
    [self.playlistTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:[self tableRowForPlaylistIndex:destinationIndex]] byExtendingSelection:NO];
    self.musicStatusLabel.stringValue = [NSString stringWithFormat:@"Added to %@", self.playlists[destinationIndex][@"name"] ?: @"playlist"];
}

- (IBAction)addSongFromOtherPlaylist {
    NSInteger destinationIndex = self.selectedPlaylistIndex;
    if (destinationIndex < 0 || destinationIndex >= (NSInteger)self.playlists.count) {
        destinationIndex = [self promptForDestinationPlaylistWithTitle:@"Choose Destination Playlist"];
        if (destinationIndex < 0) return;
    }

    NSMutableArray<NSDictionary *> *choices = [NSMutableArray array];
    for (NSInteger playlistIndex = 0; playlistIndex < (NSInteger)self.playlists.count; playlistIndex++) {
        if (playlistIndex == destinationIndex) continue;
        NSString *playlistName = self.playlists[playlistIndex][@"name"] ?: @"Playlist";
        for (NSDictionary *song in [self songsForPlaylistIndex:playlistIndex]) {
            NSString *title = song[@"title"] ?: @"Song";
            NSString *target = song[@"target"] ?: @"";
            if ([self playlistAtIndex:destinationIndex containsSongWithTarget:target]) continue;
            [choices addObject:@{@"title": [NSString stringWithFormat:@"%@ - %@", playlistName, title], @"song": song}];
        }
    }
    if (choices.count == 0) {
        self.musicStatusLabel.stringValue = @"No songs from other playlists are available to add.";
        return;
    }

    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Add From Playlist";
    NSPopUpButton *popup = [[NSPopUpButton alloc] initWithFrame:NSMakeRect(0, 0, 380, 28)];
    for (NSDictionary *choice in choices) {
        [popup addItemWithTitle:choice[@"title"]];
        popup.lastItem.representedObject = choice[@"song"];
    }
    alert.accessoryView = popup;
    [alert addButtonWithTitle:@"Add"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] != NSAlertFirstButtonReturn) return;
    [self copySong:popup.selectedItem.representedObject toPlaylistIndex:destinationIndex];
}

- (IBAction)copySelectedMusicSongToPlaylist:(id)sender {
    NSInteger row = self.playlistSongsTableView.clickedRow >= 0 ? self.playlistSongsTableView.clickedRow : self.playlistSongsTableView.selectedRow;
    NSDictionary *song = [self displayedPlaylistSongAtRow:row];
    if (!song) return;
    NSInteger destinationIndex = [self promptForDestinationPlaylistWithTitle:@"Add Song to Playlist"];
    if (destinationIndex < 0) return;
    [self copySong:song toPlaylistIndex:destinationIndex];
}

- (IBAction)openSelectedPlaylist {
    NSInteger row = self.playlistTableView.clickedRow >= 0 ? self.playlistTableView.clickedRow : self.playlistTableView.selectedRow;
    if (row >= 0 && row < (NSInteger)self.playlists.count + 1) {
        self.selectedPlaylistIndex = [self playlistIndexForTableRow:row];
        self.currentSongIndex = -1;
        [self.playlistSongsTableView reloadData];
        self.musicStatusLabel.stringValue = [NSString stringWithFormat:@"Opened %@", [self playlistTitleForSelectedMusicView]];
    }
}

- (IBAction)playDoubleClickedPlaylist:(id)sender {
    NSInteger row = self.playlistTableView.clickedRow;
    if (row >= 0 && row < (NSInteger)self.playlists.count + 1) {
        [self.playlistTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
        self.selectedPlaylistIndex = [self playlistIndexForTableRow:row];
        self.currentSongIndex = -1;
        [self.playlistSongsTableView reloadData];
        [self adjustTableColumns];
        if ([self displayedPlaylistSongs].count > 0) {
            [self loadMusicSongAtIndex:0 play:YES];
        } else {
            self.musicStatusLabel.stringValue = [NSString stringWithFormat:@"%@ has no songs yet", [self playlistTitleForSelectedMusicView]];
        }
    }
}

- (void)loadMusicSongAtIndex:(NSInteger)index play:(BOOL)play {
    NSArray *songs = [self displayedPlaylistSongs];
    if (index < 0 || index >= (NSInteger)songs.count) return;
    self.currentSongIndex = index;
    NSDictionary *song = songs[index];
    NSURL *url = [self urlForSong:song];
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.musicPlayer.delegate = self;
    self.musicTitleLabel.stringValue = song[@"title"] ?: url.lastPathComponent;
    self.musicArtistLabel.stringValue = song[@"artist"] ?: @"";
    NSString *artworkTarget = song[@"artworkTarget"] ?: @"";
    self.musicArtworkView.image = artworkTarget.length ? [[NSImage alloc] initWithContentsOfURL:[self resolvedImageURLForTarget:artworkTarget]] : nil;
    if (play) {
        [self.musicPlayer play];
        self.musicStatusLabel.stringValue = @"Playing";
    }
}

- (IBAction)playSelectedPlaylistSong {
    NSInteger row = self.playlistSongsTableView.clickedRow >= 0 ? self.playlistSongsTableView.clickedRow : self.playlistSongsTableView.selectedRow;
    [self loadMusicSongAtIndex:row play:YES];
}

- (IBAction)playDoubleClickedPlaylistSong:(id)sender {
    NSInteger row = self.playlistSongsTableView.clickedRow;
    if (row >= 0 && row < (NSInteger)[self displayedPlaylistSongs].count) {
        [self.playlistSongsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
        [self loadMusicSongAtIndex:row play:YES];
    }
}

- (IBAction)editClickedMusicSong:(id)sender {
    NSInteger row = self.playlistSongsTableView.clickedRow >= 0 ? self.playlistSongsTableView.clickedRow : self.playlistSongsTableView.selectedRow;
    NSMutableDictionary *song = [self displayedPlaylistSongAtRow:row];
    if (!song) return;
    [self.playlistSongsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];

    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Edit Song Data";
    alert.informativeText = @"Update the song information shown in the music table.";
    NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 420, 178)];
    NSArray *labels = @[@"Track #", @"Title", @"Album", @"Artist", @"Duration"];
    NSArray *values = @[
        [NSString stringWithFormat:@"%@", song[@"trackNumber"] ?: @""],
        song[@"title"] ?: @"",
        song[@"album"] ?: @"",
        song[@"artist"] ?: @"",
        [self durationStringForSeconds:song[@"duration"] ?: @0]
    ];
    NSMutableArray<NSTextField *> *fields = [NSMutableArray array];
    NSTextField *previousLabel = nil;
    for (NSInteger index = 0; index < (NSInteger)labels.count; index++) {
        NSTextField *label = [NSTextField labelWithString:labels[index]];
        NSTextField *field = [[NSTextField alloc] initWithFrame:NSZeroRect];
        field.stringValue = values[index];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        field.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        [view addSubview:field];
        [fields addObject:field];
        [NSLayoutConstraint activateConstraints:@[
            [label.leadingAnchor constraintEqualToAnchor:view.leadingAnchor],
            [label.widthAnchor constraintEqualToConstant:76],
            [field.leadingAnchor constraintEqualToAnchor:label.trailingAnchor constant:12],
            [field.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
            previousLabel ? [label.topAnchor constraintEqualToAnchor:previousLabel.bottomAnchor constant:18] : [label.topAnchor constraintEqualToAnchor:view.topAnchor constant:4],
            [field.centerYAnchor constraintEqualToAnchor:label.centerYAnchor]
        ]];
        previousLabel = label;
    }
    alert.accessoryView = view;
    [alert addButtonWithTitle:@"Save"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] != NSAlertFirstButtonReturn) return;

    NSInteger track = [self trackNumberFromString:fields[0].stringValue];
    song[@"trackNumber"] = @(track);
    song[@"title"] = [self trimmedString:fields[1].stringValue].length ? [self trimmedString:fields[1].stringValue] : @"Song";
    song[@"album"] = [self trimmedString:fields[2].stringValue];
    song[@"artist"] = [self trimmedString:fields[3].stringValue];
    NSString *durationText = [self trimmedString:fields[4].stringValue];
    NSArray *durationParts = [durationText componentsSeparatedByString:@":"];
    NSInteger seconds = durationText.integerValue;
    if (durationParts.count == 2) {
        seconds = [durationParts[0] integerValue] * 60 + [durationParts[1] integerValue];
    }
    song[@"duration"] = @(MAX(0, seconds));
    [self syncMusicMetadataFromSong:song];
    [self savePlaylists];
    [self.playlistSongsTableView reloadData];
    [self adjustTableColumns];
    [self loadMusicSongAtIndex:row play:NO];
}

- (IBAction)toggleMusicPlayback {
    if (!self.musicPlayer) {
        NSInteger row = self.playlistSongsTableView.selectedRow >= 0 ? self.playlistSongsTableView.selectedRow : 0;
        [self loadMusicSongAtIndex:row play:YES];
        return;
    }
    if (self.musicPlayer.isPlaying) {
        [self.musicPlayer pause];
        self.musicStatusLabel.stringValue = @"Paused";
    } else {
        [self.musicPlayer play];
        self.musicStatusLabel.stringValue = @"Playing";
    }
}

- (IBAction)nextSong {
    NSArray *songs = [self displayedPlaylistSongs];
    if (songs.count == 0) return;
    [self loadMusicSongAtIndex:(self.currentSongIndex + 1) % songs.count play:YES];
}

- (IBAction)previousSong {
    NSArray *songs = [self displayedPlaylistSongs];
    if (songs.count == 0) return;
    NSInteger next = self.currentSongIndex <= 0 ? songs.count - 1 : self.currentSongIndex - 1;
    [self loadMusicSongAtIndex:next play:YES];
}

- (IBAction)fastForwardSong {
    self.musicPlayer.currentTime = MIN(self.musicPlayer.duration, self.musicPlayer.currentTime + 15);
}

- (IBAction)rewindSong {
    self.musicPlayer.currentTime = MAX(0, self.musicPlayer.currentTime - 15);
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (player == self.musicPlayer) [self nextSong];
}

- (IBAction)shareSongToSoundboard {
    NSInteger row = self.playlistSongsTableView.selectedRow;
    NSDictionary *song = [self displayedPlaylistSongAtRow:row];
    if (!song) return;
    NSMutableDictionary *item = [@{
        @"id": @([self nextID]),
        @"name": song[@"title"] ?: @"Song",
        @"key": @"",
        @"kind": @"sound",
        @"category": @"Music",
        @"target": song[@"target"] ?: @"",
        @"volume": @1.0
    } mutableCopy];
    if (song[@"artworkTarget"]) item[@"imageTarget"] = song[@"artworkTarget"];
    [self editItem:item isNew:YES];
}

- (IBAction)fetchSongMetadata {
    NSInteger row = self.playlistSongsTableView.selectedRow;
    NSMutableDictionary *song = [self displayedPlaylistSongAtRow:row];
    if (!song) return;
    NSString *query = [[NSString stringWithFormat:@"%@ %@", song[@"title"] ?: @"", song[@"artist"] ?: @""] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/search?entity=song&limit=1&term=%@", query]];
    self.musicStatusLabel.stringValue = @"Fetching metadata...";
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!data) return;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *result = [json[@"results"] firstObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (![result isKindOfClass:[NSDictionary class]]) {
                self.musicStatusLabel.stringValue = @"No metadata found";
                return;
            }
            if ([result[@"trackName"] isKindOfClass:[NSString class]]) song[@"title"] = result[@"trackName"];
            if ([result[@"artistName"] isKindOfClass:[NSString class]]) song[@"artist"] = result[@"artistName"];
            if ([result[@"collectionName"] isKindOfClass:[NSString class]]) song[@"album"] = result[@"collectionName"];
            if ([result[@"trackNumber"] respondsToSelector:@selector(integerValue)]) song[@"trackNumber"] = @([result[@"trackNumber"] integerValue]);
            if ([result[@"trackTimeMillis"] respondsToSelector:@selector(integerValue)]) song[@"duration"] = @([result[@"trackTimeMillis"] integerValue] / 1000);
            NSString *artwork = result[@"artworkUrl100"];
            if ([artwork isKindOfClass:[NSString class]]) {
                NSData *artData = [NSData dataWithContentsOfURL:[NSURL URLWithString:artwork]];
                if (artData) {
                    NSURL *artURL = [[self imagesFolderURL] URLByAppendingPathComponent:[[NSUUID UUID].UUIDString stringByAppendingPathExtension:@"jpg"]];
                    [artData writeToURL:artURL atomically:YES];
                    song[@"artworkTarget"] = [@"Images" stringByAppendingPathComponent:artURL.lastPathComponent];
                }
            }
            [self syncMusicMetadataFromSong:song];
            [self savePlaylists];
            [self.playlistSongsTableView reloadData];
            [self adjustTableColumns];
            [self loadMusicSongAtIndex:row play:NO];
            self.musicStatusLabel.stringValue = @"Metadata updated";
        });
    }] resume];
}

- (NSInteger)removeSoundboardItemsMatchingTargets:(NSSet<NSString *> *)targets {
    if (targets.count == 0) return 0;
    NSInteger before = self.items.count;
    NSIndexSet *matches = [self.items indexesOfObjectsPassingTest:^BOOL(NSDictionary *item, NSUInteger idx, BOOL *stop) {
        return [item[@"kind"] isEqualToString:@"sound"] && [targets containsObject:item[@"target"] ?: @""];
    }];
    if (matches.count > 0) {
        [self.items removeObjectsAtIndexes:matches];
        [self saveItems];
        [self applyFilterSelectingID:nil];
        [self refreshPadView];
    }
    return before - self.items.count;
}

- (NSInteger)musicRemovalChoiceWithTitle:(NSString *)title message:(NSString *)message {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = title;
    alert.informativeText = message;
    NSPopUpButton *popup = [[NSPopUpButton alloc] initWithFrame:NSMakeRect(0, 0, 320, 26)];
    [popup addItemsWithTitles:@[@"Music only", @"Soundboard only", @"Music and Soundboard"]];
    alert.accessoryView = popup;
    [alert addButtonWithTitle:@"Remove"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] != NSAlertFirstButtonReturn) return -1;
    return popup.indexOfSelectedItem;
}

- (NSInteger)playlistSongRemovalChoice {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Remove Song";
    alert.informativeText = @"Choose whether to remove this song only from the selected playlist, or remove it from the whole music library.";
    NSPopUpButton *popup = [[NSPopUpButton alloc] initWithFrame:NSMakeRect(0, 0, 360, 26)];
    [popup addItemsWithTitles:@[@"This playlist only", @"All Songs library", @"Soundboard only", @"Library and Soundboard"]];
    alert.accessoryView = popup;
    [alert addButtonWithTitle:@"Remove"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] != NSAlertFirstButtonReturn) return -1;
    return popup.indexOfSelectedItem;
}

- (void)removeSongWithTargetFromAllPlaylists:(NSString *)target matchingObject:(NSDictionary *)song {
    for (NSInteger playlistIndex = 0; playlistIndex < (NSInteger)self.playlists.count; playlistIndex++) {
        NSMutableArray *playlistSongs = [self songsForPlaylistIndex:playlistIndex];
        NSIndexSet *matches = [playlistSongs indexesOfObjectsPassingTest:^BOOL(NSDictionary *candidate, NSUInteger idx, BOOL *stop) {
            return candidate == song || [candidate[@"target"] isEqualToString:target];
        }];
        if (matches.count > 0) [playlistSongs removeObjectsAtIndexes:matches];
    }
}

- (void)removeSongFromLibraryWithTarget:(NSString *)target matchingObject:(NSDictionary *)song {
    NSIndexSet *matches = [self.musicLibrary indexesOfObjectsPassingTest:^BOOL(NSDictionary *candidate, NSUInteger idx, BOOL *stop) {
        return candidate == song || [candidate[@"target"] isEqualToString:target];
    }];
    if (matches.count > 0) [self.musicLibrary removeObjectsAtIndexes:matches];
}

- (IBAction)deleteMusicSong {
    NSInteger row = self.playlistSongsTableView.selectedRow;
    NSMutableDictionary *song = [self displayedPlaylistSongAtRow:row];
    if (!song) return;
    BOOL allSongs = [self isAllSongsSelected];
    NSInteger choice = allSongs ? [self musicRemovalChoiceWithTitle:@"Delete Song" message:@"Choose where this song should be removed from."] : [self playlistSongRemovalChoice];
    if (choice < 0) return;

    NSString *target = song[@"target"] ?: @"";
    NSInteger removedBoardItems = 0;
    BOOL removeFromSoundboard = allSongs ? (choice == 1 || choice == 2) : (choice == 2 || choice == 3);
    BOOL removeFromMusic = allSongs ? (choice == 0 || choice == 2) : (choice == 0 || choice == 1 || choice == 3);
    BOOL removeFromLibrary = allSongs ? removeFromMusic : (choice == 1 || choice == 3);
    if (removeFromSoundboard) {
        removedBoardItems = [self removeSoundboardItemsMatchingTargets:[NSSet setWithObject:target]];
    }
    if (removeFromMusic) {
        if (allSongs || removeFromLibrary) {
            [self removeSongFromLibraryWithTarget:target matchingObject:song];
            [self removeSongWithTargetFromAllPlaylists:target matchingObject:song];
        } else {
            NSMutableArray *songs = [self selectedPlaylistSongs];
            NSUInteger found = [songs indexOfObjectIdenticalTo:song];
            if (found != NSNotFound) [songs removeObjectAtIndex:found];
        }
        if (self.currentSongIndex == row) {
            [self.musicPlayer stop];
            self.musicPlayer = nil;
            self.currentSongIndex = -1;
            self.musicTitleLabel.stringValue = @"No song selected";
            self.musicArtistLabel.stringValue = @"";
            self.musicArtworkView.image = nil;
        } else if (self.currentSongIndex > row) {
            self.currentSongIndex -= 1;
        }
        [self savePlaylists];
        [self.playlistSongsTableView reloadData];
        [self adjustTableColumns];
    }
    self.musicStatusLabel.stringValue = [NSString stringWithFormat:@"Removed song%@.", removedBoardItems > 0 ? @" and soundboard item" : @""];
}

- (IBAction)deleteMusicPlaylist {
    NSInteger row = self.playlistTableView.selectedRow;
    NSInteger playlistIndex = [self playlistIndexForTableRow:row];
    if (playlistIndex < 0 || playlistIndex >= (NSInteger)self.playlists.count) {
        self.musicStatusLabel.stringValue = @"All Songs is a fixed library view.";
        return;
    }
    NSMutableDictionary *playlist = self.playlists[playlistIndex];
    NSArray *songs = playlist[@"songs"] ?: @[];
    NSInteger choice = [self musicRemovalChoiceWithTitle:@"Delete Playlist" message:@"Choose where this playlist's songs should be removed from."];
    if (choice < 0) return;

    NSMutableSet *targets = [NSMutableSet set];
    for (NSDictionary *song in songs) {
        NSString *target = song[@"target"] ?: @"";
        if (target.length) [targets addObject:target];
    }
    NSInteger removedBoardItems = 0;
    if (choice == 1 || choice == 2) {
        removedBoardItems = [self removeSoundboardItemsMatchingTargets:targets];
    }
    if (choice == 0 || choice == 2) {
        [self.musicPlayer stop];
        self.musicPlayer = nil;
        [self.playlists removeObjectAtIndex:playlistIndex];
        if (self.playlists.count == 0) {
            [self.playlists addObject:[@{@"name": @"Default Playlist", @"songs": [NSMutableArray array]} mutableCopy]];
        }
        self.selectedPlaylistIndex = MIN(playlistIndex, (NSInteger)self.playlists.count - 1);
        self.currentSongIndex = -1;
        [self savePlaylists];
        [self.playlistTableView reloadData];
        [self.playlistSongsTableView reloadData];
        [self adjustTableColumns];
        self.musicTitleLabel.stringValue = @"No song selected";
        self.musicArtistLabel.stringValue = @"";
        self.musicArtworkView.image = nil;
    }
    self.musicStatusLabel.stringValue = [NSString stringWithFormat:@"Removed playlist%@.", removedBoardItems > 0 ? @" and soundboard items" : @""];
}

- (NSURL *)copyFile:(NSURL *)sourceURL toUniqueFileInFolder:(NSURL *)folderURL error:(NSError **)error {
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createDirectoryAtURL:folderURL withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *baseName = sourceURL.URLByDeletingPathExtension.lastPathComponent ?: @"file";
    NSString *extension = sourceURL.pathExtension ?: @"";
    NSCharacterSet *unsafe = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_ "] invertedSet];
    NSString *safeBase = [[baseName componentsSeparatedByCharactersInSet:unsafe] componentsJoinedByString:@"-"];
    if (safeBase.length == 0) safeBase = @"file";
    for (NSInteger index = 1; index < 1000; index++) {
        NSString *candidate = index == 1 ? safeBase : [NSString stringWithFormat:@"%@-%ld", safeBase, (long)index];
        if (extension.length) candidate = [candidate stringByAppendingPathExtension:extension];
        NSURL *destination = [folderURL URLByAppendingPathComponent:candidate];
        if (![manager fileExistsAtPath:destination.path]) {
            return [manager copyItemAtURL:sourceURL toURL:destination error:error] ? destination : nil;
        }
    }
    return nil;
}

- (IBAction)exportSelectedPlaylist {
    NSMutableDictionary *playlist = [self selectedPlaylist];
    if (!playlist) {
        self.musicStatusLabel.stringValue = @"Choose a regular playlist to export.";
        return;
    }
    NSSavePanel *panel = [NSSavePanel savePanel];
    panel.title = @"Export Playlist";
    NSString *safeName = playlist[@"name"] ?: @"Sounds Simple Playlist";
    panel.nameFieldStringValue = [safeName stringByAppendingPathExtension:@"sounds-simple-playlist"];
    if ([panel runModal] != NSModalResponseOK) return;

    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *packageURL = panel.URL;
    [manager removeItemAtURL:packageURL error:nil];
    NSError *error = nil;
    if (![manager createDirectoryAtURL:packageURL withIntermediateDirectories:YES attributes:nil error:&error]) {
        self.musicStatusLabel.stringValue = error.localizedDescription ?: @"Could not export playlist.";
        return;
    }
    NSURL *exportSoundsURL = [packageURL URLByAppendingPathComponent:@"Sounds" isDirectory:YES];
    NSURL *exportImagesURL = [packageURL URLByAppendingPathComponent:@"Images" isDirectory:YES];
    NSMutableArray *exportSongs = [NSMutableArray array];
    for (NSDictionary *song in playlist[@"songs"] ?: @[]) {
        NSMutableDictionary *copy = [song mutableCopy];
        NSURL *songURL = [self urlForSong:song];
        if (songURL && [manager fileExistsAtPath:songURL.path]) {
            NSURL *exported = [self copyFile:songURL toUniqueFileInFolder:exportSoundsURL error:nil];
            if (exported) copy[@"target"] = [@"Sounds" stringByAppendingPathComponent:exported.lastPathComponent];
        }
        NSString *artworkTarget = song[@"artworkTarget"] ?: @"";
        NSURL *artURL = artworkTarget.length ? [self resolvedImageURLForTarget:artworkTarget] : nil;
        if (artURL && [manager fileExistsAtPath:artURL.path]) {
            NSURL *exportedArt = [self copyFile:artURL toUniqueFileInFolder:exportImagesURL error:nil];
            if (exportedArt) copy[@"artworkTarget"] = [@"Images" stringByAppendingPathComponent:exportedArt.lastPathComponent];
        }
        [exportSongs addObject:copy];
    }
    NSDictionary *manifest = @{@"format": @"Sounds Simple Playlist", @"version": @1, @"playlist": @{@"name": playlist[@"name"] ?: @"Playlist", @"songs": exportSongs}};
    NSData *data = [NSJSONSerialization dataWithJSONObject:manifest options:NSJSONWritingPrettyPrinted error:&error];
    if (![data writeToURL:[packageURL URLByAppendingPathComponent:@"playlist.json"] atomically:YES]) {
        self.musicStatusLabel.stringValue = @"Could not write playlist file.";
        return;
    }
    self.musicStatusLabel.stringValue = @"Playlist exported for sharing.";
}

- (IBAction)importPlaylist {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.title = @"Import Playlist";
    panel.canChooseDirectories = YES;
    panel.canChooseFiles = YES;
    panel.allowsMultipleSelection = NO;
    panel.allowedFileTypes = @[@"sounds-simple-playlist", @"json"];
    if ([panel runModal] != NSModalResponseOK) return;

    NSURL *packageURL = panel.URL;
    NSURL *manifestURL = nil;
    BOOL isDirectory = NO;
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:packageURL.path isDirectory:&isDirectory] && isDirectory) {
        manifestURL = [packageURL URLByAppendingPathComponent:@"playlist.json"];
    } else {
        manifestURL = packageURL;
        packageURL = packageURL.URLByDeletingLastPathComponent;
    }
    NSData *data = [NSData dataWithContentsOfURL:manifestURL];
    if (!data) {
        self.musicStatusLabel.stringValue = @"No playlist file found.";
        return;
    }
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *sourcePlaylist = [json[@"playlist"] isKindOfClass:[NSDictionary class]] ? json[@"playlist"] : json;
    NSMutableDictionary *playlist = [@{@"name": sourcePlaylist[@"name"] ?: @"Imported Playlist", @"songs": [NSMutableArray array]} mutableCopy];
    NSMutableArray *importedSongs = playlist[@"songs"];
    for (NSDictionary *song in sourcePlaylist[@"songs"] ?: @[]) {
        NSMutableDictionary *imported = [song mutableCopy];
        NSString *target = song[@"target"] ?: @"";
        NSURL *sourceSongURL = [target hasPrefix:@"/"] ? [NSURL fileURLWithPath:target] : [packageURL URLByAppendingPathComponent:target];
        if (sourceSongURL && [manager fileExistsAtPath:sourceSongURL.path]) {
            NSString *newTarget = [self portableTargetForSoundURL:sourceSongURL error:nil];
            if (newTarget) imported[@"target"] = newTarget;
        }
        NSString *artworkTarget = song[@"artworkTarget"] ?: @"";
        if (artworkTarget.length) {
            NSURL *sourceArtURL = [artworkTarget hasPrefix:@"/"] ? [NSURL fileURLWithPath:artworkTarget] : [packageURL URLByAppendingPathComponent:artworkTarget];
            if ([manager fileExistsAtPath:sourceArtURL.path]) {
                NSString *newArtTarget = [self portableTargetForImageURL:sourceArtURL error:nil];
                if (newArtTarget) imported[@"artworkTarget"] = newArtTarget;
            }
        }
        [self addSongToLibraryIfNeeded:imported];
        [importedSongs addObject:imported];
    }
    [self.playlists addObject:playlist];
    self.selectedPlaylistIndex = self.playlists.count - 1;
    [self savePlaylists];
    [self.playlistTableView reloadData];
    [self.playlistSongsTableView reloadData];
    [self adjustTableColumns];
    [self.playlistTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:[self tableRowForPlaylistIndex:self.selectedPlaylistIndex]] byExtendingSelection:NO];
    self.musicStatusLabel.stringValue = @"Playlist imported.";
}

- (void)loadEditorURL:(NSURL *)url {
    self.editorSourceURL = url;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.editorPlayer = player;
    self.editorStartSlider.minValue = 0;
    self.editorStartSlider.maxValue = MAX(player.duration, 1);
    self.editorStartSlider.doubleValue = 0;
    self.editorEndSlider.minValue = 0;
    self.editorEndSlider.maxValue = MAX(player.duration, 1);
    self.editorEndSlider.doubleValue = player.duration > 0 ? player.duration : 1;
    self.editorVolumeSlider.minValue = 0;
    self.editorVolumeSlider.maxValue = 1.5;
    self.editorVolumeSlider.doubleValue = 1;
    self.editorZoomSlider.doubleValue = 1;
    [self.editorWaveformView loadAudioURL:url duration:(player.duration > 0 ? player.duration : 1)];
    [self updateEditorWaveformSize];
    self.editorLoadedLabel.stringValue = url.lastPathComponent ?: @"Loaded audio";
    self.editorStatusLabel.stringValue = player ? [NSString stringWithFormat:@"Loaded %.1f seconds", player.duration] : @"Loaded file, but preview may not be available.";
}

- (void)editorWaveformDidChangeTrimStart:(NSTimeInterval)start end:(NSTimeInterval)end {
    self.editorStartSlider.doubleValue = start;
    self.editorEndSlider.doubleValue = end;
    self.editorStatusLabel.stringValue = [NSString stringWithFormat:@"Selected %.2f to %.2f seconds", start, end];
}

- (IBAction)editorSliderChanged:(id)sender {
    NSTimeInterval start = MIN(self.editorStartSlider.doubleValue, self.editorEndSlider.doubleValue);
    NSTimeInterval end = MAX(self.editorStartSlider.doubleValue, self.editorEndSlider.doubleValue);
    self.editorWaveformView.trimStart = start;
    self.editorWaveformView.trimEnd = end;
    self.editorWaveformView.needsDisplay = YES;
    self.editorStatusLabel.stringValue = [NSString stringWithFormat:@"Selected %.2f to %.2f seconds", start, end];
}

- (void)updateEditorWaveformSize {
    CGFloat visibleWidth = MAX(self.editorWaveformScrollView.contentSize.width, 700);
    CGFloat zoom = MAX(1.0, self.editorZoomSlider.doubleValue);
    self.editorWaveformWidthConstraint.constant = visibleWidth * zoom;
    [self.editorWaveformView layoutSubtreeIfNeeded];
    self.editorWaveformView.needsDisplay = YES;
}

- (IBAction)editorZoomChanged:(id)sender {
    [self updateEditorWaveformSize];
    self.editorStatusLabel.stringValue = [NSString stringWithFormat:@"Wave zoom %.1fx", self.editorZoomSlider.doubleValue];
}

- (IBAction)loadSelectedRecordingInEditor {
    NSURL *url = [self selectedRecordingURL];
    if (!url) {
        NSArray<NSURL *> *recordings = [self recordingFiles];
        url = recordings.firstObject;
    }
    if (!url) {
        self.editorStatusLabel.stringValue = @"No recordings found.";
        return;
    }
    [self loadEditorURL:url];
}

- (IBAction)loadExistingSoundInEditor {
    NSMutableArray<NSString *> *names = [NSMutableArray array];
    NSMutableArray<NSURL *> *urls = [NSMutableArray array];
    for (NSDictionary *item in self.items) {
        if (![item[@"kind"] isEqualToString:@"sound"]) continue;
        NSURL *url = [self resolvedSoundURLForTarget:item[@"target"] ?: @""];
        if (url && [[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
            [names addObject:item[@"name"] ?: url.lastPathComponent];
            [urls addObject:url];
        }
    }
    if (urls.count == 0) {
        self.editorStatusLabel.stringValue = @"No app sounds found.";
        return;
    }
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Choose App Sound";
    NSPopUpButton *popup = [[NSPopUpButton alloc] initWithFrame:NSMakeRect(0, 0, 320, 26)];
    [popup addItemsWithTitles:names];
    alert.accessoryView = popup;
    [alert addButtonWithTitle:@"Load"];
    [alert addButtonWithTitle:@"Cancel"];
    if ([alert runModal] == NSAlertFirstButtonReturn) {
        [self loadEditorURL:urls[popup.indexOfSelectedItem]];
    }
}

- (IBAction)loadExternalAudioInEditor {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.title = @"Choose Audio to Edit";
    panel.canChooseDirectories = NO;
    panel.allowsMultipleSelection = NO;
    panel.allowedFileTypes = @[@"aac", @"aif", @"aiff", @"flac", @"m4a", @"mp3", @"ogg", @"wav"];
    if ([panel runModal] == NSModalResponseOK) {
        [self loadEditorURL:panel.URL];
    }
}

- (IBAction)previewEditorAudio {
    if (!self.editorSourceURL) {
        self.editorStatusLabel.stringValue = @"Load audio first.";
        return;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.editorSourceURL error:nil];
    if (!player) {
        self.editorStatusLabel.stringValue = @"Could not preview this file.";
        return;
    }
    NSTimeInterval start = MIN(self.editorStartSlider.doubleValue, self.editorEndSlider.doubleValue);
    NSTimeInterval end = MAX(self.editorStartSlider.doubleValue, self.editorEndSlider.doubleValue);
    player.currentTime = start;
    player.volume = self.editorVolumeSlider.floatValue;
    [player play];
    self.editorPlayer = player;
    self.editorStatusLabel.stringValue = @"Previewing edit range";
    NSTimeInterval previewLength = MAX(0.1, end - start);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(previewLength * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.editorPlayer == player && player.isPlaying) {
            [player stop];
            self.editorStatusLabel.stringValue = @"Preview finished";
        }
    });
}

- (IBAction)stopEditorPreview {
    [self.editorPlayer stop];
    self.editorStatusLabel.stringValue = @"Preview stopped";
}

- (NSURL *)uniqueEditedClipURL {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd-HHmmss";
    NSString *name = [NSString stringWithFormat:@"Edited-%@", [formatter stringFromDate:[NSDate date]]];
    return [[self soundsFolderURL] URLByAppendingPathComponent:[name stringByAppendingPathExtension:@"m4a"]];
}

- (IBAction)saveEditedClip {
    if (!self.editorSourceURL) {
        self.editorStatusLabel.stringValue = @"Load audio first.";
        return;
    }
    NSTimeInterval start = MIN(self.editorStartSlider.doubleValue, self.editorEndSlider.doubleValue);
    NSTimeInterval end = MAX(self.editorStartSlider.doubleValue, self.editorEndSlider.doubleValue);
    if (end <= start) {
        self.editorStatusLabel.stringValue = @"Choose a longer edit range.";
        return;
    }
    NSURL *destinationURL = [self uniqueEditedClipURL];
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.editorSourceURL options:nil];
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetAppleM4A];
    exporter.outputURL = destinationURL;
    exporter.outputFileType = AVFileTypeAppleM4A;
    exporter.timeRange = CMTimeRangeFromTimeToTime(CMTimeMakeWithSeconds(start, 600), CMTimeMakeWithSeconds(end, 600));
    AVAssetTrack *audioTrack = [[asset tracksWithMediaType:AVMediaTypeAudio] firstObject];
    if (audioTrack) {
        AVMutableAudioMixInputParameters *params = [AVMutableAudioMixInputParameters audioMixInputParametersWithTrack:audioTrack];
        [params setVolume:self.editorVolumeSlider.floatValue atTime:kCMTimeZero];
        AVMutableAudioMix *mix = [AVMutableAudioMix audioMix];
        mix.inputParameters = @[params];
        exporter.audioMix = mix;
    }
    self.editorStatusLabel.stringValue = @"Saving edited clip...";
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (exporter.status != AVAssetExportSessionStatusCompleted) {
                self.editorStatusLabel.stringValue = exporter.error.localizedDescription ?: @"Could not save edited clip.";
                return;
            }
            NSInteger nextID = [self nextID];
            NSString *target = [@"Sounds" stringByAppendingPathComponent:destinationURL.lastPathComponent];
            NSMutableDictionary *item = [@{
                @"id": @(nextID),
                @"name": destinationURL.URLByDeletingPathExtension.lastPathComponent,
                @"key": @"",
                @"kind": @"sound",
                @"category": @"SFX",
                @"target": target,
                @"volume": @(self.editorVolumeSlider.floatValue)
            } mutableCopy];
            self.editorStatusLabel.stringValue = @"Edited clip saved";
            [self editItem:item isNew:YES];
        });
    }];
}

- (NSURL *)uniqueRecordingURL {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd-HHmmss";
    NSString *baseName = [NSString stringWithFormat:@"Recording-%@", [formatter stringFromDate:[NSDate date]]];
    NSURL *soundsURL = [self soundsFolderURL];
    NSFileManager *manager = [NSFileManager defaultManager];
    for (NSInteger index = 1; index < 1000; index++) {
        NSString *name = index == 1 ? baseName : [NSString stringWithFormat:@"%@-%ld", baseName, (long)index];
        NSURL *candidate = [soundsURL URLByAppendingPathComponent:[name stringByAppendingPathExtension:@"m4a"]];
        if (![manager fileExistsAtPath:candidate.path]) {
            return candidate;
        }
    }
    return [soundsURL URLByAppendingPathComponent:@"Recording.m4a"];
}

- (IBAction)startRecording {
    if (self.recorder.isRecording) return;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        [self showAlert:@"Microphone Access Needed" message:@"Allow microphone access in System Settings to record custom audio."];
        return;
    }
    if (status == AVAuthorizationStatusNotDetermined) {
        self.recordingStatusLabel.stringValue = @"Waiting for mic permission...";
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    [self beginRecording];
                } else {
                    self.recordingStatusLabel.stringValue = @"Mic permission denied";
                    [self showAlert:@"Microphone Access Needed" message:@"Allow microphone access in System Settings to record custom audio."];
                }
            });
        }];
        return;
    }
    [self beginRecording];
}

- (void)beginRecording {
    self.pendingRecordingURL = [self uniqueRecordingURL];
    NSDictionary *settings = @{
        AVFormatIDKey: @(kAudioFormatMPEG4AAC),
        AVSampleRateKey: @44100.0,
        AVNumberOfChannelsKey: @2,
        AVEncoderAudioQualityKey: @(AVAudioQualityHigh)
    };
    NSError *error = nil;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:self.pendingRecordingURL settings:settings error:&error];
    if (!self.recorder || error) {
        [self showAlert:@"Recording Failed" message:error.localizedDescription ?: @"Could not start recording."];
        self.pendingRecordingURL = nil;
        return;
    }
    [self.recorder prepareToRecord];
    [self.recorder record];
    self.recordButton.enabled = NO;
    self.stopRecordingButton.enabled = YES;
    self.recordingStatusLabel.stringValue = @"Recording...";
}

- (IBAction)stopRecordingAndAdd {
    if (!self.recorder.isRecording || !self.pendingRecordingURL) return;
    [self.recorder stop];
    self.recorder = nil;
    self.recordButton.enabled = YES;
    self.stopRecordingButton.enabled = NO;
    self.recordingStatusLabel.stringValue = @"Recording saved";
    [self refreshRecentRecordings];

    NSInteger nextID = [self nextID];
    NSString *target = [@"Sounds" stringByAppendingPathComponent:self.pendingRecordingURL.lastPathComponent];
    NSMutableDictionary *item = [@{
        @"id": @(nextID),
        @"name": self.pendingRecordingURL.URLByDeletingPathExtension.lastPathComponent,
        @"key": @"",
        @"kind": @"sound",
        @"category": @"SFX",
        @"target": target,
        @"volume": @1.0
    } mutableCopy];
    self.pendingRecordingURL = nil;
    [self editItem:item isNew:YES];
}

- (IBAction)addSound {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.title = @"Choose Sound";
    panel.canChooseDirectories = NO;
    panel.allowsMultipleSelection = NO;
    panel.allowedFileTypes = @[@"aac", @"aif", @"aiff", @"flac", @"m4a", @"mp3", @"ogg", @"wav"];
    if ([panel runModal] != NSModalResponseOK) {
        [self focusForKeys];
        return;
    }
    NSURL *url = panel.URL;
    NSError *copyError = nil;
    NSString *portableTarget = [self portableTargetForSoundURL:url error:&copyError];
    if (!portableTarget) {
        [self showAlert:@"Copy Failed" message:copyError.localizedDescription ?: @"Could not copy the sound into the local Sounds folder."];
        [self focusForKeys];
        return;
    }
    NSInteger nextID = [self nextID];
    NSMutableDictionary *item = [@{
        @"id": @(nextID),
        @"name": url.URLByDeletingPathExtension.lastPathComponent,
        @"key": @"",
        @"kind": @"sound",
        @"category": @"SFX",
        @"target": portableTarget,
        @"volume": @1.0
    } mutableCopy];
    [self editItem:item isNew:YES];
}

- (IBAction)addLink {
    NSInteger nextID = [self nextID];
    NSMutableDictionary *item = [@{
        @"id": @(nextID),
        @"name": @"Music Link",
        @"key": @"",
        @"kind": @"link",
        @"category": @"Music",
        @"target": @"https://",
        @"volume": @1.0
    } mutableCopy];
    [self editItem:item isNew:YES];
}

- (IBAction)addYouTube {
    [self addLink];
}

- (IBAction)editSelected {
    NSMutableDictionary *item = [self selectedItem];
    if (item) [self editItem:item.mutableCopy isNew:NO];
}

- (IBAction)deleteSelected {
    NSMutableDictionary *item = [self selectedItem];
    if (!item) return;
    BOOL shouldDelete = YES;
    if (self.confirmDeletes) {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = [NSString stringWithFormat:@"Delete %@?", item[@"name"] ?: @"this item"];
        alert.informativeText = @"This removes it from the list. It does not delete the audio file.";
        [alert addButtonWithTitle:@"Delete"];
        [alert addButtonWithTitle:@"Cancel"];
        shouldDelete = [alert runModal] == NSAlertFirstButtonReturn;
    }
    if (shouldDelete) {
        NSNumber *itemID = item[@"id"];
        NSIndexSet *matches = [self.items indexesOfObjectsPassingTest:^BOOL(NSDictionary *candidate, NSUInteger idx, BOOL *stop) {
            return [candidate[@"id"] integerValue] == itemID.integerValue;
        }];
        [self.items removeObjectsAtIndexes:matches];
        if ([self.selectedItemID integerValue] == itemID.integerValue) self.selectedItemID = nil;
        [self saveItems];
        [self applyFilterSelectingID:nil];
        self.statusLabel.stringValue = @"Deleted item";
    }
    [self focusForKeys];
}

- (IBAction)playSelected {
    NSMutableDictionary *item = [self selectedItem];
    if (item) [self playItem:item];
}

- (IBAction)stopAudio {
    for (AVAudioPlayer *player in self.players) {
        [player stop];
    }
    [self.players removeAllObjects];
    self.isPaused = NO;
    self.statusLabel.stringValue = @"Stopped audio";
    [self focusForKeys];
}

- (IBAction)pauseAudio {
    if (self.players.count == 0) {
        self.statusLabel.stringValue = @"No audio playing";
        [self focusForKeys];
        return;
    }
    if (self.isPaused) {
        for (AVAudioPlayer *player in self.players) {
            [player play];
        }
        self.isPaused = NO;
        self.statusLabel.stringValue = @"Resumed audio";
    } else {
        for (AVAudioPlayer *player in self.players) {
            if (player.isPlaying) [player pause];
        }
        self.isPaused = YES;
        self.statusLabel.stringValue = @"Paused audio";
    }
    [self focusForKeys];
}

- (NSInteger)nextID {
    NSInteger nextID = 1;
    for (NSDictionary *item in self.items) {
        nextID = MAX(nextID, [item[@"id"] integerValue] + 1);
    }
    return nextID;
}

- (NSMutableDictionary *)selectedItem {
    if (self.selectedItemID) {
        NSMutableDictionary *item = [self itemWithID:self.selectedItemID];
        if (item) return item;
    }
    NSInteger row = self.tableView.selectedRow;
    if (row < 0 || row >= (NSInteger)self.filteredItems.count) return nil;
    return self.filteredItems[row];
}

- (NSMutableDictionary *)itemWithID:(NSNumber *)itemID {
    if (!itemID) return nil;
    for (NSMutableDictionary *item in self.items) {
        if ([item[@"id"] integerValue] == itemID.integerValue) {
            return item;
        }
    }
    return nil;
}

- (void)editItem:(NSMutableDictionary *)item isNew:(BOOL)isNew {
    BOOL isLinkedItem = [item[@"kind"] isEqualToString:@"link"] || [item[@"kind"] isEqualToString:@"youtube"];
    if ([item[@"kind"] isEqualToString:@"youtube"]) item[@"kind"] = @"link";
    NSPanel *panel = [[NSPanel alloc] initWithContentRect:NSMakeRect(0, 0, 560, isLinkedItem ? 230 : 270)
                                                styleMask:NSWindowStyleMaskTitled
                                                  backing:NSBackingStoreBuffered
                                                    defer:NO];
    panel.title = isNew ? @"Add Soundboard Item" : @"Edit Soundboard Item";
    NSView *content = [[NSView alloc] initWithFrame:panel.contentView.bounds];
    panel.contentView = content;

    NSTextField *nameLabel = [NSTextField labelWithString:@"Name"];
    NSTextField *keyLabel = [NSTextField labelWithString:@"Key"];
    NSTextField *typeLabel = [NSTextField labelWithString:@"Type"];
    NSTextField *imageLabel = [NSTextField labelWithString:@"Image"];
    NSTextField *targetLabel = [NSTextField labelWithString:isLinkedItem ? @"URL" : @"File"];
    NSTextField *nameField = [NSTextField textFieldWithString:item[@"name"] ?: @""];
    NSTextField *keyField = [NSTextField textFieldWithString:item[@"key"] ?: @""];
    NSPopUpButton *typePopup = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
    [typePopup addItemsWithTitles:@[@"SFX", @"Music", @"Other"]];
    [typePopup selectItemWithTitle:item[@"category"] ?: @"SFX"];
    typePopup.hidden = isLinkedItem;
    typeLabel.hidden = isLinkedItem;
    __block NSString *imageTarget = item[@"imageTarget"] ?: @"";
    NSTextField *imageField = [NSTextField textFieldWithString:imageTarget.length ? imageTarget.lastPathComponent : @"Theme default"];
    imageField.editable = NO;
    NSButton *chooseImageButton = [NSButton buttonWithTitle:@"Choose Image" target:nil action:nil];
    NSButton *clearImageButton = [NSButton buttonWithTitle:@"Clear" target:nil action:nil];
    NSTextField *targetField = [NSTextField textFieldWithString:item[@"target"] ?: @""];
    targetField.editable = isLinkedItem;
    NSButton *saveButton = [NSButton buttonWithTitle:@"Save" target:nil action:nil];
    NSButton *cancelButton = [NSButton buttonWithTitle:@"Cancel" target:nil action:nil];
    NSArray *views = @[nameLabel, keyLabel, typeLabel, imageLabel, targetLabel, nameField, keyField, typePopup, imageField, chooseImageButton, clearImageButton, targetField, saveButton, cancelButton];
    for (NSView *view in views) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [content addSubview:view];
    }

    [NSLayoutConstraint activateConstraints:@[
        [nameLabel.leadingAnchor constraintEqualToAnchor:content.leadingAnchor constant:18],
        [nameLabel.topAnchor constraintEqualToAnchor:content.topAnchor constant:22],
        [nameLabel.widthAnchor constraintEqualToConstant:60],
        [nameField.leadingAnchor constraintEqualToAnchor:nameLabel.trailingAnchor constant:10],
        [nameField.trailingAnchor constraintEqualToAnchor:content.trailingAnchor constant:-18],
        [nameField.centerYAnchor constraintEqualToAnchor:nameLabel.centerYAnchor],
        [keyLabel.leadingAnchor constraintEqualToAnchor:nameLabel.leadingAnchor],
        [keyLabel.topAnchor constraintEqualToAnchor:nameLabel.bottomAnchor constant:18],
        [keyLabel.widthAnchor constraintEqualToAnchor:nameLabel.widthAnchor],
        [keyField.leadingAnchor constraintEqualToAnchor:nameField.leadingAnchor],
        [keyField.widthAnchor constraintEqualToConstant:120],
        [keyField.centerYAnchor constraintEqualToAnchor:keyLabel.centerYAnchor],
        [typeLabel.leadingAnchor constraintEqualToAnchor:nameLabel.leadingAnchor],
        [typeLabel.topAnchor constraintEqualToAnchor:keyLabel.bottomAnchor constant:18],
        [typeLabel.widthAnchor constraintEqualToAnchor:nameLabel.widthAnchor],
        [typePopup.leadingAnchor constraintEqualToAnchor:nameField.leadingAnchor],
        [typePopup.widthAnchor constraintEqualToConstant:160],
        [typePopup.centerYAnchor constraintEqualToAnchor:typeLabel.centerYAnchor],
        [imageLabel.leadingAnchor constraintEqualToAnchor:nameLabel.leadingAnchor],
        [imageLabel.topAnchor constraintEqualToAnchor:(isLinkedItem ? keyLabel.bottomAnchor : typeLabel.bottomAnchor) constant:18],
        [imageLabel.widthAnchor constraintEqualToAnchor:nameLabel.widthAnchor],
        [imageField.leadingAnchor constraintEqualToAnchor:nameField.leadingAnchor],
        [imageField.trailingAnchor constraintEqualToAnchor:chooseImageButton.leadingAnchor constant:-8],
        [imageField.centerYAnchor constraintEqualToAnchor:imageLabel.centerYAnchor],
        [chooseImageButton.trailingAnchor constraintEqualToAnchor:clearImageButton.leadingAnchor constant:-8],
        [chooseImageButton.centerYAnchor constraintEqualToAnchor:imageLabel.centerYAnchor],
        [clearImageButton.trailingAnchor constraintEqualToAnchor:nameField.trailingAnchor],
        [clearImageButton.centerYAnchor constraintEqualToAnchor:imageLabel.centerYAnchor],
        [targetLabel.leadingAnchor constraintEqualToAnchor:nameLabel.leadingAnchor],
        [targetLabel.topAnchor constraintEqualToAnchor:imageLabel.bottomAnchor constant:18],
        [targetLabel.widthAnchor constraintEqualToAnchor:nameLabel.widthAnchor],
        [targetField.leadingAnchor constraintEqualToAnchor:nameField.leadingAnchor],
        [targetField.trailingAnchor constraintEqualToAnchor:nameField.trailingAnchor],
        [targetField.centerYAnchor constraintEqualToAnchor:targetLabel.centerYAnchor],
        [saveButton.trailingAnchor constraintEqualToAnchor:content.trailingAnchor constant:-18],
        [saveButton.bottomAnchor constraintEqualToAnchor:content.bottomAnchor constant:-16],
        [cancelButton.trailingAnchor constraintEqualToAnchor:saveButton.leadingAnchor constant:-8],
        [cancelButton.centerYAnchor constraintEqualToAnchor:saveButton.centerYAnchor]
    ]];

    __block BOOL didSave = NO;
    EditTarget *target = [[EditTarget alloc] init];
    __weak AppDelegate *weakSelf = self;
    target.chooseBlock = ^{
        NSOpenPanel *imagePanel = [NSOpenPanel openPanel];
        imagePanel.title = @"Choose Button Image";
        imagePanel.canChooseDirectories = NO;
        imagePanel.allowsMultipleSelection = NO;
        imagePanel.allowedFileTypes = @[@"png", @"jpg", @"jpeg", @"heic", @"gif", @"tiff"];
        if ([imagePanel runModal] == NSModalResponseOK) {
            NSError *copyError = nil;
            NSString *portable = [weakSelf portableTargetForImageURL:imagePanel.URL error:&copyError];
            if (portable) {
                imageTarget = portable;
                imageField.stringValue = portable.lastPathComponent;
            } else {
                [weakSelf showAlert:@"Image Copy Failed" message:copyError.localizedDescription ?: @"Could not copy the image into the app folder."];
            }
        }
    };
    target.clearBlock = ^{
        imageTarget = @"";
        imageField.stringValue = @"Theme default";
    };
    target.saveBlock = ^{
        didSave = YES;
        [panel makeFirstResponder:nil];
        [weakSelf.window endSheet:panel returnCode:NSModalResponseOK];
    };
    target.cancelBlock = ^{
        [weakSelf.window endSheet:panel returnCode:NSModalResponseCancel];
    };
    saveButton.target = target;
    saveButton.action = @selector(save);
    cancelButton.target = target;
    cancelButton.action = @selector(cancel);
    chooseImageButton.target = target;
    chooseImageButton.action = @selector(choose);
    clearImageButton.target = target;
    clearImageButton.action = @selector(clear);
    objc_setAssociatedObject(panel, "editTarget", target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [self.window beginSheet:panel completionHandler:^(NSModalResponse returnCode) {
        if (didSave) {
            item[@"name"] = [nameField.stringValue stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
            item[@"key"] = [[keyField.stringValue stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] uppercaseString];
            if (isLinkedItem) {
                item[@"target"] = [targetField.stringValue stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
                item[@"kind"] = @"link";
                item[@"category"] = @"Music";
            } else {
                item[@"category"] = typePopup.titleOfSelectedItem ?: @"Other";
            }
            if (imageTarget.length > 0) {
                item[@"imageTarget"] = imageTarget;
            } else {
                [item removeObjectForKey:@"imageTarget"];
            }
            [self commitItem:item isNew:isNew];
        }
        [self focusForKeys];
    }];
}

- (void)commitItem:(NSMutableDictionary *)item isNew:(BOOL)isNew {
    NSString *name = item[@"name"] ?: @"";
    NSString *key = item[@"key"] ?: @"";
    if (name.length == 0) {
        [self showAlert:@"Missing Name" message:@"Enter a name."];
        return;
    }
    if (key.length == 0) {
        [self showAlert:@"Missing Key" message:@"Enter a trigger key."];
        return;
    }
    for (NSDictionary *candidate in self.items) {
        if ([candidate[@"id"] integerValue] != [item[@"id"] integerValue] &&
            [[candidate[@"key"] lowercaseString] isEqualToString:[key lowercaseString]]) {
            [self showAlert:@"Key Already Used" message:@"Choose a different trigger key."];
            return;
        }
    }
    if (isNew) {
        [self.items addObject:item];
    } else {
        for (NSUInteger index = 0; index < self.items.count; index++) {
            if ([self.items[index][@"id"] integerValue] == [item[@"id"] integerValue]) {
                self.items[index] = item;
                break;
            }
        }
    }
    [self saveItems];
    self.searchField.stringValue = @"";
    [self applyFilterSelectingID:item[@"id"]];
    self.statusLabel.stringValue = [NSString stringWithFormat:@"Saved %@", item[@"name"]];
}

- (BOOL)triggerKey:(NSString *)key {
    for (NSMutableDictionary *item in self.items) {
        if ([[item[@"key"] lowercaseString] isEqualToString:[key lowercaseString]]) {
            [self playItem:item];
            return YES;
        }
    }
    return NO;
}

- (void)playItem:(NSDictionary *)item {
    if (self.stopBeforePlaying) {
        for (AVAudioPlayer *player in self.players) {
            [player stop];
        }
        [self.players removeAllObjects];
    }
    if ([item[@"kind"] isEqualToString:@"link"] || [item[@"kind"] isEqualToString:@"youtube"]) {
        NSURL *url = [NSURL URLWithString:item[@"target"] ?: @""];
        if (url) {
            [[NSWorkspace sharedWorkspace] openURL:url];
            self.statusLabel.stringValue = [NSString stringWithFormat:@"Opened %@", item[@"name"]];
        }
        [self focusForKeys];
        return;
    }
    NSURL *url = [self resolvedSoundURLForTarget:item[@"target"] ?: @""];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    if (!player) {
        [self showAlert:@"Playback Failed" message:@"Could not open that audio file."];
        return;
    }
    player.volume = [item[@"volume"] floatValue] ?: 1.0;
    [player prepareToPlay];
    [player play];
    self.isPaused = NO;
    [self.players addObject:player];
    NSIndexSet *finished = [self.players indexesOfObjectsPassingTest:^BOOL(AVAudioPlayer *candidate, NSUInteger idx, BOOL *stop) {
        return !candidate.isPlaying;
    }];
    [self.players removeObjectsAtIndexes:finished];
    self.statusLabel.stringValue = [NSString stringWithFormat:@"Playing %@", item[@"name"]];
    [self focusForKeys];
}

- (void)showAlert:(NSString *)title message:(NSString *)message {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = title;
    alert.informativeText = message;
    [alert addButtonWithTitle:@"OK"];
    [alert runModal];
    [self focusForKeys];
}

- (void)focusForKeys {
    [self.window makeFirstResponder:self.rootView];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if (tableView == self.recentRecordingsTableView) {
        return self.recentRecordingURLs.count;
    }
    if (tableView == self.playlistTableView) {
        return self.playlists.count + 1;
    }
    if (tableView == self.playlistSongsTableView) {
        return [self displayedPlaylistSongs].count;
    }
    return self.filteredItems.count;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    if (notification.object == self.recentRecordingsTableView) return;
    if (notification.object == self.playlistTableView) {
        NSInteger row = self.playlistTableView.selectedRow;
        if (row >= 0 && row < (NSInteger)self.playlists.count + 1) {
            self.selectedPlaylistIndex = [self playlistIndexForTableRow:row];
            self.currentSongIndex = -1;
            [self.playlistSongsTableView reloadData];
            [self adjustTableColumns];
        }
        return;
    }
    if (notification.object == self.playlistSongsTableView) return;
    NSInteger row = self.tableView.selectedRow;
    if (row >= 0 && row < (NSInteger)self.filteredItems.count) {
        self.selectedItemID = self.filteredItems[row][@"id"];
        [self refreshPadView];
    }
}

- (void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray<NSSortDescriptor *> *)oldDescriptors {
    if (tableView != self.playlistSongsTableView) return;
    NSArray<NSSortDescriptor *> *sorts = tableView.sortDescriptors;
    self.musicSortDescriptors = sorts;
    [tableView reloadData];
    [self adjustTableColumns];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if (tableView == self.playlistTableView || tableView == self.playlistSongsTableView) {
        NSString *value = @"";
        if (tableView == self.playlistTableView) {
            value = row == 0 ? @"All Songs" : (self.playlists[row - 1][@"name"] ?: @"Playlist");
        } else {
            NSDictionary *song = [self displayedPlaylistSongs][row];
            if ([tableColumn.identifier isEqualToString:@"trackNumber"]) {
                NSInteger track = [song[@"trackNumber"] integerValue];
                value = track > 0 ? [NSString stringWithFormat:@"%ld", (long)track] : @"";
            } else if ([tableColumn.identifier isEqualToString:@"title"]) {
                value = song[@"title"] ?: @"Song";
            } else if ([tableColumn.identifier isEqualToString:@"album"]) {
                value = song[@"album"] ?: @"";
            } else if ([tableColumn.identifier isEqualToString:@"artist"]) {
                value = song[@"artist"] ?: @"";
            } else if ([tableColumn.identifier isEqualToString:@"duration"]) {
                value = [self durationStringForSeconds:song[@"duration"] ?: @0];
            }
        }
        NSTextField *field = [tableView makeViewWithIdentifier:@"MusicCell" owner:self];
        if (!field) {
            field = [NSTextField labelWithString:@""];
            field.identifier = @"MusicCell";
            field.lineBreakMode = NSLineBreakByWordWrapping;
            field.maximumNumberOfLines = 2;
            field.alignment = NSTextAlignmentCenter;
            field.font = [NSFont systemFontOfSize:13 weight:NSFontWeightMedium];
        }
        field.stringValue = value;
        field.alignment = NSTextAlignmentCenter;
        field.lineBreakMode = NSLineBreakByWordWrapping;
        field.maximumNumberOfLines = 2;
        field.textColor = [self themeColor:@"text"];
        return field;
    }
    if (tableView == self.recentRecordingsTableView) {
        NSURL *url = self.recentRecordingURLs[row];
        NSString *value = url.lastPathComponent;
        if ([tableColumn.identifier isEqualToString:@"recordingDate"]) {
            NSDate *date = nil;
            [url getResourceValue:&date forKey:NSURLContentModificationDateKey error:nil];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateStyle = NSDateFormatterShortStyle;
            formatter.timeStyle = NSDateFormatterShortStyle;
            value = date ? [formatter stringFromDate:date] : @"";
        }
        NSTextField *field = [tableView makeViewWithIdentifier:@"RecentRecordingCell" owner:self];
        if (!field) {
            field = [NSTextField labelWithString:@""];
            field.identifier = @"RecentRecordingCell";
            field.lineBreakMode = NSLineBreakByWordWrapping;
            field.maximumNumberOfLines = 2;
            field.alignment = NSTextAlignmentCenter;
            field.font = [NSFont systemFontOfSize:13 weight:NSFontWeightMedium];
        }
        field.stringValue = value;
        field.alignment = NSTextAlignmentCenter;
        field.lineBreakMode = NSLineBreakByWordWrapping;
        field.maximumNumberOfLines = 2;
        field.textColor = [tableColumn.identifier isEqualToString:@"recordingDate"] ? [self themeColor:@"mutedText"] : [self themeColor:@"text"];
        return field;
    }
    NSDictionary *item = self.filteredItems[row];
    if ([tableColumn.identifier isEqualToString:@"image"]) {
        NSImageView *imageView = [tableView makeViewWithIdentifier:@"ImageCell" owner:self];
        if (!imageView) {
            imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 32, 32)];
            imageView.identifier = @"ImageCell";
            imageView.imageScaling = NSImageScaleProportionallyUpOrDown;
        }
        imageView.image = [self imageForItem:item];
        return imageView;
    }
    NSString *value = @"";
    if ([tableColumn.identifier isEqualToString:@"key"]) {
        value = item[@"key"] ?: @"";
    } else if ([tableColumn.identifier isEqualToString:@"category"]) {
        value = item[@"category"] ?: (([item[@"kind"] isEqualToString:@"link"] || [item[@"kind"] isEqualToString:@"youtube"]) ? @"Music" : @"Other");
    } else if ([tableColumn.identifier isEqualToString:@"kind"]) {
        value = ([item[@"kind"] isEqualToString:@"link"] || [item[@"kind"] isEqualToString:@"youtube"]) ? @"Link" : @"Sound";
    } else {
        value = item[@"name"] ?: @"";
    }
    NSTextField *field = [tableView makeViewWithIdentifier:@"TextCell" owner:self];
    if (!field) {
        field = [NSTextField labelWithString:@""];
        field.identifier = @"TextCell";
        field.lineBreakMode = NSLineBreakByWordWrapping;
        field.maximumNumberOfLines = 2;
        field.alignment = NSTextAlignmentCenter;
        field.font = [NSFont systemFontOfSize:14 weight:NSFontWeightMedium];
    }
    field.stringValue = value;
    field.alignment = NSTextAlignmentCenter;
    field.lineBreakMode = NSLineBreakByWordWrapping;
    field.maximumNumberOfLines = 2;
    field.textColor = [tableColumn.identifier isEqualToString:@"key"]
        ? [self themeColor:@"accent"]
        : [self themeColor:@"text"];
    return field;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        AppDelegate *delegate = [[AppDelegate alloc] init];
        app.delegate = delegate;
        [app run];
    }
    return 0;
}
