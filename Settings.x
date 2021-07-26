#import "Header.h"
#import "../YouTubeHeader/YTSettingsSectionItem.h"

extern BOOL UseVP9();

%hook YTSettingsViewController

- (void)setSectionItems:(NSMutableArray <YTSettingsSectionItem *> *)sectionItems forCategory:(NSInteger)category title:(NSString *)title titleDescription:(NSString *)titleDescription headerHidden:(BOOL)headerHidden {
    if (category == 14) {
        YTSettingsSectionItem *vp9 = [%c(YTSettingsSectionItem) switchItemWithTitle:@"Use VP9 codec"
            titleDescription:@"This enables usage of VP9 codec for HD videos, and in effect, enables video quality of 2K and 4K."
            accessibilityIdentifier:nil
            switchOn:UseVP9()
            switchBlock:^BOOL (YTSettingsCell *cell, BOOL enabled) {
                [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:UseVP9Key];
                return YES;
            }
            settingItemId:0];
        [sectionItems addObject:vp9];
    }
    %orig(sectionItems, category, title, titleDescription, headerHidden);
}

%end