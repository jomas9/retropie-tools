////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Updated 06/03/2017 by MrHArias                                                                      
// Updated and enhanced to be Vertical, includes more backgrouds and cabinets.                           
// Notes: Lots of changes...  
//
// 10/11/2016 updated by DGM for the RetroPie Facebook group 
// Updated and enhanced to now include many new features and options
//
// Updated 9/08/2016 by omegaman                                                                      
// Attract-Mode "Robospin" layout. Thanks to verion for cleaning cab skins and to malfacine's for glogos                             
// Notes: Lots of changes...  
////////////////////////////////////////////////////////////////////////////////////////////////////////   

class UserConfig {
</ label="--------  Main theme layout  --------", help="Show or hide additional images", order=1 /> uct1="select below";
   </ label="Enable Cinematic View", help="Enable Cinematic View", options="Yes, No", order=2 /> enable_cinematic="No";
</ label="--------  Main theme layout  --------", help="Show or hide additional images", order=1 /> uct1="select below";
   </ label="Select background color", help="Select background color", options="wood-gray,black,motion_blue,motion_gray,motion_green,motion_orange,motion_red,static_blue,static_gray,static_green,static_orange,static_red,matrix,matrix_purple,matrix_blue", order=2 /> enable_background="wood-gray";
   </ label="Select cabinet  color", help="Select cabinet color", options="gray", order=3 /> enable_cab="gray";
   </ label="Select listbox, wheel, vert_wheel", help="Select wheel type or listbox", options="vert_wheel", order=4 /> enable_list_type="vert_wheel";
   </ label="Select spinwheel art", help="The artwork to spin", options="marquee,wheel", order=5 /> orbit_art="wheel";
   </ label="Wheel transition time", help="Time in milliseconds for wheel spin.", order=6 /> transition_ms="35";  
</ label=" ", help=" ", options=" ", order=7 /> divider1="";
</ label="--------    Game info box    --------", help="Show or hide game info box", order=8 /> uct5="select below";
   </ label="Enable game information", help="Show game information", options="Yes,No", order=9 /> enable_ginfo="Yes";
   </ label="Enable select keys", help="Show select flashing keys", options="Yes,No", order=10 /> enable_seletkeys="Yes"; 
   </ label="Enable text frame", help="Show text frame", options="Yes,No", order=10 /> enable_frame="No"; 
   </ label="Enable top system logo", help="Show system wheel logo on top, game selection menu", options="Yes,No", order=11 /> enable_toplogo="Yes";
   </ label="Enable system logo", help="Show system logo next to game name", options="Yes,No", order=11 /> enable_logo="Yes";
</ label=" ", help=" ", options=" ", order=12 /> divider5="";
</ label="--------    Miscellaneous    --------", help="Miscellaneous options", order=13 /> uct6="select below";
   </ label="Enable random text colors", help=" Select random text colors.", options="Yes,No", order=14 /> enable_colors="No";
   </ label="Enable monitor static effect - video", help="Show static effect when snap is null", options="Yes,No", order=15 /> enable_static="No"; 
   </ label="Enable monitor static effect - photo", help="Show static effect when snap is null", options="Yes,No", order=15 /> enable_static_photo="Yes"; 
}  

local my_config = fe.get_config();
local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;
fe.layout.font="Roboto";

// modules
fe.load_module("fade");
fe.load_module( "animate" );

// Cenematic View
if ( my_config["enable_cinematic"] == "Yes" )
{
wheel_ms <- 100;
override_lag_ms <- 0;

// modules
fe.load_module("fade");

/////////////////////
//Video
/////////////////////
local snap = FadeArt( "snap", 0, 0, flw, flh );
snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = true;



//
// Transition management
//
override_first_part <- false;
navigate_in_progress <- false;


// if call_animate is true, we simply pass transitions along to the
// animate module's transition handling
//
local call_animate=false;
local w_alpha = 1000;

fe.add_transition_callback( "hs_transition" );
function hs_transition( ttype, var, ttime )
{
	if ( call_animate )
	{
		// As of this writing the animate module's transition function never
		// returns true so this part is unlikely to ever be used...
		//
		if ( hs_animation.transition_callback( ttype, var, ttime ) )
			return true;

		call_animate = false;
		return false;
	}

	switch ( ttype )
	{
	case Transition.ToNewList:
	case Transition.EndNavigation:
		navigate_in_progress = false;



		break;

	case Transition.ToNewSelection:
        w_alpha = 1000;
		if ( override_lag_ms <=  0 )
			break;

		if ( override_first_part )
		{
			//
			// Show the override video for override_lag_ms before starting
			// the switch to the new selection
			//
 			if ( ttime < override_lag_ms )
				return true;

			override_first_part = false;
			return false;
		}

		//
		// Don't start a new override if still navigating...
		//
		if ( navigate_in_progress )
			return false;

		navigate_in_progress = true;
		return load_override_transition(
			get_hs_system_dir(), get_match_map( var ) );

	default:
		break;
	}


	return false;
}
//Special Art

//
// Set up the wheel
//


fe.load_module( "conveyor" );
local wheel_x = [ flx*0.01, flx*0.01 flx*0.01, flx*0.01 flx*0.01, flx*0.01 flx*0.0, flx*0.01 flx*0.01, flx*0.01 flx*0.01, flx*0.01 ];
local wheel_y = [ -fly*0.22, -fly*0.205, -fly*0.206, fly*0.03, fly*0.160, fly*0.290, fly*0.420, fly*0.57, fly*0.70 fly*0.83, fly*1.85, fly*0.95, ]; 
local wheel_w = [ flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.18, flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.16, ];
local wheel_a = [  80,  80,  80,  80,  80,  80, 255,  80,  80,  80,  80,  80, ];
local wheel_h = [  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12, flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,];
local wheel_r = [  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ];
local num_arts = 8;

//
fe.add_ticks_callback( "hs_wheel_alpha" );
function hs_wheel_alpha( ttime )
{
    if (w_alpha > 0) {
        w_alpha = w_alpha - 5;
        if (w_alpha < 0) {
            w_alpha = 0;
        }
        for (local i=0; i < wheel.m_objs.len(); i++) {
            if (i == 5) {
                if (w_alpha < wheel_a[i+1]) {
                    wheel.m_objs[i].alpha = w_alpha;
                }
            } else if (w_alpha <= 255 + wheel_a[i+1]) {
if (w_alpha >= 255) {
                wheel.m_objs[i].alpha = w_alpha - 255;
} else {
                wheel.m_objs[i].alpha = 0;
}
            }
        }
    }
}

class WheelEntry extends ConveyorSlot
{
	constructor()
	{
		base.constructor( ::fe.add_artwork( "wheel" ) );
	}

	function on_progress( progress, var )
	{
		local p = progress / 0.1;
		local slot = p.tointeger();
		p -= slot;
		slot++;

		if ( slot < 0 ) slot=0;
		if ( slot >= 10 ) slot=10;

		m_obj.x = wheel_x[slot] + p * ( wheel_x[slot+1] - wheel_x[slot] );
		m_obj.y = wheel_y[slot] + p * ( wheel_y[slot+1] - wheel_y[slot] );

		m_obj.width = wheel_w[slot] + p * ( wheel_w[slot+1] - wheel_w[slot] );
		m_obj.height = 0;
		m_obj.preserve_aspect_ratio=true;

		m_obj.rotation = wheel_r[slot] + p * ( wheel_r[slot+1] - wheel_r[slot] );
		m_obj.alpha = wheel_a[slot] + p * ( wheel_a[slot+1] - wheel_a[slot] );
	}
};

local num_arts = 10;
local wheel_entries = [];
for ( local i=0; i<num_arts/2; i++ )
	wheel_entries.push( WheelEntry() );

local remaining = num_arts - wheel_entries.len();

// we do it this way so that the last wheelentry created is the middle one showing the current
// selection (putting it at the top of the draw order)
for ( local i=0; i<remaining; i++ )
	wheel_entries.insert( num_arts/2, WheelEntry() );

wheel <- Conveyor();
wheel.set_slots( wheel_entries );
wheel.transition_ms = wheel_ms;




// Game info text.
 local titleText = fe.add_text( "[DisplayName] > [Title]", flw*0, fly*0.97, flw, flh*0.022  );
 titleText.alpha = 200;
 titleText.align = Align.Left;
 }


// Cenematic View
if ( my_config["enable_cinematic"] == "No" )

{

// Load background image
if ( my_config["enable_background"] == "wood-gray" )
{
local bgsolid = fe.add_image( "backgrounds/wood-gray.png", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "black" )
{
local bgsolid = fe.add_image( "backgrounds/black.png", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "motion_blue" )
{
local bgsolid = fe.add_image( "backgrounds/motion_blue.mp4", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "motion_gray" )
{
local bgsolid = fe.add_image( "backgrounds/motion_gray.mp4", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "motion_green" )
{
local bgsolid = fe.add_image( "backgrounds/motion_green.mp4", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "motion_orange" )
{
local bgsolid = fe.add_image( "backgrounds/motion_orange.mp4", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "motion_red" )
{
local bgsolid = fe.add_image( "backgrounds/motion_red.mp4", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "matrix" )
{
local bgsolid = fe.add_image( "backgrounds/matrix.mp4", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "matrix_purple" )
{
local bgsolid = fe.add_image( "backgrounds/matrix_purple.mp4", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "matrix_blue" )
{
local bgsolid = fe.add_image( "backgrounds/matrix_blue.mp4", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "static_blue" )
{
local bgsolid = fe.add_image( "backgrounds/bkg_static_blue.png", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "static_gray" )
{
local bgsolid = fe.add_image( "backgrounds/bkg_static_gray.png", 0, 0, flw, flh );
bgsolid.alpha=255;
}


if ( my_config["enable_background"] == "static_green" )
{
local bgsolid = fe.add_image( "backgrounds/bkg_static_green.png", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "static_orange" )
{
local bgsolid = fe.add_image( "backgrounds/bkg_static_orange.png", 0, 0, flw, flh );
bgsolid.alpha=255;
}

if ( my_config["enable_background"] == "static_red" )
{
local bgsolid = fe.add_image( "backgrounds/bkg_static_red.png", 0, 0, flw, flh );
bgsolid.alpha=255;
}

// Video Preview or static video if none available
// remember to make both sections the same dimensions and size
if ( my_config["enable_static"] == "Yes" )
{
//adjust the values below for the static preview video snap
   const SNAPBG_ALPHA = 200;
   local snapbg=null;
   snapbg = fe.add_image( "static.mp4", flx*0.21, fly*0.09, flw*0.775, flh*0.8 );
   snapbg.trigger = Transition.EndNavigation;
   snapbg.skew_y = 0;
   snapbg.skew_x = 0;
   snapbg.pinch_y = 0;
   snapbg.pinch_x = 0;
   snapbg.rotation = 0;
   snapbg.set_rgb( 155, 155, 155 );
   snapbg.alpha = SNAPBG_ALPHA;
}
 else
 {
 local temp = fe.add_text("", flx*0.21, fly*0.09, flw*0.775, flh*0.8 );
 temp.bg_alpha = SNAPBG_ALPHA;
 }
 
// Video Preview or static video if none available
// remember to make both sections the same dimensions and size
if ( my_config["enable_static_photo"] == "Yes" )
{
//adjust the values below for the static preview video snap
   const SNAPBG_ALPHA = 200;
   local snapbg=null;
   snapbg = fe.add_image( "static.png", flx*0.21, fly*0.09, flw*0.775, flh*0.8 );
   snapbg.trigger = Transition.EndNavigation;
   snapbg.skew_y = 0;
   snapbg.skew_x = 0;
   snapbg.pinch_y = 0;
   snapbg.pinch_x = 0;
   snapbg.rotation = 0;
   snapbg.set_rgb( 155, 155, 155 );
   snapbg.alpha = SNAPBG_ALPHA;
}
 else
 {
 local temp = fe.add_text("", flx*0.21, fly*0.09, flw*0.775, flh*0.8 );
 temp.bg_alpha = SNAPBG_ALPHA;
 } 

//create surface for snap
local snap = FadeArt( "snap", flx*0.21, fly*0.09, flw*0.775, flh*0.8 );
snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = false;




// Load cabinet image
if ( my_config["enable_cab"] == "gray" )
{
local cabsolid = fe.add_image( "backgrounds/bkg_gray.png", 0, 0, flw, flh );
cabsolid.alpha=255;
}

if ( my_config["enable_cab"] == "black/gray" )
{
local cabsolid = fe.add_image( "backgrounds/bkg_grayblack.png", 0, 0, flw, flh );
cabsolid.alpha=255;
}

if ( my_config["enable_cab"] == "black" )
{
local cabsolid = fe.add_image( "backgrounds/bkg_black.png", 0, 0, flw, flh );
cabsolid.alpha=255;
}

if ( my_config["enable_cab"] == "blue" )
{
local cabsolid = fe.add_image( "backgrounds/bkg_blue.png", 0, 0, flw, flh );
cabsolid.alpha=255;
}

if ( my_config["enable_cab"] == "green" )
{
local cabsolid = fe.add_image( "backgrounds/bkg_green.png", 0, 0, flw, flh );
cabsolid.alpha=255;
}

if ( my_config["enable_cab"] == "orange" )
{
local cabsolid = fe.add_image( "backgrounds/bkg_orange.png", 0, 0, flw, flh );
cabsolid.alpha=255;
}

if ( my_config["enable_cab"] == "red" )
{
local cabsolid = fe.add_image( "backgrounds/bkg_red.png", 0, 0, flw, flh );
cabsolid.alpha=255;
}

// Show the system logo wheel at the top of the screen
if ( my_config["enable_toplogo"] == "Yes" )
{
local logo = fe.add_image("systemlogo/[DisplayName]", flx*0.43, fly*0.001 flw*0.15, flh*0.1 );
}


// The following section sets up what type and wheel and displays the users choice

//vertical wheel with three wheels shown horizontal
if ( my_config["enable_list_type"] == "vert_wheel" )
{
fe.load_module( "conveyor" );
local wheel_x = [ flx*0.01, flx*0.01 flx*0.01, flx*0.01 flx*0.01, flx*0.01 flx*0.0, flx*0.01 flx*0.01, flx*0.01 flx*0.01, flx*0.01 ];
local wheel_y = [ -fly*0.22, -fly*0.205, -fly*0.006, fly*0.115, fly*0.200, fly*0.320, fly*0.420, fly*0.53, fly*0.63 fly*0.75, fly*0.85, fly*0.95, ]; 
local wheel_w = [ flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.18, flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.16, ];
local wheel_a = [  80,  80,  80,  80,  80,  80, 255,  80,  80,  80,  80,  80, ];
local wheel_h = [  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12, flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,];
local wheel_r = [  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ];
local num_arts = 8;

class WheelEntry extends ConveyorSlot
{
	constructor()
	{
		base.constructor( ::fe.add_artwork( my_config["orbit_art"] ) );
	}

	function on_progress( progress, var )
	{
		local p = progress / 0.1;
		local slot = p.tointeger();
		p -= slot;
		
		slot++;

		if ( slot < 0 ) slot=0;
		if ( slot >=10 ) slot=10;

		m_obj.x = wheel_x[slot] + p * ( wheel_x[slot+1] - wheel_x[slot] );
		m_obj.y = wheel_y[slot] + p * ( wheel_y[slot+1] - wheel_y[slot] );
		m_obj.width = wheel_w[slot] + p * ( wheel_w[slot+1] - wheel_w[slot] );
		m_obj.height = wheel_h[slot] + p * ( wheel_h[slot+1] - wheel_h[slot] );
		m_obj.rotation = wheel_r[slot] + p * ( wheel_r[slot+1] - wheel_r[slot] );
		m_obj.alpha = wheel_a[slot] + p * ( wheel_a[slot+1] - wheel_a[slot] );
	}
};

local wheel_entries = [];
for ( local i=0; i<num_arts/2; i++ )
	wheel_entries.push( WheelEntry() );

local remaining = num_arts - wheel_entries.len();

// we do it this way so that the last wheelentry created is the middle one showing the current
// selection (putting it at the top of the draw order)
for ( local i=0; i<remaining; i++ )
	wheel_entries.insert( num_arts/2, WheelEntry() );

local conveyor = Conveyor();
conveyor.set_slots( wheel_entries );
conveyor.transition_ms = 50;
try { conveyor.transition_ms = my_config["transition_ms"].tointeger(); } catch ( e ) { }
}



// Game information to show inside text box frame
if ( my_config["enable_ginfo"] == "Yes" )
{

//add frame to make text standout 
if ( my_config["enable_frame"] == "Yes" )
{
local frame = fe.add_image( "frame.png", 0, fly*0.945, flw, flh*0.1 );
frame.alpha = 255;
}


// Show the system logo next to game name
if ( my_config["enable_logo"] == "Yes" )
{
local logo = fe.add_image("systems/[Emulator]", flx*0.184, fly*0.945, flw*0.045, flh*0.05 );
}

//  slect keys movment anime
if ( my_config["enable_seletkeys"] == "Yes" )
{
::OBJECTS <- {
joy = fe.add_image("select.png", flx*0.470, fly*0.91, flw*0.30, flh*0.43 ),
}

local sprite_cfg = {
    when = When.StartLayout,
    width = 420,
    frame = 0,
    time = 2000,
    order = [0, 1],
    delay = 2000,
    loop = true
}
animation.add( SpriteAnimation( OBJECTS.joy, sprite_cfg ) );
}
//**********************


//Year text info
local texty = fe.add_text("[Year]", -flx*0.05, fly*0.95, flw*0.6, flh*0.025);
texty.set_rgb( 255, 255, 255 );
//texty.style = Style.Bold;
//texty.align = Align.Left;

//Title text info
local textt = fe.add_text( "[Title]", flx*0.23, fly*0.970, flw*0.6, flh*0.025   );
textt.set_rgb( 225, 255, 255 );
//textt.style = Style.Bold;
textt.align = Align.Left;
textt.rotation = 0;
textt.word_wrap = true;

//Emulator text info
//local textt = fe.add_text( "[Emulator]", flx*0.255, fly*0.965, flw*0.6, flh*0.025  );
//textt.set_rgb( 225, 255, 255 );
//textt.style = Style.Bold;
//textt.align = Align.Left;
//textt.rotation = 0;
//textt.word_wrap = true;

//display filter info
local filter = fe.add_text( "[ListFilterName]: [ListEntry]-[ListSize]  [PlayedCount]", flx*0.7, fly*0.975, flw*0.3, flh*0.02 );
filter.set_rgb( 255, 255, 255 );
//filter.style = Style.Italic;
filter.align = Align.Right;
filter.rotation = 0;



// random number for the RGB levels
if ( my_config["enable_colors"] == "Yes" )
{
function brightrand() {
 return 255-(rand()/255);
}

local red = brightrand();
local green = brightrand();
local blue = brightrand();

// Color Transitions
fe.add_transition_callback( "color_transitions" );
function color_transitions( ttype, var, ttime ) {
 switch ( ttype )
 {
  case Transition.StartLayout:
  case Transition.ToNewSelection:
  red = brightrand();
  green = brightrand();
  blue = brightrand();
  //listbox.set_rgb(red,green,blue);
  texty.set_rgb (red,green,blue);
  textt.set_rgb (red,green,blue);
  break;
 }
 return false;
 }
}}

}
///////////////////////////////////////




