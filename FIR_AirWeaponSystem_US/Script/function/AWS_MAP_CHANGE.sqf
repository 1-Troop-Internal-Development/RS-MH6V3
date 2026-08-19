private ["_plane","_class","_map_data","_map_texture","_map_size","_aircraft_pos_x","_aircraft_pos_y","_tad_move_value_x","_tad_move_value_y"];

_plane = _this select 0;
_planetype = typeof _plane;

_class = worldName;

_map_data = [["CfgAWS_MAP",_class],configfile] call bis_fnc_loadclass;
if (_map_data == configfile) exitwith {["'%1' not found in CfgAWS_MAP",_class] call bis_fnc_error; false};
_map_texture = gettext (_map_data >> "aws_mapdata");
_map_texture_real = gettext (_map_data >> "aws_mapdata_real");
_map_texture_mixed = gettext (_map_data >> "aws_mapdata_mixed");
_map_size = getnumber (_map_data >> "aws_mapsize");

private _stat = _plane getVariable ["AWS_MAP_TEXTURE_STATUS","map"];

_index = -1;
{
	if (_x == "map") exitwith {_index = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

if (_index < 0) then 
{
	_plane vehiclechat "this aircraft doesn't have Map Selection!";
}
 else 
 {
	switch (_stat) do
	{
		case "map":
		{
			_plane setobjecttextureglobal [_index,_map_texture_real];
			_plane setvariable ["AWS_MAP_TEXTURE_STATUS","sat"];
		};
		case "sat":
		{
			_plane setobjecttextureglobal [_index,_map_texture_mixed];
			_plane setvariable ["AWS_MAP_TEXTURE_STATUS","mixed"];	
		};
		case "mixed":
		{
			_plane setobjecttextureglobal [_index,_map_texture];
			_plane setvariable ["AWS_MAP_TEXTURE_STATUS","map"];	
		};		
	}; 
};
