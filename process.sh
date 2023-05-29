#!/bin/bash
#
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                   Version 2, December 2004
# 
# Copyright (C) 2023 Rikard Lindström <ornotermes@gmail.com>
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
# 
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
# 0. You just DO WHAT THE FUCK YOU WANT TO.
#

# Initiate associative arrays
declare -A svg_layer
declare -A scad_part

# You will need system installs of Inkscape 1.2+ and OpenSCAD. Flatpacks or similar won't work.

### Vaiables to change for your project below ###

# Filename for the SVG file, need to be with inkscape layers per color.
svg_file="flower.svg"
# Layers to extract from SVG file, they will be named filename_layername.svg, it will overwrite existing files.
# The name is arbitrary, but will be used in the SCAD-file, the ID need to match what's in the SVG file, use the XML Editor in inkscape to dind the ID's
svg_layer[outline]=layer6
svg_layer[stem]=layer10
svg_layer[leaves1]=layer15
svg_layer[leaves2]=layer9
svg_layer[leaves3]=layer16
svg_layer[flower1]=layer14
svg_layer[flower2]=layer8
svg_layer[flower3]=layer13
svg_layer[back1]=layer11
svg_layer[back2]=layer5
svg_layer[back3]=layer12

# Filename for the OpenSCAD-file
scad_file="flower.scad"
# Process parts in the SCAD-file, one part per color in this case
# The number is helping prusa slicer importing files in a predictable manner, i recommend going from dark to light to make 
scad_part[outline]=1
scad_part[leaves]=2
scad_part[flower]=3
scad_part[back]=4
scad_part[filler]=5

### Probably nothing more you need to change ###

# Extract base file names
svg_base=${svg_file%.svg}
scad_base=${scad_file%.scad}

color_ok="\e[32m"
color_err="\e[31m"
color_none="\e[0m"

# Loop over svg layers
for layer in "${!svg_layer[@]}"
do
# Set id for the layer
id=${svg_layer[$layer]}
# Process the layer in to it's own file
echo -n "Processing layer $layer..."
inkscape --actions="select-by-id:$id;select-invert:layers;delete-selection;export-area-page;export-type:svg;export-filename:${svg_base}_$layer.svg;export-do" $svg_file
code=$?
if [ $code -eq 0 ]; then echo -e "$color_ok\o/$color_none"; else echo -e "${color_err}ERROR: $code$color_none"; fi;
done

echo ""

# Loop over SCAD parts
for part in "${!scad_part[@]}"
do
# Set part name
part_num=${scad_part[$part]}
# Process the part with OpenSCAD to generate STL-file for the part
echo -e "\nProcessing part $part..."
openscad -o ${scad_base}_${part_num}_$part.stl -D "showPart=\"$part\"" $scad_file
code=$?
if [ $code -eq 0 ]; then echo -e "$color_ok\o/$color_none"; else echo -e "${color_err}ERROR: $code$color_none"; fi;
done

# Done!

