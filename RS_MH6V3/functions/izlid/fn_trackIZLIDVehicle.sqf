params [
	["_vehicle", objNull],
	["_enabled", false, [false]]
];

if (!hasInterface) exitWith {[]};

private _activeVehicles = missionNamespace getVariable ["RS_MH6V3_activeIZLIDVehicles", []];
_activeVehicles = _activeVehicles select {
	!isNull _x &&
	{alive _x} &&
	{typeOf _x == "RHS_MELB_AH6M"} &&
	{_x getVariable ["RS_MH6V3_izlidEnabled", false]}
};

if (
	_enabled &&
	{!isNull _vehicle} &&
	{alive _vehicle} &&
	{typeOf _vehicle == "RHS_MELB_AH6M"}
) then {
	_activeVehicles pushBackUnique _vehicle;
} else {
	if (!isNull _vehicle) then {
		[_vehicle] call RS_MH6V3_fnc_cleanupIlluminator;
	};

	_activeVehicles = _activeVehicles - [_vehicle];
};

missionNamespace setVariable ["RS_MH6V3_activeIZLIDVehicles", _activeVehicles];

if (_activeVehicles isEqualTo []) then {
	if (!isNil "RS_MH6V3_izlidIlluminatorEh") then {
		removeMissionEventHandler ["EachFrame", RS_MH6V3_izlidIlluminatorEh];
		RS_MH6V3_izlidIlluminatorEh = nil;
	};

	if (!isNil "RS_MH6V3_izlidRenderEh") then {
		removeMissionEventHandler ["Draw3D", RS_MH6V3_izlidRenderEh];
		RS_MH6V3_izlidRenderEh = nil;
	};

	private _previousVehicle = player getVariable ["RS_MH6V3_izlidTriggerConeVehicle", objNull];
	if (!isNull _previousVehicle) then {
		_previousVehicle setVariable ["RS_MH6V3_izlidConeTriggerNarrow", false, true];
		player setVariable ["RS_MH6V3_izlidTriggerConeVehicle", objNull, false];
	};
} else {
	if (isNil "RS_MH6V3_izlidIlluminatorEh") then {
		RS_MH6V3_izlidIlluminatorEh = addMissionEventHandler ["EachFrame", {
			call RS_MH6V3_fnc_updatePilotIZLIDDirection;
			call RS_MH6V3_fnc_updateIZLIDTriggerCone;
			call RS_MH6V3_fnc_updateIZLIDIlluminators;
		}];
	};

	if (isNil "RS_MH6V3_izlidRenderEh") then {
		RS_MH6V3_izlidRenderEh = addMissionEventHandler ["Draw3D", {
			call RS_MH6V3_fnc_renderIZLID;
		}];
	};
};

_activeVehicles
