params [
	["_vehicle", objNull],
	["_mode", ""]
];

if (!hasInterface) exitWith {false};

private _player = player;
if (isNull _vehicle) then {
	_vehicle = vehicle _player;
};

if (isNull _vehicle || {!alive _vehicle}) exitWith {false};
if !(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]) exitWith {false};
if !(_player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]]) exitWith {false};

private _getPilotDirection = {
	params ["_vehicle"];

	private _directionModel = getPilotCameraDirection _vehicle;
	if (_directionModel isEqualTo [0, 0, 0]) exitWith {[0, 0, 0]};

	vectorNormalized (_vehicle vectorModelToWorldVisual _directionModel)
};

private _getCopilotDirection = {
	params ["_vehicle", "_player"];

	if (_player isEqualTo (_vehicle turretUnit [0]) && {cameraView == "gunner"}) exitWith {
		vectorNormalized ((positionCameraToWorld [0, 0, 1]) vectorDiff (positionCameraToWorld [0, 0, 0]))
	};

	private _direction = _vehicle weaponDirection "rhs_weap_laserDesignator_AI";
	if (_direction isEqualTo [0, 0, 0]) exitWith {[0, 0, 0]};

	vectorNormalized _direction
};

private _slewPilotToDirection = {
	params ["_vehicle", "_directionWorld"];

	private _directionModel = vectorNormalized (_vehicle vectorWorldToModelVisual _directionWorld);
	_vehicle setPilotCameraTarget objNull;
	_vehicle setPilotCameraDirection _directionModel;
	true
};

private _slewCopilotToDirection = {
	params ["_vehicle", "_directionWorld"];

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

	private _origin = AGLToASL (_vehicle modelToWorldVisual (_vehicle selectionPosition "commanderview"));
	private _pointASL = _origin vectorAdd ((vectorNormalized _directionWorld) vectorMultiply 4000);

	_vehicle lockCameraTo [_pointASL, [0]];
	[
		{
			params ["_vehicle"];

			if (!isNull _vehicle) then {
				_vehicle lockCameraTo [objNull, [0]];
			};
		},
		[_vehicle],
		0.05
	] call CBA_fnc_waitAndExecute;

	true
};

switch (_mode) do {
	case "pilotToCopilot": {
		private _direction = [_vehicle] call _getPilotDirection;
		if (_direction isEqualTo [0, 0, 0]) exitWith {
			systemChat "RS MH-6V3: pilot FLIR direction unavailable.";
			false
		};

		[_vehicle, _direction] call _slewCopilotToDirection;
		systemChat "RS MH-6V3: copilot FLIR slewed to pilot FLIR.";
		true
	};
	case "copilotToPilot": {
		private _direction = [_vehicle, _player] call _getCopilotDirection;
		if (_direction isEqualTo [0, 0, 0]) exitWith {
			systemChat "RS MH-6V3: copilot FLIR direction unavailable.";
			false
		};

		[_vehicle, _direction] call _slewPilotToDirection;
		systemChat "RS MH-6V3: pilot FLIR slewed to copilot FLIR.";
		true
	};
	default {
		false
	};
};
