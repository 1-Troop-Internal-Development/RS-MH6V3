/*
Set Insignia Script by Firewill
Original Script code from ArmA 3 Set Insignia Function.

how to use :
in the Model, you must have Insignia Selection.
and, write below code in init field.
[this,"InsigniaCode"] call FIR_fnc_AWS_Setinsignia;
InsigniaCode is like "TFAegis". also user made insignia is will be working. 
*/

private ["_plane","_class","_cfgTexture","_texture"];

_plane = _this select 0;
_planetype = typeof _plane;
_class = _this select 1;

if (_class == "") exitwith {false};

//--- Load texture from config.cpp or description.ext
_cfgTexture = [["CfgUnitInsignia",_class],configfile] call bis_fnc_loadclass;
if (_cfgTexture == configfile) exitwith {["'%1' not found in CfgUnitInsignia",_class] call bis_fnc_error; false};
_texture = gettext (_cfgTexture >> "texture");

private ["_index"];
_index = -1;
{
	if (_x == "insignia") exitwith {_index = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

if (_index < 0) then 
{
	_plane vehiclechat "you don't have Insignia Selection!";
}
 else 
 {
	_plane setobjecttextureglobal [_index,_texture];
};
