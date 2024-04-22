//---------------------------------------------------------
// This design is parameterized based on the size of a PCB.
//---------------------------------------------------------
include <library/YAPPgenerator_v16.scad>

// Note: length/lengte refers to X axis, 
//       width/breedte to Y, 
//       height/hoogte to Z

/*
      padding-back|<------pcb length --->|<padding-front
                            RIGHT
        0    X-as ---> 
        +----------------------------------------+   ---
        |                                        |    ^
        |                                        |   padding-right 
        |                                        |    v
        |    -5,y +----------------------+       |   ---              
 B    Y |         | 0,y              x,y |       |     ^              F
 A    - |         |                      |       |     |              R
 C    a |         |                      |       |     | pcb width    O
 K    s |         |                      |       |     |              N
        |         | 0,0              x,0 |       |     v              T
      ^ |   -5,0  +----------------------+       |   ---
      | |                                        |    padding-left
      0 +----------------------------------------+   ---
        0    X-as --->
                          LEFT
*/


//-- which half do you want to print?
printLidShell       = true;
printBaseShell      = true;

//-- Edit these parameters for your own board dimensions
wallThicknss       = 1.8;
basePlaneThickness  = 1.2;
lidPlaneThickness   = 1.2;

//-- Total height of box = basePlaneThickness + lidPlaneThickness 
//--                     + baseWallHeight + lidWallHeight
//-- space between pcb and lidPlane :=
//--      (baseWallHeight+lidWallHeight) - (standoffHeight+pcbThickness)
baseWallHeight      = 10;
lidWallHeight       = 20;

//-- ridge where base and lid off box can overlap
//-- Make sure this isn't less than lidWallHeight
ridgeHeight         = 3.5;
ridgeSlack          = 0.2;
roundRadius         = 2.0;

//-- pcb dimensions
pcbLength           = 95.5;
pcbWidth            = 55;
pcbThickness        = 1.5;

//-- How much the PCB needs to be raised from the base
//-- to leave room for solderings and whatnot
standoffHeight      = 5.1; //5.1
pinDiameter         = 2.0;
pinHoleSlack        = 0.5;
standoffDiameter    = 4;
standoffSupportHeight   = 2.0;
standoffSupportDiameter = 2.0;
                            
//-- padding between pcb and inside wall
paddingFront        = 2;
paddingBack         = 2;
paddingRight        = 2;
paddingLeft         = 2;


//-- D E B U G ----------------------------
showSideBySide      = true;       //-> true
onLidGap            = 0;
shiftLid            = 1;
hideLidWalls        = false;       //-> false
colorLid            = "yellow";   
hideBaseWalls       = false;       //-> false
colorBase           = "white";
showPCB             = false;      //-> false
showMarkers         = false;      //-> false
inspectX            = 0;  //-> 0=none (>0 from front, <0 from back)
inspectY            = 0;
//-- D E B U G ----------------------------


//-- pcb_standoffs  -- origin is pcb[0,0,0]
// (0) = posx
// (1) = posy
// (2) = { yappBoth | yappLidOnly | yappBaseOnly }
// (3) = { yappHole, YappPin }
pcbStands = [
                //[10, 10 ,yappLidOnly,yappPin], //does not work
               //[93, 125 ,yappBaseOnly,yappPin], // front right - hack to put YappPin on lid..
                 [5.3, 125 ,yappBaseOnly,yappPin], //back right
                  [5.3, 75 ,yappBaseOnly,yappPin], //back left
                  //[93, 75 ,yappBaseOnly,yappPin] //front left
             ];

//-- Lid plane    -- origin is pcb[0,0,0]
// (0) = posx
// (1) = posy
// (2) = width
// (3) = length
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }

cutoutsLid =  [ 
    //speaker holes
   // rotate((j*360)/3)

			 // [70, pcbWidth/2+4, 2, 0, 0, yappCircle],
             
//     [70, pcbWidth/2, 2, 0, 0, yappCircle],
//        [70, pcbWidth/2+3, 2, 0, 0, yappCircle],
//        [70, pcbWidth/2-3, 2, 0, 0, yappCircle],
//     [70-3, pcbWidth/2-1, 2, 0, 0, yappCircle],
//     [70+3, pcbWidth/2+1, 2, 0, 0, yappCircle],
//        [70-3, pcbWidth/2+2, 2, 0, 0, yappCircle],
//        [70+3, pcbWidth/2-2, 2, 0, 0, yappCircle],
//            [70-3, pcbWidth/2+5, 2, 0, 0, yappCircle],
//            [70+3, pcbWidth/2-5, 2, 0, 0, yappCircle],
     
    // on/off swicth
                   [73, 48, 2.5, 0, 0, yappCircle],
                   [88, 48, 2.5, 0, 0, yappCircle],
                   [75, 45, 6, 11, 0, yappRectangle], 
           
    // tuner capacitor
                  [18.9, pcbWidth/2-2.5, 10, 0, 0, yappCircle],
                  
                  
   // wild style
        [70*single_rand_small, single_rand_small,single_rand_small/2, single_rand_small, single_rand_big, yappRectangle],
        
        [60, single_rand_small,single_rand_small, single_rand_small, single_rand_big+10, yappRectangle],
        
        [55, single_rand_small+single_rand_big,single_rand_small, single_rand_small/3, single_rand_big+10, yappRectangle],
        
        
       [70-single_rand_small, single_rand_small,single_rand_small/2, single_rand_small, single_rand_big, yappCircle],
        
        [60+single_rand_small, single_rand_small,single_rand_small, single_rand_small, single_rand_big+10, yappCircle],
        
        [55-single_rand_small, single_rand_small+single_rand_big,single_rand_small, single_rand_small/3, single_rand_big+10, yappCircle],
        
//--

        [50*single_rand_small, single_rand_small,single_rand_small/2, single_rand_small, single_rand_big, yappRectangle],
        
        [60+10, single_rand_small,single_rand_small*2, single_rand_small/4, single_rand_big+10, yappRectangle],
        
        [55*single_rand_small, single_rand_small*single_rand_big,single_rand_small, single_rand_small/2, single_rand_big-10, yappRectangle],
        
        
       [70*single_rand_small, single_rand_small*2,single_rand_small/3, single_rand_small, single_rand_big, yappCircle],
        
        [60+single_rand_small+2, single_rand_small,single_rand_small, single_rand_small, single_rand_big+5, yappCircle],
        
        [55-single_rand_small, single_rand_small+single_rand_big,single_rand_small, single_rand_small/4, single_rand_big-20, yappCircle]
       
        //---
        
      ,[pcbLength-9*single_rand_small, 20, 3, 0, 0, yappCircle] 
      ,[60*single_rand_small, pcbWidth/2, 5, 9, -10, yappRectangle, yappCenter],
            [70, 2*single_rand_small, 7, 15, 10, yappRectangle]
      ,[pcbLength-19*single_rand_small-10, 20, 6, 0, 0, yappCircle] 
      ,[30+single_rand_small, pcbWidth/2+2, 20, 3, -30, yappRectangle, yappCenter]
      
               ,[30+single_rand_small+single_rand_big, pcbWidth/2+2, 15+single_rand_small, 3, single_rand_small, yappRectangle, yappCenter]
                
              ];
              

//-- base plane    -- origin is pcb[0,0,0]
// (0) = posx
// (1) = posy
// (2) = width
// (3) = length
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
cutoutsBase = [
//                    [10, 10, 10, 15, 30, yappRectangle]
//                  , [10, 10, 5, 0, 0, yappCircle]
//                  , [pcbLength/2, pcbWidth/2, 10, 15, 45, yappRectangle, yappCenter]
//                  , [pcbLength/2, pcbWidth/2, 5, 0, 0, yappCircle]

   // wild style
        [70*single_rand_small, single_rand_small,single_rand_small/2, single_rand_small, single_rand_big, yappRectangle],
        
        [60, single_rand_small,single_rand_small, single_rand_small, single_rand_big+10, yappRectangle],
        
        [55, single_rand_small+single_rand_big,single_rand_small, single_rand_small/3, single_rand_big+10, yappRectangle],
        
        
       [70-single_rand_small, single_rand_small,single_rand_small/2, single_rand_small, single_rand_big, yappCircle],
        
        [60+single_rand_small, single_rand_small,single_rand_small, single_rand_small, single_rand_big+10, yappCircle],
        
        [55-single_rand_small, single_rand_small+single_rand_big,single_rand_small, single_rand_small/3, single_rand_big+10, yappCircle],
        
//--

        [50*single_rand_small, single_rand_small,single_rand_small/2, single_rand_small, single_rand_big, yappRectangle],
        
        [60+10, single_rand_small,single_rand_small*2, single_rand_small/4, single_rand_big+10, yappRectangle],
        
        [55*single_rand_small, single_rand_small*single_rand_big,single_rand_small, single_rand_small/2, single_rand_big-10, yappRectangle],
        
        
       [70*single_rand_small, single_rand_small*2,single_rand_small/3, single_rand_small, single_rand_big, yappCircle],
        
        [60+single_rand_small, single_rand_small,single_rand_small, single_rand_small, single_rand_big+5, yappCircle],
        
        [55-single_rand_small, single_rand_small+single_rand_big,single_rand_small, single_rand_small/4, single_rand_big-20, yappCircle]
       
        //---
        
      ,[pcbLength-9*single_rand_small, 20, 3, 0, 0, yappCircle] 
      ,[60*single_rand_small, pcbWidth/2, 5, 9, -10, yappRectangle, yappCenter],
            [70, 2*single_rand_small, 7, 15, 10, yappRectangle]
      ,[pcbLength-19*single_rand_small-10, 20, 6, 0, 0, yappCircle] 
      ,[30+single_rand_small, pcbWidth/2+2, 15, 3, -30, yappRectangle, yappCenter]
            ,[30+single_rand_small+single_rand_big, pcbWidth/2+2, 15+single_rand_small, 3, single_rand_small, yappRectangle, yappCenter]
      
        ];

//-- front plane  -- origin is pcb[0,0,0]
// (0) = posy
// (1) = posz
// (2) = width
// (3) = height
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
cutoutsFront =  [ // jack connector
           
                   [28, 14.7, 7, 0, 0, yappCircle]
                ];

//-- back plane  -- origin is pcb[0,0,0]
// (0) = posy
// (1) = posz
// (2) = width
// (3) = height
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
cutoutsBack = [
//                     [10, 10, 12, 15, 10, yappRectangle]
//                   , [10, 10, 5, 0, 0, yappCircle]
//                   , [40, 10, 10, 8, 0, yappRectangle, yappCenter]
//                   , [40, 10, 5, 0, 0, yappCircle]


            ];

//-- left plane   -- origin is pcb[0,0,0]
// (0) = posx
// (1) = posz
// (2) = width
// (3) = height
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
//cutoutsLeft = [
//                  [10, 10, 12, 15, 10, yappRectangle]
//                , [10, 10, 5, 0, 0, yappCircle]
//                , [50, 10, 10, 8, 20, yappRectangle, yappCenter]
//                , [50, 10, 5, 0, 0, yappCircle]
//              ];

//-- right plane   -- origin is pcb[0,0,0]
// (0) = posx
// (1) = posz
// (2) = width
// (3) = height
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
//cutoutsRight = [
//                  [10, 10, 12, 15, 10, yappRectangle]
//                , [10, 10, 5, 0, 0, yappCircle]
//                , [50, 10, 10, 8, 20, yappRectangle, yappCenter]
//                , [50, 10, 5, 0, 0, yappCircle]
//               ];

//-- connectors -- origen = box[0,0,0]
// (0) = posx
// (1) = posy
// (2) = screwDiameter
// (3) = insertDiameter
// (4) = outsideDiameter
// (5) = { yappAllCorners }
connectors   = [
//                   [10, 10, 2, 3, 2, yappAllCorners]
//                   , [50, 10, 4, 6, 9]
//                   , [4, 3, 34, 3, yappFront]
//                   , [25, 3, 3, 3, yappBack]
               ];


//-- base mounts -- origen = box[x0,y0]
// (0) = posx | posy
// (1) = screwDiameter
// (2) = width
// (3) = height
// (4..7) = yappLeft / yappRight / yappFront / yappBack (one or more)
// (5) = { yappCenter }
baseMounts   = [
                //     [60, 3.3, 20, 3, yappBack, yappLeft]
                //   , [50, 3.3, 30, 3, yappRight, yappFront, yappCenter]
                //   , [20, 3, 5, 3, yappRight]
                //   , [10, 3, 5, 3, yappBack]
                //   , [4, 3, 34, 3, yappFront]
                //   , [25, 3, 3, 3, yappBack]
                //   , [5, 3.2, shellWidth-10, 3, yappFront]
               ];

               
//-- snapJons -- origen = shell[x0,y0]
// (0) = posx | posy
// (1) = width
// (2..5) = yappLeft / yappRight / yappFront / yappBack (one or more)
// (n) = { yappSymmetric }
snapJoins   =   [
                    [10,  5, yappLeft, yappRight, yappSymmetric]
                  , [5,  5, yappFront, yappBack, yappSymmetric]
                ];

 
//-- origin of labels is box [0,0,0]
// (0) = posx
// (1) = posy/z
// (2) = orientation
// (3) = depth
// (4) = plane {lid | base | left | right | front | back }
// (5) = font
// (6) = size
// (7) = "label text"
labelsPlane = [
[10,  10,   30, 4, "lid",   "Liberation Mono:style=bold",15, "6" ],
[20,  20+single_rand_big,   single_rand_big-5, 4, "lid",   "Liberation Mono:style=bold",15, "3" ],
[30,  40,   single_rand_big, 4, "lid",   "Liberation Mono:style=bold",15, "6" ],
//
//[100, 0, 0, 0.8, "base",  "Liberation Mono:style=bold",11, "Battery" ]

//             [70,  22,   20, 0.5, "left",  "Liberation Mono:style=bold", 7, "636" ],
//             
//             [75,  15,   20, 0.5, "left",  "Liberation Mono:style=bold", 3, "v1" ],
//                          [24,  25,   0, 0.5, "back",  "Liberation Mono:style=bold", 3.4, "Tuner" ],
//                          
//    [20,  15,   0, 0.5, "front",  "Liberation Mono:style=bold", 3, "Headphones" ],
//
//            
// //wild style
//
//               [40,  60,   0, 0.5, "lid",   "Liberation Mono:style=bold",15, "Lid" ]
//               ,[100, 90, 180, 0.5, "base",  "Liberation Mono:style=bold",11, "Base" ]
//               ,[75,  22,   0, 0.5, "left",  "Liberation Mono:style=bold", 7, "Left" ]
//               ,[ 8,   8,   0, 0.5, "left",  "Liberation Mono:style=bold", 7, "Left" ]
//               ,[10,   5,   0, 0.5, "right", "Liberation Mono:style=bold", 7, "Right" ]
//               ,[20,  20,   0, 0.5, "right", "Liberation Mono:style=bold", 4, "on/off" ]
//               ,[30,  10,   0, 0.5, "front", "Liberation Mono:style=bold", 7, "Front" ]
//               ,[40,  23,   0, 0.5, "front", "Liberation Mono:style=bold", 7, "Front" ]
//               ,[ 5,   5,   0, 0.5, "back",  "Liberation Mono:style=bold", 8, "Back" ]
//               ,[20,  22,   0, 0.5, "back",  "Liberation Mono:style=bold", 8, "Back" ]
           ];
              
              
              
             


module lidHook()
{
  %translate([-20, -20, 0]) cube(5);
}

//--- this is where the magic hapens ---

YAPPgenerate();
