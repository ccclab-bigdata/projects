This is an online NIFTI viewer based on Neurosynth viewer. It is handy for remote access and sharing of NIFTI files. It is written in JavaScript.

The header and the description of the page can be changed in the "index.html" file

The app.js file handles the visualization of the files

The NIFTI files are located in the data folder.

To include the NIFTI file with name emo2_mm.nii using the label fear, in red colour and with a label "z-score" for the values you need to add the following code:
```javascript
{
	'url': 'data/emo2_2mm.nii',
	'name': 'Fear',
	'colorPalette': 'red',
	'intent': 'z-score:'
}
```

The following color maps are available:

⋅⋅* grayscale
⋅⋅* red
⋅⋅* green
⋅⋅* blue
⋅⋅* yellow
⋅⋅* purple
⋅⋅* lime
⋅⋅* aqua
⋅⋅* navy
⋅⋅* intense red-blue
⋅⋅* red-yellow-blue
⋅⋅* brown-teal

In case something is not set correctly the viewer will not give any message, it will just not show (any of) the data.

Since the NIFTI files are pretty big ( usually a couple of MBs) the viewer my not work smoothly in slow connections

The viewer is originally found [here](http://github.com/neurosynth/nsviewer)


