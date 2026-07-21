if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["RS_MH6V3_resetCamerasEventRegistered", false]) exitWith {};

missionNamespace setVariable ["RS_MH6V3_resetCamerasEventRegistered", true];

["RS_MH6V3_resetCameras", {
	params [
		["_vehicle", objNull],
		["_executeLocal", true]
	];

	[_vehicle, _executeLocal] call RS_MH6V3_fnc_resetCameras;
}] call CBA_fnc_addEventHandler;
