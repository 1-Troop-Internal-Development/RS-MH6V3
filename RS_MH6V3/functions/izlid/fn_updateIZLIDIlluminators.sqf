if (!hasInterface) exitWith {};

private _activeVehicles = missionNamespace getVariable ["RS_MH6V3_activeIZLIDVehicles", []];
private _trackedVehicles = [];

{
	if ([_x] call RS_MH6V3_fnc_canUseIZLID) then {
		_trackedVehicles pushBack _x;
		private _mode = _x getVariable ["RS_MH6V3_izlidMode", 3];

		if (_mode in [2, 3]) then {
			private _laser = [_x] call RS_MH6V3_fnc_findIZLIDLaserSource;

			if !(_laser isEqualTo [-1, -1]) then {
				_laser params ["_origin", "_direction"];
				private _illuminatorOffset = 2;
				private _coneMode = _x getVariable ["RS_MH6V3_izlidConeMode", 1];

				[_x, _origin, _direction, _illuminatorOffset, _coneMode] call RS_MH6V3_fnc_updateIlluminator;
			};
		} else {
			[_x] call RS_MH6V3_fnc_cleanupIlluminator;
		};
	} else {
		[_x] call RS_MH6V3_fnc_cleanupIlluminator;
	};
} forEach _activeVehicles;

if !(_trackedVehicles isEqualTo _activeVehicles) then {
	missionNamespace setVariable ["RS_MH6V3_activeIZLIDVehicles", _trackedVehicles];
};
