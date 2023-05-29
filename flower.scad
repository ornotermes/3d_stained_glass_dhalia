/* Copyright (C) 2023 Rikard Lindström <ornotermes@gmail.com> */
/*
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.
 
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.
*/

/*It's not a requirement but attribution for the code is always welcome!*/

thicknessOutline = 3.0;
thicknessStem    = [0.4, 2.2];
thicknessBack    = [0.2, 0.4, 0.6];
thicknessLeaves  = [1.4, 2.2, 3.0];
thicknessFlower  = [1.8, 2.4, 3.0];
thicknessMin     = 0.6;

showPart = "";

//Part: Outline (Black)
if(showPart == "outline" || showPart == ""){
    color("black")
        linear_extrude (thicknessOutline)
            import("flower_outline.svg");
}


//Part: Leaves 1,2,3
if(showPart == "leaves" || showPart == ""){
    color("#00d400")
        linear_extrude(thicknessLeaves[0])
            import("flower_leaves1.svg");
    color("#00aa00")
        linear_extrude(thicknessLeaves[1])
            offset(-0.01)
                offset(0.01)
                    import("flower_leaves2.svg");
    color("#008000")
        linear_extrude(thicknessLeaves[2])
            import("flower_leaves3.svg");
    color("#552200")
        linear_extrude (thicknessStem[0])
            import("flower_stem.svg");
    color("#552200")
        translate([0,0,thicknessStem[0]+thicknessStem[1]])
            linear_extrude (thicknessStem[0])
                import("flower_stem.svg");
}

//Part: Flower 1,2,3
if(showPart == "flower" || showPart == ""){
    color("#ff80e5")
        linear_extrude(thicknessFlower[0])
            import("flower_flower1.svg");
    color("#ff55dd")
        linear_extrude(thicknessFlower[1])
            import("flower_flower2.svg");
    color("#ff2ad4")
        linear_extrude(thicknessFlower[2])
            import("flower_flower3.svg");
    color("#552200")
        translate([0,0,thicknessStem[0]])
            linear_extrude (thicknessStem[1])
                import("flower_stem.svg");
}
        
//Part: Back 1,2,3
if(showPart == "back" || showPart == ""){
    color("#80b3ff")
        linear_extrude(thicknessBack[0])
            import("flower_back1.svg");
    color("#5599ff")
        linear_extrude(thicknessBack[1])
            import("flower_back2.svg");
    color("#2a7fff")
        linear_extrude(thicknessBack[2])
            import("flower_back3.svg");
}

//part: Filler 1,2
if(showPart == "filler" || showPart == ""){
    color("white"/*"#80b3ff"*/)
        translate([0,0,thicknessBack[0]])
            linear_extrude(thicknessMin - thicknessBack[0])
                import("flower_back1.svg");
    color("white"/*"#5599ff"*/)
        translate([0,0,thicknessBack[1]])
            linear_extrude(thicknessMin - thicknessBack[1])
                import("flower_back2.svg");
    color("white"/*"#2a7fff"*/)
    translate([0,0,thicknessBack[2]])
        linear_extrude(thicknessMin - thicknessBack[2])
                import("flower_back3.svg");
}