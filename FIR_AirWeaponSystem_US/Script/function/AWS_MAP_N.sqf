private ["_plane","_class","_map_data","_map_texture","_map_size","_aircraft_pos_x","_aircraft_pos_y","_tad_move_value_x","_tad_move_value_y"];

_plane = _this select 0;
_planetype = typeof _plane;

_class = worldName;

_map_data = [["CfgAWS_MAP",_class],configfile] call bis_fnc_loadclass;
if (_map_data == configfile) exitwith {["'%1' not found in CfgAWS_MAP",_class] call bis_fnc_error; false};
_map_texture = gettext (_map_data >> "aws_mapdata");
_map_size = getnumber (_map_data >> "aws_mapsize");


private ["_index","_index2"];
_index = -1;
{
	if (_x == "map") exitwith {_index = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

if (_index < 0) then 
{
	_plane vehiclechat "this aircraft dosn't have Map Selection!";
}
 else 
 {
	_plane setobjecttextureglobal [_index,_map_texture];
};

_index2 = -1;
{
	if (_x == "mfd_overlay2") exitwith {_index2 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");
	
_get_overlay = getText (configFile >> "CfgVehicles" >> _planetype >> "AWS_MFD_OVERLAY_TAD");

_plane setObjectTextureGlobal [_index2,_get_overlay];

while {alive _plane and _plane getvariable "AWS_MAP_STATUS" == "yes" and (driver _plane != objnull)} do
{
		_aircraft_pos_x = getpos _plane select 0;
		_aircraft_pos_y = getpos _plane select 1;
		
		_aircraft_pos_x = floor _aircraft_pos_x;
		_aircraft_pos_y = floor _aircraft_pos_y;

		_tad_move_value_x = _aircraft_pos_x /_map_size;
		_tad_move_value_y = _aircraft_pos_y /_map_size;

		_plane animatesource ["tad_move_x",_tad_move_value_x];
		_plane animatesource ["tad_move_y",_tad_move_value_y];

	// sleep 0.03;
};

_plane setobjecttextureglobal [_index,""];
_plane setobjecttextureglobal [_index2,""];