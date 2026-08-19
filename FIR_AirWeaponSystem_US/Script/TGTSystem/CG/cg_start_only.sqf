//Command Guidance system based on nuxil's Tvs script. all credit goes to nuxil who created the original Tvs script.

private _missile = _this select 0;
private _plane = _this select 1;
private _ammoname = _this select 2;
private _whoShot = _this select 3;
private _mode = _this select 4;

private _flag = 0;

if (_whoShot != player) exitWith{};

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
