
private ["_plane","_planetype","_name","_rank","_name_u","_namearray","_name_result","_pickname","_result","_result_rank","_name_c","_endp","_seater"];

_plane = [_this,0,objnull] call BIS_fnc_param;
_fonttype = [_this,1,"white"] call BIS_fnc_param;
_name = [_this,2,""] call BIS_fnc_param;
_rank = [_this,3,""] call BIS_fnc_param;
_name_start = [_this,4,"name_1"] call BIS_fnc_param;
_name_end = [_this,5,"name_10"] call BIS_fnc_param;
_rank_start = [_this,6,"rank_tag"] call BIS_fnc_param;

_planetype = typeof _plane;

_font_data = [["CfgAWS_Font",_fonttype],configfile] call bis_fnc_loadclass;
_prefix = gettext (_font_data >> "prefix");
_num = "";
_subfix = ".paa";

_pickname = "";
_result = "";
_result_rank = "";

private ["_index1","_index10","_rank_index"];
_index1 = -1;
{
	if (_x == _name_start) exitwith {_index1 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

_index10 = -1;
{
	if (_x == _name_end) exitwith {_index10 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

for [{_i=_index1}, {_i<=_index10}, {_i=_i+1}] do
{
	_plane setObjectTextureGlobal [_i,""];				
};

_rank_index = -1;
{
if (_x == _rank_start) exitwith {_rank_index= _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");
_plane setObjectTextureGlobal [_rank_index,""];	

_namearray = toArray(_name);
_name_result = [];
_name_c = (count _namearray - 1);

if ((count _namearray) > 10) exitWith{hintsilent "OVER 10!"};

for "_i" from 0 to (count _namearray - 1) do
{
	_name_result = _name_result + [toString([_namearray select _i])];
};

if (_name == "") then
{
	for [{_i=_index1}, {_i<=_index10}, {_i=_i+1}] do
	{
		_plane setObjectTextureGlobal [_i,""];		
	};
}
else
{
	_num = 0;
	_endp = _index1 + _name_c;
	for [{_i=_index1}, {_i<=_endp}, {_i=_i+1}] do
	{
		_pickname = _name_result select _num;
		
			_result = _prefix + _pickname + _subfix;
			_plane setObjectTextureGlobal [_i,_result];				
			_num = _num + 1;		

	};
};

if (_rank == "") then
{
	_plane setObjectTextureGlobal [_rank_index,""];		
}
else
{
	_result_rank = _prefix + _rank + _subfix;
	_plane setObjectTextureGlobal [_rank_index,_result_rank];		
};
