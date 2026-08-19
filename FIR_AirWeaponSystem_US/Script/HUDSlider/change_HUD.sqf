/*Loadout Dialog By Firewill*/

private ["_plane","_planetype","_get_code","_codename","_texture_array","_tex1","_tex2","_tex3","_tex4","_tex5","_tex6","_texture_name"];

_plane = vehicle player;
_planetype = typeof _plane;

If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};

_array = _plane getVariable "AWS_HUD";

_red = _array select 0;
_green = _array select 1;
_blue = _array select 2;
_alpha = _array select 3;

_red_pos = sliderPosition 1900;
_green_pos = sliderPosition 1901;
_blue_pos = sliderPosition 1902;
_alpha_pos = sliderPosition 1903;

_red_value = _red_pos / 100;
_green_value = _green_pos / 100;
_blue_value = _blue_pos / 100;
_alpha_value = _alpha_pos / 100;

_plane setUserMFDvalue [_red, _red_value];
_plane setUserMFDvalue [_green, _green_value];
_plane setUserMFDvalue [_blue, _blue_value];
_plane setUserMFDvalue [_alpha, _alpha_value];

_plane setVariable ["AWS_HCS_RED",_red_pos,true];	
_plane setVariable ["AWS_HCS_GREEN",_green_pos,true];	
_plane setVariable ["AWS_HCS_BLUE",_blue_pos,true];	
_plane setVariable ["AWS_HCS_ALPHA",_alpha_pos,true];	