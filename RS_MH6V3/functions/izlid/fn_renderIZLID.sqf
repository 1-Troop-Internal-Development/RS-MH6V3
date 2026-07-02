if (!hasInterface) exitWith {};

private _frameNo = diag_frameNo;
if ((missionNamespace getVariable ["RS_MH6V3_izlidLastRenderFrame", -1]) isEqualTo _frameNo) exitWith {};
missionNamespace setVariable ["RS_MH6V3_izlidLastRenderFrame", _frameNo];

private _activeVehicles = missionNamespace getVariable ["RS_MH6V3_activeIZLIDVehicles", []];
private _trackedVehicles = [];
private _laserColor = [250, 0, 0, 1];
private _laserMax = 3000;
private _drawIRLaser = {
	params ["_vehicle", "_origin", "_direction", "_maxDistance", "_color", ["_compensateOrigin", false, [false]]];

	private _endPos = _origin vectorAdd (_direction vectorMultiply _maxDistance);
	private _surfaces = lineIntersectsSurfaces [
		_origin,
		_endPos,
		_vehicle,
		objNull,
		true,
		1,
		"GEOM",
		"NONE"
	];
	private _drawDistance = if (_surfaces isEqualTo []) then {
		_maxDistance
	} else {
		(_origin distance (_surfaces # 0 # 0)) min _maxDistance
	};
	private _originCompensation = if (_compensateOrigin) then {
		linearConversion [150, _maxDistance, _drawDistance, 0, 2.2, true]
	} else {
		0
	};
	private _drawOrigin = _origin vectorAdd (_direction vectorMultiply _originCompensation);
	private _compensatedDistance = (_drawDistance - _originCompensation) max 1;

	drawLaser [_drawOrigin, _direction, _color, [], 0.5, 1, _compensatedDistance, true];
};

{
	if ([_x] call RS_MH6V3_fnc_canUseIZLID) then {
		_trackedVehicles pushBack _x;
		private _mode = _x getVariable ["RS_MH6V3_izlidMode", 3];
		private _fixedEnabled =
			_x getVariable ["RS_MH6V3_izlidEnabled", false] &&
			{_mode in [1, 3]};
		private _pilotEnabled = _x getVariable ["RS_MH6V3_pilotIZLIDEnabled", false];

		if (_fixedEnabled) then {
			private _laser = [_x] call RS_MH6V3_fnc_findIZLIDLaserSource;
			if !(_laser isEqualTo [-1, -1]) then {
				_laser params ["_origin", "_direction"];
				[_x, _origin, _direction, _laserMax, _laserColor, true] call _drawIRLaser;
			};
		};

		if (_pilotEnabled) then {
			private _pilotDirection = _x getVariable [
				"RS_MH6V3_pilotIZLIDDirection",
				[0, 0, 0]
			];

			if !(_pilotDirection isEqualTo [0, 0, 0]) then {
				private _pilot = currentPilot _x;
				if (!isNull _pilot) then {
					private _originModel = if (_pilot isEqualTo driver _x) then {
						[-0.776758, 1.71812, -0.407359]
					} else {
						[0.913477, 1.77864, -0.407359]
					};
					private _origin = _x modelToWorldVisualWorld _originModel;

					[_x, _origin, _pilotDirection, _laserMax, _laserColor] call _drawIRLaser;
				};
			};
		};
	};
} forEach _activeVehicles;

if !(_trackedVehicles isEqualTo _activeVehicles) then {
	missionNamespace setVariable ["RS_MH6V3_activeIZLIDVehicles", _trackedVehicles];

	if (_trackedVehicles isEqualTo []) then {
		[objNull, false] call RS_MH6V3_fnc_trackIZLIDVehicle;
	};
};
