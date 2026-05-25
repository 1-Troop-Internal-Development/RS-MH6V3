if (!hasInterface) exitWith {};

private _frameNo = diag_frameNo;
if ((missionNamespace getVariable ["RS_MH6V3_izlidLastRenderFrame", -1]) isEqualTo _frameNo) exitWith {};
missionNamespace setVariable ["RS_MH6V3_izlidLastRenderFrame", _frameNo];

private _activeVehicles = missionNamespace getVariable ["RS_MH6V3_activeIZLIDVehicles", []];
private _trackedVehicles = [];

{
	if ([_x] call RS_MH6V3_fnc_canUseIZLID) then {
		_trackedVehicles pushBack _x;
		private _mode = _x getVariable ["RS_MH6V3_izlidMode", 3];
		if (_mode in [1, 2, 3]) then {

			private _laser = [_x] call RS_MH6V3_fnc_findIZLIDLaserSource;

			if !(_laser isEqualTo [-1, -1]) then {
				_laser params ["_origin", "_direction"];
				private _laserMax = 3000;
				private _laserStartOffset = 0.05;

				if (_mode in [1, 3]) then {
					private _begPos = _origin vectorAdd (_direction vectorMultiply _laserStartOffset);
					drawLaser [_begPos, _direction, [250, 0, 0, 1], [], 0.45, 0.8, _laserMax, true];
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
