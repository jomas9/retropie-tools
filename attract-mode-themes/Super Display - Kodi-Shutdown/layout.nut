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
   </ label="Select listbox, wheel, vert_wheel", help="Select wheel type or listbox", options="vert_wheel", order=4 /> enable_list_type="vert_wheel";
   </ label="Select spinwheel art", help="The artwork to spin", options="wheel", order=5 /> orbit_art="wheel";
   </ label="Wheel transition time", help="Time in milliseconds for wheel spin.", order=6 /> transition_ms="25";  
</ label=" ", help=" ", options=" ", order=7 /> divider1="";
</ label="--------    Extra images     --------", help="Show or hide additional images", order=8 /> uct2="select below";
   </ label="Enable box art", help="Select box art", options="Yes,No", order=9 /> enable_gboxart="Yes"; 
   </ label="Enable cartridge art", help="Select cartridge art", options="Yes,No", order=10 /> enable_gcartart="Yes"; 
</ label=" ", help=" ", options=" ", order=19 /> divider3="";
</ label="--------   Emulator frame    --------", help="Enable or disable emulator frame", order=20 /> uct4="select below";
   </ label="Enable emulator bezel", help="Enable or disable game video preview bezel", options="Yes,No", order=21 /> enable_bezels="Yes"; 
</ label=" ", help=" ", options=" ", order=22/> divider4="";
</ label="--------    Game info box    --------", help="Show or hide game info box", order=23 /> uct5="select below";
   </ label="Enable game information", help="Show game information", options="Yes,No", order=24 /> enable_ginfo="Yes";
   </ label="Enable wheel frame", help="Show dark frame behind wheel", options="Yes,No", order=25 /> enable_frame="No"; 
</ label=" ", help=" ", options=" ", order=26 /> divider5="";
</ label="--------    Miscellaneous    --------", help="Miscellaneous options", order=27 /> uct6="select below";
   </ label="Enable random text colors", help=" Select random text colors.", options="Yes,No", order=28 /> enable_colors="No";
   </ label="Enable monitor static effect", help="Show static effect when snap is null", options="Yes,No", order=32 /> enable_static="Yes"; 
}  

local my_config = fe.get_config();
local flx = fe.layout.width=640;
local fly = fe.layout.height=480;
local flw = fe.layout.width;
local flh = fe.layout.height;
//fe.layout.font="Roboto";

// modules
fe.load_module("fade");
fe.load_module( "animate" );


// Video Preview or static video if none available
// remember to make both sections the same dimensions and size
if ( my_config["enable_static"] == "Yes" )
{
//adjust the values below for the static preview video snap
   const SNAPBG_ALPHA = 200;
   local snapbg=null;
   snapbg = fe.add_image( "static.mp4", flx*0.365, fly*0.244, flw*0.48, flh*0.493);
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
 local temp = fe.add_text("", flx*0.545, fly*0.224, flw*0.37, flh*0.50 );
 temp.bg_alpha = SNAPBG_ALPHA;
 }

// The following sets up which bezelto show on the wheel
//property animation - wheel bezel
if ( my_config["enable_bezels"] == "Yes") 
{

 
//create surface for snap
local surface_snap = fe.add_surface( 640, 480 );
local snap = FadeArt("snap", 0, 0, 640, 480, surface_snap);
snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = false;

//now position and pinch surface of snap
//adjust the below values for the game video preview snap
surface_snap.set_pos(flx*0.422, fly*0.244, flw*0.361, flh*0.493);
surface_snap.skew_y = 0;
surface_snap.skew_x = 0;
surface_snap.pinch_y = 0;
surface_snap.pinch_x = 0;
surface_snap.rotation = 0;

// Load background based up emulator
local b_art = fe.add_image("backgrounds/Display Menu.png", 0, 0, flw, flh );
b_art.alpha=255;

{
local point = fe.add_image("bezels/[Emulator]", flx*0.36, fly*0.244, flw*0.485, flh*0.495 );

}

}


if ( my_config["enable_bezels"] == "No") 
{{
 local point = fe.add_image( "", 0, 0, 0, 0 );

}
 
//create surface for snap
local surface_snap = fe.add_surface( 640, 480 );
local snap = FadeArt("snap", 0, 0, 640, 480, surface_snap);
snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = false;

//now position and pinch surface of snap
//adjust the below values for the game video preview snap
surface_snap.set_pos(flx*0.365, fly*0.242, flw*0.48, flh*0.495);
surface_snap.skew_y = 0;
surface_snap.skew_x = 0;
surface_snap.pinch_y = 0;
surface_snap.pinch_x = 0;
surface_snap.rotation = 0;

// Load background based up emulator
local b_art = fe.add_image("backgrounds/Display Menu Full.png", 0, 0, flw, flh );
b_art.alpha=255;


}



// Box art to dipslay, uses the emulator.cfg path for boxart image location
if ( my_config["enable_gboxart"] == "Yes" )
::OBJECTS <- {
 fanart = fe.add_artwork("fanart", flx*0.71, fly*0.78, flw*0.15, flh*0.2 ),
}

if ( my_config["enable_gboxart"] == "Yes" )
{
//Animation for Global & Expert Mode
local move_transition1 = {
  when = Transition.ToNewSelection ,property = "y", start = fly*2, end = fly*0.78, time = 1000
}
//Animation
animation.add( PropertyAnimation( OBJECTS.fanart, move_transition1 ) );
}

// Load background based up emulator
local b_art = fe.add_image("backgrounds/[DisplayName]", 0, 0, flw, flh );
b_art.alpha=255;

// Box art to dipslay, uses the emulator.cfg path for boxart image location
if ( my_config["enable_gboxart"] == "Yes" )
::OBJECTS <- {
 boxart = fe.add_artwork("boxart", flx*0.43, fly*0.78, flw*0.1, flh*0.17),
}

if ( my_config["enable_gboxart"] == "Yes" )
{
//Animation for Global & Expert Mode
local move_transition1 = {
  when = Transition.ToNewSelection ,property = "y", start = fly*2, end = fly*0.78, time = 1000
}
//Animation
animation.add( PropertyAnimation( OBJECTS.boxart, move_transition1 ) );
}

// Cartridge art to display, uses the emulator.cfg path for cartart for cartridge image location
if ( my_config["enable_gcartart"] == "Yes" )
::OBJECTS <- {
 cartart = fe.add_artwork("cartart", flx*0.51, fly*0.86, flw*0.07, flh*0.08 ),
}

if ( my_config["enable_gcartart"] == "Yes" )
{
//Animation for Global & Expert Mode
local move_transition1 = {
  when = Transition.ToNewSelection ,property = "y", start = fly*2, end = fly*0.86, time = 1100
}
//Animation
animation.add( PropertyAnimation( OBJECTS.cartart, move_transition1 ) );
}

// Game information to show inside text box frame
if ( my_config["enable_ginfo"] == "Yes" )
{

//add frame to make text standout 
if ( my_config["enable_frame"] == "Yes" )
{
local frame = fe.add_image( "frame.png", 0, 0, flw, flh );
frame.alpha = 255;
}

// The following section sets up what type and wheel and displays the users choice
//listbox
if ( my_config["enable_list_type"] == "listbox" )
{
local sort_listbox = fe.add_listbox( 176, 96, 45, 202 );
sort_listbox.rows = 13;
sort_listbox.charsize = 10;
sort_listbox.set_rgb( 0, 0, 0 );
sort_listbox.format_string = "[SortValue]";
sort_listbox.bg_alpha=255;
sort_listbox.visible = false;

local listbox = fe.add_listbox(flx*0.56, fly*0.12, flw*0.41, flh*0.8 );
listbox.rows = 13;
listbox.charsize = 18;
listbox.set_rgb( 255, 255, 255 );
listbox.bg_alpha = 90;
listbox.align = Align.Left;
listbox.selbg_alpha = 90;
listbox.sel_red = 255;
listbox.sel_green = 255;
listbox.sel_blue = 0;
}

//This enables vertical art instead of default wheel
if ( my_config["enable_list_type"] == "vert_wheel" )
{
fe.load_module( "conveyor" );
local wheel_x = [ flx*0.01, flx*0.01 flx*0.01, flx*0.01 flx*0.01, flx*0.01 flx*0.0, flx*0.01 flx*0.01, flx*0.01 flx*0.01, flx*0.01 ];
local wheel_y = [ -fly*0.22, -fly*0.205, -fly*0.006, fly*0.115, fly*0.200, fly*0.320, fly*0.420, fly*0.53, fly*0.63 fly*0.75, fly*0.85, fly*0.95, ]; 
local wheel_w = [ flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.18, flw*0.16, flw*0.16, flw*0.16, flw*0.16, flw*0.16, ];
local wheel_a = [  80,  80,  80,  80,  80,  80, 255,  80,  80,  80,  80,  80, ];
local wheel_h = [  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12, flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,  flh*0.12,];
local wheel_r = [  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ];
local num_arts = 0;

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
 
if ( my_config["enable_list_type"] == "wheel" )
{
fe.load_module( "conveyor" );
local wheel_x = [ flx*0.80, flx*0.795, flx*0.756, flx*0.725, flx*0.70, flx*0.68, flx*0.64, flx*0.68, flx*0.70, flx*0.725, flx*0.756, flx*0.76, ]; 
local wheel_y = [ -fly*0.22, -fly*0.105, fly*0.0, fly*0.105, fly*0.215, fly*0.325, fly*0.436, fly*0.61, fly*0.72 fly*0.83, fly*0.935, fly*0.99, ];
local wheel_w = [ flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.24, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, ];
local wheel_a = [  80,  80,  80,  80,  80,  80, 255,  80,  80,  80,  80,  80, ];
local wheel_h = [  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, flh*0.17,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, ];
local wheel_r = [  30,  25,  20,  15,  10,   5,   0, -10, -15, -20, -25, -30, ];
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




//Year text info
local texty = fe.add_text("[Year]", flx*0.32, fly*0.89, flw*0.13, flh*0.055 );
texty.set_rgb( 255, 255, 255 );
//texty.style = Style.Bold;
//texty.align = Align.Left;

//Title text info
local textt = fe.add_text( "[Title]", flx*0.345, fly*0.945, flw*0.6, flh*0.025  );
textt.set_rgb( 225, 255, 255 );
//textt.style = Style.Bold;
textt.align = Align.Left;
textt.rotation = 0;
textt.word_wrap = true;

//display filter info
local filter = fe.add_text( "[ListFilterName]: [ListEntry]-[ListSize]  [PlayedCount]", flx*0.57, fly*0.975, flw*0.3, flh*0.02 );
filter.set_rgb( 255, 255, 255 );
//filter.style = Style.Italic;
filter.align = Align.Right;
filter.rotation = 0;

//Emulator text info
local textemu = fe.add_text( "[Emulator]", flx*0.345, fly*0.97, flw*0.6, flh*0.025  );
textemu.set_rgb( 225, 255, 255 );
//textemu.style = Style.Bold;
textemu.align = Align.Left;
textemu.rotation = 0;
textemu.word_wrap = true;

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


///////////////////////////////////////

