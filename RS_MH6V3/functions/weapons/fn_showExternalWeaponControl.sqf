params [
	["_vehicle", objNull]
];

if (!hasInterface) exitWith {};

if (isNull _vehicle) then {
	_vehicle = vehicle player;
};

if (!isNull _vehicle && {!(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"])}) then {
	_vehicle = objNull;
};

private _izlidOn = false;
private _izlidMode = 3;
if (!isNull _vehicle && {_vehicle isKindOf "RHS_MELB_AH6M"}) then {
	_izlidOn = _vehicle getVariable ["RS_MH6V3_izlidEnabled", false];
	_izlidMode = _vehicle getVariable ["RS_MH6V3_izlidMode", 3];
};

private _quickFireArmed = if (isNull _vehicle) then {
	false
} else {
	_vehicle getVariable ["RS_MH6V3_quickFireArmed", false]
};

"RS_MH6V3_ExternalWeaponControlLayer" cutRsc ["RS_MH6V3_ExternalWeaponControl", "PLAIN", 0, false];

private _display = uiNamespace getVariable ["RS_MH6V3_externalWeaponControlDisplay", displayNull];
if (isNull _display) exitWith {};

private _izlidStatus = _display displayCtrl 86104;
private _hydraStatus = _display displayCtrl 86106;
private _modeStatus = _display displayCtrl 86108;
private _green = [0.4, 1, 0.55, 1];
private _red = [1, 0.38, 0.32, 1];
private _amber = [1, 0.78, 0.32, 1];

_izlidStatus ctrlSetText (["OFF", "ON"] select _izlidOn);
_izlidStatus ctrlSetTextColor ([_red, _green] select _izlidOn);

_hydraStatus ctrlSetText (["NOT-ARMED", "ARMED"] select _quickFireArmed);
_hydraStatus ctrlSetTextColor ([_red, _green] select _quickFireArmed);

private _modeText = switch (_izlidMode) do {
	case 1: {"IZLID"};
	case 2: {"ILLUM"};
	default {"IZLID/ILLUM"};
};

_modeStatus ctrlSetText _modeText;
_modeStatus ctrlSetTextColor ([_red, _amber] select _izlidOn);
