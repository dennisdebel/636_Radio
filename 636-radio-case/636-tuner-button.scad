//vars
    //quality
    $fn=30;
//random numbers for unique boxes
    rand1 = rands(0,3,1)[0];
    rand2 = rands(0,1.2,1)[0];



difference(){ //hole
    cylinder(10,1.2,1.2, center=true); // hole for mounting screw
  
    
//========= KNOB + SHAFT =========
union(){

    //========= KNOB =========
    //we generate a random shape for each render
    translate([5,0,-10])
        linear_extrude(height = 6, twist = rand1+2, slices = 20) 
        {
            minkowski()
            {
                polygon(points=[

                    [-13*rand1,-13*rand2],
                    [-4,13*rand2],
                    [-13,13*rand2],
                    ]);
                    
                    polygon(points=[
                    
                    [rand1,13*rand1],
                    [13+rand1,4],
                    [rand1,-10*rand2],
                    [4,-13*rand1]]);
            }
    }
    //========= SHAFT =========
    difference(){ //shaft
        //shaft
        translate([0,0,-1.5])
        cylinder(6,4.3,4.3, center=true); //cut sides off this cylinder


        difference(){ // cut off sides
            cylinder(3,3.1,3.1, center=true); //cut sides off this cylinder
               difference(){ //sides that need cutting off
                    cylinder(3,3.3,3.3, center=true);
                    cube([4.6,7,4],center=true); 
                }
        }

    }
} //union shaft + knob

  }
    