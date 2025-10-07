# Proximity Signs
This plugin provides functionality to add comments to events that cause them to show floating text boxes when the player is near them. Intended for use with signs so the player can read them without interacting with them.

# Configuration
The plugin contains a `Settings.rb` file that can be edited to customize the plugin.
In that file, you can set a window skin for the proximity signs, change the text color, add spacing between the text boxes and the event, and tweak the range at which they will be shown.

# Usage
![Example image of an event page](https://i.imgur.com/o0CwURj.png)
- Make an event and add comments to it give it proximity sign features.
  - Comments are formatted as such: `Sign: Text here`
  - Signs can be shown on any side of the event, even multiple at once.
    - Sign/SignTop/SignUp shows above
    - SignBottom shows below
    - SignLeft/SignRight shows to left or right
- The comments respect event pages, so an event can change its active page to show different text.
  - You may need to reload the map or run `pbUpdateSigns` for a page change to take effect.
- The code will replace `\leftarrrow`, `\rightarrow`, `\uparrow` and `\downarrow` with the respective unicode arrow character. Use this if your font supports it.
