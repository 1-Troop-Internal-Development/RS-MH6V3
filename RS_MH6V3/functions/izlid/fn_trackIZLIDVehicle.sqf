params [
	["_vehicle", objNull],
	["_enabled", false, [false]]
];

if (!hasInterface) exitWith {[]};

private _activeVehicles = missionNamespace getVariable ["RS_MH6V3_activeIZLIDVehicles", []];
_activeVehicles = _activeVehicles select {
	!isNull _x &&
	{alive _x} &&
	{typeOf _x in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]} &&
	{
		(typeOf _x == "RHS_MELB_AH6M" && {_x getVariable ["RS_MH6V3_izlidEnabled", false]}) ||
		{_x getVariable ["RS_MH6V3_pilotIZLIDEnabled", false]}
	}
};

if (
	_enabled &&
	{!isNull _vehicle} &&
	{alive _vehicle} &&
	{typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]}
) then {
	_activeVehicles pushBackUnique _vehicle;
} else {
	if (!isNull _vehicle) then {
		[_vehicle] call RS_MH6V3_fnc_cleanupIlluminator;
		_vehicle setVariable ["RS_MH6V3_izlidConeTriggerNarrow", false, true];
	};

	_activeVehicles = _activeVehicles - [_vehicle];
};

missionNamespace setVariable ["RS_MH6V3_activeIZLIDVehicles", _activeVehicles];

if (_activeVehicles isEqualTo []) then {
	if (!isNil "RS_MH6V3_izlidIlluminatorEh") then {
		[RS_MH6V3_izlidIlluminatorEh] call CBA_fnc_removePerFrameHandler;
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
		RS_MH6V3_izlidIlluminatorEh = [{
			call RS_MH6V3_fnc_updatePilotIZLIDDirection;
			call RS_MH6V3_fnc_updateIZLIDTriggerCone;
			call RS_MH6V3_fnc_updateIZLIDIlluminators;
		}, 0.03] call CBA_fnc_addPerFrameHandler;
	};

	if (isNil "RS_MH6V3_izlidRenderEh") then {
		RS_MH6V3_izlidRenderEh = addMissionEventHandler ["Draw3D", {
			call RS_MH6V3_fnc_renderIZLID;
		}];
	};
};

_activeVehicles
