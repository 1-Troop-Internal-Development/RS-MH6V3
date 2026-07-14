params [
	["_vehicle", objNull],
	["_executeLocal", false]
];

if (!hasInterface) exitWith {};
if (isNull _vehicle) then {
	_vehicle = vehicle player;
};
if (isNull _vehicle || {!alive _vehicle}) exitWith {};
if !(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]) exitWith {};

if (!_executeLocal) exitWith {
	private _recipients = [driver _vehicle, gunner _vehicle] select {
		!isNull _x && {isPlayer _x}
	};
	_recipients = _recipients arrayIntersect _recipients;

	if (_recipients isEqualTo []) then {
		[_vehicle, true] call RS_MH6V3_fnc_resetCameras;
	} else {
		{
			if (player == _x) then {
				[_vehicle, true] call RS_MH6V3_fnc_resetCameras;
			} else {
				["RS_MH6V3_resetCameras", [_vehicle, true], _x] call CBA_fnc_targetEvent;
			};
		} forEach _recipients;
	};
};

private _resetVehicleCameras = {
	params ["_vehicle"];

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};

	cameraEffect ["terminate", "back"];
	(cameraOn) switchCamera "INTERNAL";

	_vehicle setPilotCameraTarget objNull;
	_vehicle setPilotCameraDirection [0, 1, 0];
	_vehicle setPilotCameraRotation [0, 0];
	_vehicle setPilotCameraOpticsMode 0;
	_vehicle setVariable ["RS_MH6V3_pilotCameraOpticsMode", 0, false];

	_vehicle lockCameraTo [objNull, []];
	_vehicle lockCameraTo [objNull, [0]];
	_vehicle enableDirectionStabilization [false, [0]];
	_vehicle setTurretOpticsMode [[0], 0];
	private _geolockPfh = _vehicle getVariable ["RS_MH6V3_copilotGeolockPfh", -1];
	if (_geolockPfh >= 0) then {
		[_geolockPfh] call CBA_fnc_removePerFrameHandler;
	};
	private _geolockHelper = _vehicle getVariable ["RS_MH6V3_copilotGeolockHelper", objNull];
	if (!isNull _geolockHelper) then {
		deleteVehicle _geolockHelper;
	};
	_vehicle setVariable ["RS_MH6V3_copilotGeolockPfh", -1, false];
	_vehicle setVariable ["RS_MH6V3_copilotGeolockBaseMode", 0, false];
	_vehicle setVariable ["RS_MH6V3_copilotGeolockHelper", objNull, false];
	_vehicle setVariable ["RS_MH6V3_FLIRGeolockTarget", objNull, false];
	_vehicle setVariable ["RS_MH6V3_FLIRGeolockActive", false, false];

	if (vehicle player isEqualTo _vehicle) then {
		_vehicle switchCamera "INTERNAL";
	};
};

[_vehicle] call _resetVehicleCameras;
[
	{
		params ["_vehicle"];

		if (isNull _vehicle || {!alive _vehicle}) exitWith {};

		cameraEffect ["terminate", "back"];
		(cameraOn) switchCamera "INTERNAL";

		_vehicle setPilotCameraTarget objNull;
		_vehicle setPilotCameraDirection [0, 1, 0];
		_vehicle setPilotCameraRotation [0, 0];
		_vehicle setPilotCameraOpticsMode 0;
		_vehicle setVariable ["RS_MH6V3_pilotCameraOpticsMode", 0, false];

		_vehicle lockCameraTo [objNull, []];
		_vehicle lockCameraTo [objNull, [0]];
		_vehicle enableDirectionStabilization [false, [0]];
		_vehicle setTurretOpticsMode [[0], 0];
		private _geolockPfh = _vehicle getVariable ["RS_MH6V3_copilotGeolockPfh", -1];
		if (_geolockPfh >= 0) then {
			[_geolockPfh] call CBA_fnc_removePerFrameHandler;
		};
		private _geolockHelper = _vehicle getVariable ["RS_MH6V3_copilotGeolockHelper", objNull];
		if (!isNull _geolockHelper) then {
			deleteVehicle _geolockHelper;
		};
		_vehicle setVariable ["RS_MH6V3_copilotGeolockPfh", -1, false];
		_vehicle setVariable ["RS_MH6V3_copilotGeolockBaseMode", 0, false];
		_vehicle setVariable ["RS_MH6V3_copilotGeolockHelper", objNull, false];
		_vehicle setVariable ["RS_MH6V3_FLIRGeolockTarget", objNull, false];
		_vehicle setVariable ["RS_MH6V3_FLIRGeolockActive", false, false];

		if (vehicle player isEqualTo _vehicle) then {
			_vehicle switchCamera "INTERNAL";
		};
	},
	[_vehicle],
	0.1
] call CBA_fnc_waitAndExecute;

private _message = "RS MH-6V3: pilot and copilot cameras reset.";
private _recipients = [driver _vehicle, gunner _vehicle] select {
	!isNull _x && {isPlayer _x}
};

if (player in _recipients) then {
	systemChat _message;
};
