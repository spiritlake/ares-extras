# Profile Icon Tweaks

### Cropping and Positioning

By default, if an image used as a Profile Icon is not exactly square, it gets squished to a 1:1 ration where it's displayed as 'small' (Active Scenes list, marking a pose in a live scene, etc.) or tiny (e.g., the character-choice dropdown in a live scene). On the Characters directory page, tall images are cropped, but wide ones are squished into the space.

#### Defaults:

![The default positioning/ratio as of Jan 2020](https://github.com/SerendipityJones/ares-extras/blob/master/snippets/profile-icon-tweaks/log-icon-default.jpg?raw=true)<br/>
![Same for the small icons](https://github.com/SerendipityJones/ares-extras/blob/master/snippets/profile-icon-tweaks/small-icon-default.jpg?raw=true)

If one finds this objectionable, it can be adjusted via CSS so that the aspect ratio is always preserved. There is a trade-off here:  portions that don't fit in the square will be cropped off. The 'object-fit' portion of this CSS is what does the cropping; the 'object-position' portion determines where the image is anchored. Without it, the image window will be centered on the center of the image; as written, it will be achored at the center horizontally and begin at 10% of the image from the top vertically. This seems to be about the sweet spot for a low incidence of really odd croppings.

#### Cropped Only:

![The above with only object-fit applied](https://github.com/SerendipityJones/ares-extras/blob/master/snippets/profile-icon-tweaks/log-icon-cropped.jpg?raw=true)<br/>
![Same for the small icons](https://github.com/SerendipityJones/ares-extras/blob/master/snippets/profile-icon-tweaks/small-icon-cropped.jpg?raw=true)

#### Cropped and positioned at center & 10%:

![The above also positioned with object-position](https://github.com/SerendipityJones/ares-extras/blob/master/snippets/profile-icon-tweaks/log-icon-positioned.jpg?raw=true)<br/>
![Same for the small icons](https://github.com/SerendipityJones/ares-extras/blob/master/snippets/profile-icon-tweaks/small-icon-positioned.jpg?raw=true)


To make these changes, this CSS can be copied and pasted into 'Custom CSS Style' (a.k.a custom_style.scss) under 'Website' in 'Admin > Setup'.

    /* crop and position icons */
    .log-icon,
    .small-profile-icon,
    .tiny-profile-icon {
        object-fit: cover;
        object-position: center 10%;
    }
    .log-icon {
        width: 150px;
        height: 150px;
    }

### Small Icon Shaping

If you would prefer your small and tiny icons to be **squares with rounded corners**:

![Small icons as rounded squares](https://github.com/SerendipityJones/ares-extras/blob/master/snippets/profile-icon-tweaks/small-icon-rounded-square.jpg?raw=true)

    /* small and tiny icons as round-cornered squares */
    .small-profile-icon,
    .tiny-profile-icon {
        border-radius: 4px;
    }
    
...or if you'd like them to be **squares with sharp corners**:

![Small icons as sharp squares](https://github.com/SerendipityJones/ares-extras/blob/master/snippets/profile-icon-tweaks/small-icon-square.jpg?raw=true)

    /* small and tiny icons as sharp-cornered squares */
    .small-profile-icon,
    .tiny-profile-icon {
        border-radius: 0px;
    }

&mdash; Contributed by [Ren](https://arescentral.aresmush.com/handle/Ren)
