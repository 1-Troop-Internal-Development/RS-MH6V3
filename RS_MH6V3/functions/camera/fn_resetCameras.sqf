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

	_vehicle lockCameraTo [objNull, []];
	_vehicle lockCameraTo [objNull, [0]];
	_vehicle setTurretOpticsMode [[0], 0];

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

		_vehicle lockCameraTo [objNull, []];
		_vehicle lockCameraTo [objNull, [0]];
		_vehicle setTurretOpticsMode [[0], 0];

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
