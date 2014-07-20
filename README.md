Abathur
=======
** Current version: Experimental Alpha **

Framework for crafting Polymer elements using Gulp, Sass, Coffeescript, Slim &amp; BrowserSync.

Build Polymer elements in the slickest way possible and have them zipped for distribution when you're done. And with BrowserSync you can even reload your element every time you make a change.

Video "Stumblethrough"
-----------------------------
<a href="https://www.screenr.com/FMRN" target=_BLANK>![](http://i61.tinypic.com/2mh7q0w.png)</a>


Usage
---------

In the following, I outline through an example how to get the most out of Abathur and what kind of workflow I usually follow.

### Summoning Abathur

To install Abathur on your system, have Node / NPM installed beforehand along with Gulp and the Ruby gem `sass` (`$ gem install sass`). Then simply clone this repo to your system:

```
$ git clone git@github.com:AndersSchmidtHansen/Abathur.git Abathur
```
After that, run `$ npm install --save-dev` to install the node modules.

### Adding a new Polymer element

Let's add a Polymer element called "paper-mario" to Abathur...

1. Run `$ gulp craft --element paper-mario`. This creates the folder "paper-mario" within the "factory" folder along with the necessary files `paper-mario.slim`, `paper-mario.scss` and `paper-mario.coffee`

2. Start up Gulp with `$ gulp`. Your browser will open and BrowserSync should now be active as well, providing live reloading when you make any changes to the files within the "paper-mario" folder.

3. Begin creating your "paper-mario" Polymer element, starting with "paper-mario.slim". For inspiration, refer to the included "paper-tiger" example Polymer element or go to [Polymer](http://polymer-project.org) for more.

When you save for the first time, the compiled version of "paper-mario" will be created inside the "elements" folder.

4. Import the "paper-mario" to the "index.slim" file, by following the included "paper-tiger" example. You can remove the "paper-tiger" import if you want afterwards.

5. When satisfied with your element and when you've tested it across multiple browsers, devices and screen sizes (which [BrowserSync](www.browsersync.io) allows) it's time to pack it. Open a new tab in your terminal and type:

`$ gulp pack --element paper-mario`

This will zip both the compiled and source versions of "paper-mario" into the "distribution" folder as `paper-mario__dist.zip` and `paper-mario__source.zip`.

6. **Optional**: If you want to remove the zipped files you can also run ` $ gulp trash --element paper-mario` (or of course, just delete it manually).

### Available Gulp commands

Quick-create a new Polymer element:
```
$ gulp craft --element your-element-name
```

Compile all Polymer elements:
```
$ gulp synthesize
```

Pack an existing Polymer element as a .zip-file:
```
$ gulp pack --element your-element-name
```

Remove an existing Polymer element from "distribution" folder:
```
$ gulp trash --element your-element-name
```