
private _plane = "";
private _planetype = "";

private _UAV = getConnectedUAV player;

//if not UAV
if (_UAV isEqualTo objNull) then
{
	_plane = vehicle player;
	_plane_pilot = driver _plane;
}
else
{
// if UAV and MQ-81U only

		_plane = _UAV;	
		_plane_pilot = player;		
};

private _name = ctrlText 1400;
private _font_color_get = lbData [2103,(lbCurSel 2103)];

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "ADESData";
private _ADESEnabled = getNumber (_configPath >> "ADESEnabled"); if (_ADESEnabled == 0) exitWith {};
private _NumberEnabled = getNumber (_configPath >> "NumberEnabled");
private _NumberList = getArray (_configPath >> "NumberList");
private _EmblemEnabled = getNumber (_configPath >> "EmblemEnabled");
private _KillmarkEnabled = getNumber (_configPath >> "KillmarkEnabled"); 
private _NameEnabled = getNumber (_configPath >> "NameEnabled"); 
private _NameType = getText (_configPath >> "NameType");


_name_start = _NumberList select 0;
_name_end = _NumberList select 2;

_planetype = typeof _plane;

_font_data = [["CfgAWS_Font",_font_color_get],configfile] call bis_fnc_loadclass;
_prefix = gettext (_font_data >> "prefix");
_num = "";
_subfix = ".paa";

_pickname = "";
_result = "";
_result_rank = "";

private ["_index1","_index3","_rank_index"];
_index1 = -1;
{
	if (_x == _name_start) exitwith {_index1 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

_index3 = -1;
{
	if (_x == _name_end) exitwith {_index3 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

for [{_i=_index1}, {_i<=_index3}, {_i=_i+1}] do
{
	_plane setObjectTextureGlobal [_i,""];				
};

_namearray = toArray(_name);
_name_result = [];
_name_c = (count _namearray - 1);

if ((count _namearray) > 3) exitWith{hintsilent "OVER 3!"};

for "_i" from 0 to (count _namearray - 1) do
{
	_name_result = _name_result + [toString([_namearray select _i])];
};

if (_name == "") then
{
	for [{_i=_index1}, {_i<=_index3}, {_i=_i+1}] do
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
