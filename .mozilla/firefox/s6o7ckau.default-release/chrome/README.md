# Enable Firefox features

Go to `about:config` and set all of the following to `true`:
```
    toolkit.legacyUserProfileCustomizations.stylesheets
    layers.acceleration.force-enabled
    gfx.webrender.all
    gfx.webrender.enabled
    layout.css.backdrop-filter.enabled
    svg.context-properties.content.enabled

    # LINUX ONLY - WORKAROUND FOR BAR HIDING ON DRAG EVENT
    widget.gtk.ignore-bogus-leave-notify = 1
```

# Write your userChrome.css

1. Find your Firefox profile folder (`about:support` --> "Profile Folder")
2. Create a folder named `chrome` inside it.
3. Create a file named `userChrome.css` inside the `chrome` folder you just created.
4. Paste in `userChrome.css` whatever you like from above

# To hide the "classic" horizontal tab toolar entirely

Paste this in your `userChrome.css`:
```
#TabsToolbar
{
    visibility: collapse;
}
```

# To decrease the size of the sidebar header

Paste this in your `userChrome.css`:

```

/**
 * Decrease size of the sidebar header
 */
#sidebar-header {
  font-size: 1.2em !important;
  padding: 2px 6px 2px 3px !important;
}
#sidebar-header #sidebar-close {
  padding: 3px !important;
}
#sidebar-header #sidebar-close .toolbarbutton-icon {
  width: 14px !important;
  height: 14px !important;
  opacity: 0.6 !important;
}
```

# To remove the sidebar header entirely

Paste this in your `userChrome.css`:

```
#sidebar-header {
  display: none;
}
```

# To auto-hide the tab sidebar

Paste this in your `userChrome.css`:

```
#sidebar-header {
  /* display: none; */
  visibility: collapse !important;
}

/* Hide splitter */
#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] + #sidebar-splitter {
  display: none !important;
}

/* Shrink sidebar until hovered */
:root {
  --thin-tab-width: 32px;
  --wide-tab-width: 300px;
}
#sidebar-box:not([sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]) {
  min-width: var(--wide-tab-width) !important;
  max-width: none !important;
}
#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] {
  overflow: hidden !important;
  position: relative !important;
  transition: all 300ms !important;
  /*transition: all 0ms 0s !important;*/
  min-width: var(--thin-tab-width) !important;
  max-width: var(--thin-tab-width) !important;
  z-index: 2;
}
#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:hover,
#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] #sidebar {
  /*transition-delay: 0s !important;*/
  transition: all 300ms !important;
  min-width: var(--wide-tab-width) !important;
  max-width: var(--wide-tab-width) !important;
  z-index: 1;
}
#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:hover {
  margin-right: calc((var(--wide-tab-width) - var(--thin-tab-width)) * -1) !important;
}
```

# To auto-hide the horizontal tab bar when the sidebar is active

Paste this in your `userChrome.css`:

```
#main-window #titlebar {
  overflow: hidden;
  transition: height 0.3s 0.3s !important;
}
/* Default state: Set initial height to enable animation */
#main-window #titlebar { height: 3em !important; }
#main-window[uidensity="touch"] #titlebar { height: 3.35em !important; }
#main-window[uidensity="compact"] #titlebar { height: 2.7em !important; }
/* Hidden state: Hide native tabs strip */
#main-window[titlepreface*="XXX"] #titlebar { height: 0 !important; }
/* Hidden state: Fix z-index of active pinned tabs */
#main-window[titlepreface*="XXX"] #tabbrowser-tabs { z-index: 0 !important; }
```
And then go to `Sidebery settings` > `Help` > `Preface value`, enable it and set it to `XXX`.

Now You also need to remove indent when the bar is collapsed, or you won't be able to see all tabs

Go to `SideBery settings` --> `Styles editor` and add:

```
#root:not(:hover){
  --tabs-indent: 0;
}
```


# Enable Firefox features

Go to `about:config` and set all of the following to `true`:
```
    toolkit.legacyUserProfileCustomizations.stylesheets
    layers.acceleration.force-enabled
    gfx.webrender.all
    gfx.webrender.enabled
    layout.css.backdrop-filter.enabled
    svg.context-properties.content.enabled

    # LINUX ONLY - WORKAROUND FOR BAR HIDING ON DRAG EVENT
    widget.gtk.ignore-bogus-leave-notify = 1
```

# Write your userChrome.css

1. Find your Firefox profile folder (`about:support` --> "Profile Folder")
2. Create a folder named `chrome` inside it.
3. Create a file named `userChrome.css` inside the `chrome` folder you just created.
4. Paste in `userChrome.css` whatever you like from above

# To hide the "classic" horizontal tab toolar entirely

Paste this in your `userChrome.css`:
```
#TabsToolbar
{
    visibility: collapse;
}
```

# To decrease the size of the sidebar header

Paste this in your `userChrome.css`:

```

/**
 * Decrease size of the sidebar header
 */
#sidebar-header {
  font-size: 1.2em !important;
  padding: 2px 6px 2px 3px !important;
}
#sidebar-header #sidebar-close {
  padding: 3px !important;
}
#sidebar-header #sidebar-close .toolbarbutton-icon {
  width: 14px !important;
  height: 14px !important;
  opacity: 0.6 !important;
}
```

# To remove the sidebar header entirely

Paste this in your `userChrome.css`:

```
#sidebar-header {
  display: none;
}
```

# To auto-hide the tab sidebar

Paste this in your `userChrome.css`:

```
#sidebar-header {
  /* display: none; */
  visibility: collapse !important;
}

/* Hide splitter */
#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] + #sidebar-splitter {
  display: none !important;
}

/* Shrink sidebar until hovered */
:root {
  --thin-tab-width: 32px;
  --wide-tab-width: 300px;
}
#sidebar-box:not([sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]) {
  min-width: var(--wide-tab-width) !important;
  max-width: none !important;
}
#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] {
  overflow: hidden !important;
  position: relative !important;
  transition: all 300ms !important;
  /*transition: all 0ms 0s !important;*/
  min-width: var(--thin-tab-width) !important;
  max-width: var(--thin-tab-width) !important;
  z-index: 2;
}
#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:hover,
#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] #sidebar {
  /*transition-delay: 0s !important;*/
  transition: all 300ms !important;
  min-width: var(--wide-tab-width) !important;
  max-width: var(--wide-tab-width) !important;
  z-index: 1;
}
#sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:hover {
  margin-right: calc((var(--wide-tab-width) - var(--thin-tab-width)) * -1) !important;
}
```

# To auto-hide the horizontal tab bar when the sidebar is active

Paste this in your `userChrome.css`:

```
#main-window #titlebar {
  overflow: hidden;
  transition: height 0.3s 0.3s !important;
}
/* Default state: Set initial height to enable animation */
#main-window #titlebar { height: 3em !important; }
#main-window[uidensity="touch"] #titlebar { height: 3.35em !important; }
#main-window[uidensity="compact"] #titlebar { height: 2.7em !important; }
/* Hidden state: Hide native tabs strip */
#main-window[titlepreface*="XXX"] #titlebar { height: 0 !important; }
/* Hidden state: Fix z-index of active pinned tabs */
#main-window[titlepreface*="XXX"] #tabbrowser-tabs { z-index: 0 !important; }
```
And then go to `Sidebery settings` > `Help` > `Preface value`, enable it and set it to `XXX`.

Now You also need to remove indent when the bar is collapsed, or you won't be able to see all tabs

Go to `SideBery settings` --> `Styles editor` and add:

```
#root:not(:hover){
  --tabs-indent: 0;
}
```

