params [
	["_vehicle", objNull]
];

if (isNull _vehicle) exitWith {false};
if !(typeOf _vehicle isEqualTo "RHS_MELB_AH6M") exitWith {false};

private _textures = [
	"\rhsusf\addons\rhsusf_melb\Data\optics\melb_crosshair_circle_dot_ca.paa",
	"\rhsusf\addons\rhsusf_melb\Data\optics\melb_crosshair_cross_ca.paa",
	"\rhsusf\addons\rhsusf_melb\Data\optics\melb_crosshair_dot_ca.paa",
	"\rhsusf\addons\rhsusf_melb\Data\optics\melb_crosshair_t_dot_ca.paa",
	"\rhsusf\addons\rhsusf_melb\Data\optics\melb_crosshair_x_ca.paa"
];
private _names = [
	"Circle Dot",
	"Cross",
	"Dot",
	"T Dot",
	"X"
];

private _selectionIndex = (getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "hiddenSelections")) find "crosshair";
if (_selectionIndex < 0) exitWith {
	if (hasInterface) then {
		systemChat "RS MH-6V3: crosshair hidden selection not configured.";
	};
	false
};

private _currentIndex = _vehicle getVariable ["RS_MH6V3_crosshairTextureIndex", 2];
private _nextIndex = (_currentIndex + 1) mod (count _textures);

[_vehicle, true] call RS_MH6V3_fnc_setCrosshairVisible;
_vehicle setObjectTextureGlobal [_selectionIndex, _textures # _nextIndex];
_vehicle setVariable ["RS_MH6V3_crosshairTextureIndex", _nextIndex, true];

if (hasInterface) then {
	systemChat format ["RS MH-6V3: crosshair %1.", _names # _nextIndex];
};

true
