/*Loadout Dialog By Firewill*/

private ["_plane","_getPath","_roundel_Array_name","_roundel_Array_data","_r_a_n_s","_r_a_d_s","_d_a_n_s","_d_a_d_s","_decal_Array_name","_decal_Array_data","_killmark_array"];

_plane = vehicle player;

If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};
_handle= CreateDialog "FIR_Killmark_GUI";
disableSerialization;
_mydisplay = findDisplay 9919;

_roundel_Array_name = [];
_roundel_Array_data = [];
_killmark_array = [];

/*roundel system*/
_roundel_ctrl = _mydisplay displayCtrl 2100;

	{
		_name = getText (_x >> "displayName");
		_data = getText (_x >> "FIR_Classcode");
		_roundel_Array_name pushback _name;
		_roundel_Array_data pushback _data;

	} forEach ("isClass _x" configClasses (configFile >> "CfgKillmarks"));
	
	_getPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;	
	{
		_name = getText (_x >> "displayName");
		_data = getText (_x >> "FIR_Classcode");
		_tex_dir = _getPath + _data;	
		_roundel_Array_name pushback _name;
		_roundel_Array_data pushback _tex_dir;

	} forEach ("isClass _x" configClasses (MissionconfigFile >> "CfgKillmarks"));
	
	_roundel_count = count _roundel_Array_name;
	
	for [{_i=0}, {_i<_roundel_count}, {_i=_i+1}] do
	{
		_r_a_n_s = _roundel_Array_name select _i;
		_r_a_d_s = _roundel_Array_data select _i;	
		_roundel_ctrl lbAdd _r_a_n_s;
		_roundel_ctrl lbSetData [_i, _r_a_d_s];		
	};	


/*kill mark array 1 = air kill 2 = soft 3 = armor 4 = total*/
_roundel_ctrl lbSetCurSel 0;	

if (isNil {profileNamespace getVariable "FIR_AWS_Killcount"}) then
{
		profileNamespace setVariable ["FIR_AWS_Killcount",[0,0,0,0]];
		_killmark_array = profileNamespace getVariable "FIR_AWS_Killcount";		
		hint "save variable";
}
else
{
		_killmark_array = profileNamespace getVariable "FIR_AWS_Killcount";		
		hint "load variable";
};

{lbAdd[2101,_x]} forEach 
[  
	"Air Kill only",
	"Ground Kill only",
	"Mixing(Air+Ground)"
];



_airkill = _killmark_array select 0;
_softkill = _killmark_array select 1;
_armorkill = _killmark_array select 2;
_totalkill = _killmark_array select 3;

_airkill_str = str(_airkill);
_softkill_str = str(_softkill);
_armorkill_str = str(_armorkill);
_totalkill_str = str(_totalkill);

ctrlSetText [1007, _airkill_str];	
ctrlSetText [1008, _softkill_str];	
ctrlSetText [1009, _armorkill_str];	
ctrlSetText [1010, _totalkill_str];	
	