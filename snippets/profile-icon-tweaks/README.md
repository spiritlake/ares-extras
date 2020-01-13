# Profile Icon Tweaks

By default, if an image used as a Profile Icon is not exactly square, it gets squished to a 1:1 ration where it's displayed as 'small' (Active Scenes list, marking a pose in a live scene, etc.) or tiny (e.g., the character-choice dropdown in a live scene). On the Characters directory page, tall images are cropped, but wide ones are squished into the space.

Defaults:


If one finds this objectionable, it can be adjusted via CSS so that the aspect ratio is always preserved. There is a trade-off here: this means that portions don't fit in the square will be cropped off. The 'object-fit' portion of this CSS is what does the cropping; the 'object-position' portion determines where the image is anchored. Without it, the image window will be centered on the center of the image; as written, it will be achored at the center horizontally and begin at 10% of the image from the top vertically. This seems to be about the sweet spot for a low incidence of really odd croppings.

Cropped Only:


Cropped and positioned at center & 10%:



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

If you would prefer your small and tiny icons to be squares with rounded corners, more like the log-icons:

    /* small and tiny icons as round-cornered squares */
    .small-profile-icon,
    .tiny-profile-icon {
        border-radius: 4px;
    }
    
...or if you'd like them to be squares with sharp corners:

    /* small and tiny icons as sharp-cornered squares */
    .small-profile-icon,
    .tiny-profile-icon {
        border-radius: 0px;
    }
