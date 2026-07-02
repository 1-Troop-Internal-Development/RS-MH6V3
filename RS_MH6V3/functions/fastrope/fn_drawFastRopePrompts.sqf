if (!hasInterface) exitWith {};

private _vehicle = vehicle player;
if (_vehicle isEqualTo player) exitWith {};
if (isNull _vehicle || {!alive _vehicle}) exitWith {};
if (typeOf _vehicle != "RHS_MELB_MH6M") exitWith {};
if !(player in _vehicle) exitWith {};
if !(call RS_MH6V3_fnc_isFastRopeConfigured) exitWith {};

private _drawPrompt = {
	params ["_text", "_offsetZ", "_color"];

	drawIcon3D [
		"",
		_color,
		positionCameraToWorld [0, 2, _offsetZ],
		0,
		0,
		0,
		_text,
		2,
		0.035,
		"RobotoCondensedBold",
		"center"
	];
};

if ([_vehicle] call RS_MH6V3_fnc_canShowDeployRopes) then {
	["Deploy Fast Ropes", -0.25, [0.5, 0.85, 1, 1]] call _drawPrompt;
};

if ([_vehicle] call RS_MH6V3_fnc_canShowFastRope) then {
	["Fast Rope", -0.35, [0.5, 0.85, 1, 1]] call _drawPrompt;
};
