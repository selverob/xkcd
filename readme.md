XKCD downloader
============================
Downloads the most recent XKCD strip into a specified or the current directory.

What's the point?
-----------------------
Even though I wrote this mostly as an exercise in Haskell, it does have a practical use.
You can use GeekTool on OS X to show the current strip on your desktop. How to do that?

###How to show xkcd on your desktop on OS X

1. Download GeekTool from App Store

2. Clone this repo and `cabal install` this program

3. Put a _shell_ widget on your desktop and set the xkcd executable as command. Put a directory into which it can download image as the argument. It should look like this: `xkcd ~/comics/newXkcd.jpg`
Set _refresh every_ to 8640 so that it will try to download new strip every 24 hours.

4. Now put an _image_ widget on your desktop. Using _set local path_ choose the image.
Set _refresh every_ to 4320 (I'm not sure in what order GeekTool refreshes the widgets and we wouldn't like seeing the comic 24 hours after it was published, right?)

5. Enjoy xkcd on your desktop!