params [
	["_vehicle", objNull],
	["_visible", true]
];

if (isNull _vehicle) exitWith {};

if (!local _vehicle) exitWith {
	[_vehicle, _visible] remoteExecCall ["RS_MH6V3_fnc_setCrosshairVisible", _vehicle];
};

_vehicle animateSource ["Addcrosshair", [0, 1] select _visible, true];
_vehicle setVariable ["RS_MH6V3_crosshairVisible", _visible, true];
