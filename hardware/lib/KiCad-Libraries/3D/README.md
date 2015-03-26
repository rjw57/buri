To create a new 3D component:

Using OpenSCAD (Based on http://happyrobotlabs.com/posts/tutorials/tutorial-3d-kicad-parts-using-openscad-and-wings3d/):
1) Create the part in OpenSCAD
2) Compile it, then export as a .stl
3) Run meshconv on the file:
    ./meshconv -c stl Path/To/Part-scad.stl -o Path/To/Part-wings
4) Import the new .stl into Wings3D and do the material changing
5) Export as a .wrl file
6) Copy the .wrl file into the 3D folder from its source folder
