////////////////////////////////////////////////////////////////////////////////////////////////////////
// Updated 4/11/2016 by omegaman                                                                      //
// Attract-Mode "Robospin" layout. Thanks to verion for cleaning cab skins                            //
// Notes: Implemented crhisv's pan-and-scan module. Added, game and gategory logos, cometic changes.  //
// Thanks to malfacine's for glogos code                                                                  //
////////////////////////////////////////////////////////////////////////////////////////////////////////   

class UserConfig {
   </ label="Select bg image or panscan", help="Select bg image or panscan art(flyer)", options="blue,retro,panscan", order=1 /> enable_image="blue";   
   </ label="Select cab skin", help="Select a cab skin image", options="robo,moon", order=2 /> enable_cab="robo";
   </ label="Select spinwheel art", help="The artwork to spin", options="marquee, wheel", order=3 /> orbit_art="wheel";
   </ label="Select vertart instead of wheel", help="Select vertical or wheel art", options="Yes,No", order=4 /> enable_VertArt="No";
   </ label="Enable snap static effect", help="Show static effect when snap is null", options="yes,no", order=5 /> enable_static="yes"; 
   </ label="Enable snap bloom shader effect", help="Bloom effect uses shader", options="Yes,No", order=6 /> enable_bloom="No";
   </ label="Enable crt shader effect", help="CRT effect uses shader)", options="Yes,No", order=7 /> enable_crt="No";
   </ label="Enable random Text Colors", help=" Select random text colors.", options="yes,no", order=9 /> enable_colors="yes";
   </ label="Transition Time", help="Time in milliseconds for wheel spin.", order=10 /> transition_ms="25";
   </ label="Enable system logos", help="Select system logos", options="Yes,No", order=11 /> enable_slogos="Yes"; 
   </ label="Enable marquees", help="Show marquees", options="Yes,No", order=12 /> enable_marquee="Yes";
   </ label="Enable lighted marquee effect", help="show lighted Marquee", options="Yes,No", order=13 /> enable_Lmarquee="Yes";
   </ label="Select pointer", help="Select animated pointer", options="rocket,hand,none", order=14 /> enable_pointer="rocket"; 
   </ label="Enable text frame", help="Show text frame", options="yes,no", order=15 /> enable_frame="yes"; 
   </ label="Enble background Scanline", help="Show scanline effect", options="none,light,medium,dark", order=17 /> enable_scanline="none";
   </ label="Enable MFR game logos", help="Select game logos", options="Yes,No", order=18 /> enable_mlogos="Yes";
}  

local my_config = fe.get_config();
local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;
fe.layout.font="Impact";

// modules
fe.load_module( "animate" );
fe.load_module( "pan-and-scan" );

// Select background or pan-and-scan 
if ( my_config["enable_image"] == "blue") 
{
local bg = fe.add_image( "bkg.png", 0, 0, flw, flh );
bg.alpha=255;
}

if ( my_config["enable_image"] == "retro")
{
local bg = fe.add_image( "bkg2.png", 0, 0, flw, flh );
bg.alpha=255;
}

if ( my_config["enable_image"] == "panscan") 
{
local bgart = PanAndScanArt( "flyer", 0, 0, flw, flh);
bgart.trigger = Transition.EndNavigation;
bgart.preserve_aspect_ratio = false;
bgart.set_fit_or_fill("fill");
bgart.set_anchor(::Anchor.Center);
bgart.set_zoom(4.5, 0.00008);
bgart.set_animate(::AnimateType.Bounce, 0.50, 0.50)
bgart.set_randomize_on_transition(true);
bgart.set_start_scale(1.1);
 local alpha_cfg = {
    when = Transition.ToNewSelection,
    property = "alpha",
    start = 0,
    end = 200,
    time = 3000
}
animation.add( PropertyAnimation( bgart, alpha_cfg ) );
}

//scanline effect overlay for bg art
if ( my_config["enable_scanline"] == "none" )
{
local scanline = fe.add_image( "", 0, 0, flw, flh );
}

if ( my_config["enable_scanline"] == "light" )
{
local scanline = fe.add_image( "scan.png", 0, 0, flw, flh );
scanline.preserve_aspect_ratio = false;
scanline.alpha = 100;
}

if ( my_config["enable_scanline"] == "medium" )
{
local scanline = fe.add_image( "scan.png", 0, 0, flw, flh );
scanline.preserve_aspect_ratio = false;
scanline.alpha = 200;
}

if ( my_config["enable_scanline"] == "dark" )
{
local scanline = fe.add_image( "scan.png", 0, 0, flw, flh );
scanline.preserve_aspect_ratio = false;
scanline.alpha = 255;
}

//static effect for cab monitor when no snap
const SNAPBG_ALPHA = 200;
local snapbg=null;
if ( my_config["enable_static"] == "yes" )
{
	snapbg = fe.add_image(
		"static.mp4", flx*0.042, fly*0.24, flw*0.312, flh*0.43);
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
	local temp = fe.add_text("", 224, 59, 352, 264 );
	temp.bg_alpha = SNAPBG_ALPHA;
}

//create surface for snap
local surface = fe.add_surface( 640, 480 );
local snap = surface.add_artwork("snap", 0, 0, 640, 480);
snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = false;

//now position and pinch the surface
surface.set_pos(flx*0.065, fly*0.24, flw*0.262, flh*0.43);
surface.skew_y = 0;
surface.skew_x = 0;
surface.pinch_y = 0;
surface.pinch_x = 0;
surface.rotation = 0;

// add shader support because I can
if ( my_config["enable_bloom"] == "Yes" )
{
    local sh = fe.add_shader( Shader.Fragment, "bloom_shader.frag" );
	sh.set_texture_param("bgl_RenderedTexture"); 
	surface.shader = sh;
}

if ( my_config["enable_crt"] == "Yes" )
{
    local sh = fe.add_shader( Shader.VertexAndFragment, "crt.vert", "crt.frag" );
	sh.set_param( "rubyInputSize", 640, 480 );
    sh.set_param( "rubyOutputSize", ScreenWidth, ScreenHeight );
    sh.set_param( "rubyTextureSize", 640, 480 );
	sh.set_texture_param("rubyTexture"); 
	surface.shader = sh;
}

if ( my_config["enable_marquee"] == "Yes" )
{
local marquee = fe.add_artwork("marquee", flx*0.117, fly*0.086, flw*0.35, flh*0.14 );
 marquee.trigger = Transition.EndNavigation;
 marquee.skew_x = 11;
 marquee.pinch_x = -2;
 marquee.pinch_y = 3;
 marquee.rotation = -1.5;
   if ( my_config["enable_Lmarquee"] == "Yes" )
{
    local shader = fe.add_shader( Shader.Fragment "bloom_shader.frag" );
	shader.set_texture_param("bgl_RenderedTexture"); 
	marquee.shader = shader;
}

}
 else
 {
local user = fe.add_image("user.jpg", flx*0.117, fly*0.086, flw*0.35, flh*0.14 );
 user.trigger = Transition.EndNavigation;
 user.skew_x = 11;
 user.pinch_x = -2;
 user.pinch_y = 3;
 user.rotation = -1.5;
}

//cabinet image
if ( my_config["enable_cab"] == "robo" )
{
 local cab = fe.add_image( "robo.png", 0, 0, flw, flh );
}

if ( my_config["enable_cab"] == "moon" )
{
  local cab = fe.add_image( "moon.png", 0, 0, flw, flh );
} 

//add frame to make text standout 
if ( my_config["enable_frame"] == "yes" )
{
local frame = fe.add_image( "frame.png", 0, fly*0.94, flw, flh*0.05 );
frame.alpha = 255;
}

//Year text info
local texty = fe.add_text("[Year]", flx*0.18, fly*0.937, flw*0.13, flh*0.055 );
texty.set_rgb( 255, 255, 255 );
//texty.style = Style.Bold; 
//texty.align = Align.Left;

//Title text info
local textt = fe.add_text( "[Title]", flx*0.33, fly*0.96, flw*0.6, flh*0.03  );
textt.set_rgb( 225, 255, 255 );
//textt.style = Style.Bold; 
textt.align = Align.Left;
textt.rotation = 0;
textt.word_wrap = true;

//display filter info
local filter = fe.add_text( "[ListFilterName]: [ListEntry]-[ListSize]  [PlayedCount]", flx*0.7, fly*0.97, flw*0.3, flh*0.02 );
filter.set_rgb( 255, 255, 255 );
//filter.style = Style.Italic;
filter.align = Align.Right;
filter.rotation = 0;

//Show how many times games have been played
//local play = fe.add_text( "[PlayedCount]", flx*0.796, fly*0.94, flw*0.2, flh*0.018 );
//play.set_rgb( 255, 255, 255 );
//play.align = Align.Right;   

//This enables vertical art instead of default wheel
if ( my_config["enable_VertArt"] == "Yes") 
{
fe.load_module( "conveyor" );
local wheel_x = [ flx*0.71, flx*0.71, flx*0.71, flx*0.71, flx*0.71, flx*0.71, flx*0.66, flx*0.71, flx*0.71, flx*0.71, flx*0.71, flx*0.71, ]; 
local wheel_y = [ -fly*0.22, -fly*0.105, fly*0.0, fly*0.105, fly*0.215, fly*0.325, fly*0.436, fly*0.61, fly*0.72 fly*0.83, fly*0.935, fly*0.99, ];
local wheel_w = [ flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.28, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, ];
local wheel_a = [  80,  80,  80,  80,  80,  80, 255,  80,  80,  80,  80,  80, ];
local wheel_h = [  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, flh*0.168,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, ];
local wheel_r = [  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ];
local num_arts = 12;

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
 else
{
fe.load_module( "conveyor" );
local wheel_x = [ flx*0.80, flx*0.795, flx*0.756, flx*0.725, flx*0.70, flx*0.68, flx*0.63, flx*0.68, flx*0.70, flx*0.725, flx*0.756, flx*0.76, ]; 
local wheel_y = [ -fly*0.22, -fly*0.105, fly*0.0, fly*0.105, fly*0.215, fly*0.325, fly*0.436, fly*0.61, fly*0.72 fly*0.83, fly*0.935, fly*0.99, ];
local wheel_w = [ flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.28, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, ];
local wheel_a = [  80,  80,  80,  80,  80,  80, 255,  80,  80,  80,  80,  80, ];
local wheel_h = [  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, flh*0.168,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, ];
//local wheel_r = [  31,  26,  21,  16,  11,   6,   0, -11, -16, -21, -26, -31, ];
local wheel_r = [  30,  25,  20,  15,  10,   5,   0, -10, -15, -20, -25, -30, ];
local num_arts = 10;

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

//property animation - wheel pointers
if ( my_config["enable_pointer"] == "rocket") 
{
local point = fe.add_image("pointers/pointer.png", flx*0.88, fly*0.34, flw*0.2, flh*0.35);

local alpha_cfg = {
    when = Transition.ToNewSelection,
    property = "alpha",
    start = 110,
    end = 255,
    time = 300
}
animation.add( PropertyAnimation( point, alpha_cfg ) );

local movey_cfg = {
    when = Transition.ToNewSelection,
    property = "y",
    start = point.y,
    end = point.y,
    time = 200
}
animation.add( PropertyAnimation( point, movey_cfg ) );

local movex_cfg = {
    when = Transition.ToNewSelection,
    property = "x",
    start = flx*0.83,
    end = point.x,
    time = 200	
}	
animation.add( PropertyAnimation( point, movex_cfg ) );
}

if ( my_config["enable_pointer"] == "hand") 

 {
 local point = fe.add_image("pointers/pointer2.png", flx*0.88, fly*0.34, flw*0.2, flh*0.35);
 local alpha_cfg = {
    when = Transition.ToNewSelection,
    property = "alpha",
    start = 110,
    end = 255,
    time = 300
}
animation.add( PropertyAnimation( point, alpha_cfg ) );

local movey_cfg = {
    when = Transition.ToNewSelection,
    property = "y",
    start = point.y,
    end = point.y,
    time = 200
}
animation.add( PropertyAnimation( point, movey_cfg ) );

local movex_cfg = {
    when = Transition.ToNewSelection,
    property = "x",
    start = flx*0.83,
    end = point.x,
    time = 200	
}	
animation.add( PropertyAnimation( point, movex_cfg ) );
}

if ( my_config["enable_pointer"] == "none") 
{
 local point = fe.add_image( "", 0, 0, 0, 0 );
}

//category icons 

local glogo1 = fe.add_image("glogos/unknown1.png", flx*0.12, fly*0.943, flw*0.045, flh*0.045);
glogo1.trigger = Transition.EndNavigation;

class GenreImage1
{
    mode = 1;       //0 = first match, 1 = last match, 2 = random
    supported = {
        //filename : [ match1, match2 ]
        "action": [ "action" ],
        "adventure": [ "adventure" ],
        "fighting": [ "fighting", "fighter", "beat'em up" ],
        "platformer": [ "platformer", "platform" ],
        "puzzle": [ "puzzle" ],
        "maze": [ "maze" ],
		"paddle": [ "paddle" ],
		"rhythm": [ "rhythm" ],
		"pinball": [ "pinball" ],
		"racing": [ "racing", "driving" ],
        "rpg": [ "rpg", "role playing", "role-playing" ],
        "shooter": [ "shooter", "shmup" ],
        "sports": [ "sports", "boxing", "golf", "baseball", "football", "soccer" ],
        "strategy": [ "strategy"]
    }

    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local cat = " " + fe.game_info(Info.Category, var).tolower();
            local matches = [];
            foreach( key, val in supported )
            {
                foreach( nickname in val )
                {
                    if ( cat.find(nickname, 0) ) matches.push(key);
                }
            }
            if ( matches.len() > 0 )
            {
                switch( mode )
                {
                    case 0:
                        ref.file_name = "glogos/" + matches[0] + "1.png";
                        break;
                    case 1:
                        ref.file_name = "glogos/" + matches[matches.len() - 1] + "1.png";
                        break;
                    case 2:
                        local random_num = floor(((rand() % 1000 ) / 1000.0) * ((matches.len() - 1) - (0 - 1)) + 0);
                        ref.file_name = "glogos/" + matches[random_num] + "1.png";
                        break;
                }
            } else
            {
                ref.file_name = "glogos/unknown1.png";
            }
        }
    }
}
GenreImage1(glogo1);


//System Logos
if ( my_config["enable_slogos"] == "Yes")  
{
local slogos = fe.add_image("slogos/[Emulator]", flx*0.001, fly*0.18, flw*0.11, flh*0.05 );
slogos.trigger = Transition.EndNavigation;
slogos.rotation = -15; 
}		


//Game MFR Logos
if ( my_config["enable_mlogos"] == "Yes")  
{
local mlogos = fe.add_image("mlogos/[Manufacturer]", flx*0.01, fly*0.942, flw*0.06, flh*0.045 );
mlogos.trigger = Transition.EndNavigation;
}		

// random number for the RGB levels
if ( my_config["enable_colors"] == "yes" )
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
  //play.set_rgb  (red,green,blue);
  filter.set_rgb(red,green,blue);
  texty.set_rgb (red,green,blue);
  //textc.set_rgb (red,green,blue);
  textt.set_rgb (red,green,blue);
  break;
 }
 return false;
}
}

//Are we done yet?