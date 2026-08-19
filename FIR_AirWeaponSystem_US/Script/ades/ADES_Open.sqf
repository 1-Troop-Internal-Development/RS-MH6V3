/*Loadout Dialog By Firewill*/

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

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "ADESData";
private _ADESEnabled = getNumber (_configPath >> "ADESEnabled"); if (_ADESEnabled == 0) exitWith {};
private _NumberEnabled = getNumber (_configPath >> "NumberEnabled");
private _NumberList = getArray (_configPath >> "NumberList");
private _EmblemEnabled = getNumber (_configPath >> "EmblemEnabled");
private _KillmarkEnabled = getNumber (_configPath >> "KillmarkEnabled"); 
private _NameEnabled = getNumber (_configPath >> "NameEnabled"); 
private _NameType = getText (_configPath >> "NameType");


If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};
_handle= CreateDialog "FIR_ADES_GUI";
disableSerialization;
_mydisplay = findDisplay 9918;

private _emblem_ctrl = _mydisplay displayCtrl 2101;

{
	_emblem_ctrl lbAdd getText (_x >> "displayName");
	_emblem_ctrl lbSetData [_foreachindex, getText (_x >> "texture")];

} forEach ("isClass _x" configClasses (configFile >> "CfgUnitInsignia"));

// _getPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;	
	// {
		// _emblem_ctrl lbAdd getText (_x >> "displayName");
		// _data = getText (_x >> "texture");
		// _tex_dir = _getPath + _data;			
		// _emblem_ctrl lbSetData [_foreachindex, _tex_dir];	

	// } forEach ("isClass _x" configClasses (MissionconfigFile >> "CfgUnitInsignia"));

[2102,[["Nose","decal_nose"],["Wing","decal_wing"],["Tail","decal_tail"],["Insignia","insignia"]]] call FIR_fnc_lbadd;



private _skin_ctrl = _mydisplay displayCtrl 2100;	
private _plane_type = typeof _plane;
private _ades_aircraft_type = gettext (configFile >> "CfgVehicles" >> _plane_type >> "ades_aircraft");
private _ades_type = gettext (configFile >> "CfgADES_Skin" >> _ades_aircraft_type >> "ades_type");
private _ades_classcode = gettext (configFile >> "CfgADES_Skin" >> _ades_aircraft_type >> "ades_classcode");

{
	_num = getnumber (_x >> _ades_type);
	
	if (_num == 1) then
	{
		_skin_ctrl lbAdd getText (_x >> _ades_classcode);
		_skin_ctrl lbSetData [_foreachindex, getText (_x >> _ades_classcode)];	
	};
} foreach ("isClass _x" configClasses (configFile >> "CfgVehicles"));

_font_ctrl = _mydisplay displayCtrl 2103;
	{
		_font_ctrl lbAdd getText (_x >> "name");
		_font_ctrl lbSetData [_foreachindex, getText (_x >> "fonttype")];

	} forEach ("isClass _x" configClasses (configFile >> "CfgAWS_Font"));	
	
	
_emblem_ctrl lbSetCurSel 0;	
_skin_ctrl lbSetCurSel 0;	
_font_ctrl lbSetCurSel 0;

if (_NumberEnabled == 0) then
{
	ctrlShow [1005, false ];
	ctrlShow [1400, false ];
	ctrlShow [1602, false ];
	ctrlShow [1005, false ];
	ctrlShow [1711, false ];
	ctrlShow [2103,false];
	ctrlEnable [1602, false];
};


if (_EmblemEnabled == 0) then
{
	ctrlShow [1001, false ];
	ctrlShow [1201, false ];
	ctrlShow [2101, false ];
	ctrlShow [2102, false ];
	ctrlShow [1004, false ];
	ctrlShow [1601, false ];
	ctrlShow [1913, false ];
	ctrlEnable [1601, false];
};


if (_KillmarkEnabled == 0) then
{
	ctrlShow [1707, false ];
	ctrlShow [1603, false ];
	ctrlEnable [1603, false];
};

if (_NameEnabled == 0) then
{
	ctrlShow [1709, false ];
	ctrlShow [1604, false ];
	ctrlEnable [1604, false];
};















	

	
	