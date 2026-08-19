//Command Guidance system based on nuxil's Tvs script. all credit goes to nuxil who created the original Tvs script.

private _missile = _this select 0;
private _plane = _this select 1;
private _ammoname = _this select 2;
private _whoShot = _this select 3;
private _mode = _this select 4;

private _flag = 0;

if (_whoShot != player) exitWith{};

// _check = _plane getvariable "ITGT_NEW";

// if (_check != "no") ExitWith {systemChat "GPS RELATED MODE ENABLED";};

	
private _pylon = GetPylonMagazines _plane;
private _pylon_count = count _pylon;

private _cg_mode = getText (configFile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_CG_Type");

if (_cg_mode == "pod") then
{
	for "_y" from 0 to _pylon_count-1 do
	{
		private _mag = _pylon select _y;
		private _acmi = getNumber (configFile >> "CfgMagazines" >> _mag >> "AWS_CG_DLP");

		if (_acmi isEqualTo 1) then
		{
			_flag = 1;
		};
	}; 		
}
else
{
	_flag = 1;
};

// private _cg_check = _plane getvariable ["ITGT_TYPE","GPS"];

if (_mode != "CG" or _flag == 0) exitWith {};

systemChat "COMMAND GUIDANCE INITIATED";

createDialog "FIR_AWS_Nux_tvs_Dialog";
waituntil{(dialog)};

disableSerialization;
_mydisplay = findDisplay 8560;

// center the mouse cursor
setMousePosition [0.5,0.5];

// Switch to the missile.
_missile switchCamera "Internal";	

// set the state of thermal info..
_thermalmode = "VIS MODE:DTV";
switch (_plane getvariable "FIR_AWS_Nux_tvs_thermal") do {
	case 0 : {false setCamUseTi 0;camUseNVG false;_thermalmode = "VIS MODE:DTV";};
	case 1 : {false setCamUseTi 0;camUseNVG true; _thermalmode = "VIS MODE:NV";};	
	case 2 : {true setCamUseTi 0;camUseNVG false;_thermalmode = "VIS MODE:WHOT";};
	case 3 : {true setCamUseTi 1;camUseNVG false;_thermalmode = "VIS MODE:BHOT";};
	case 4 : {true setCamUseTi 2;camUseNVG false;_thermalmode = "VIS MODE:GHOT/DGC";};
	case 5 : {true setCamUseTi 3;camUseNVG false;_thermalmode = "VIS MODE:BHOT/DGC";};
};
((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8565) ctrlSetText format["%1",_thermalmode];
((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8565) ctrlCommit 0;			

_missile spawn FIR_fnc_AWS_Nux_tvs_compass;
[_plane, _missile] spawn FIR_fnc_AWS_Nux_tvs_missilecontrol;
