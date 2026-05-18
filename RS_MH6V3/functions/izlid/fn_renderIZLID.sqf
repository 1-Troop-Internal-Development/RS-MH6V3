{
	if (alive _x && {_x getVariable ["RS_MH6V3_izlidEnabled", false]}) then {
		private _laser = [_x] call RS_MH6V3_fnc_findIZLIDLaserSource;

		if !(_laser isEqualTo [-1, -1]) then {
			_laser params ["_origin", "_direction"];
			private _illuminatorClass = "gjb_itn_illum_dbal_a2_09_Hi";
			private _illuminator = _x getVariable ["RS_MH6V3_izlidIlluminator", objNull];
			private _illuminatorClassActive = _x getVariable ["RS_MH6V3_izlidIlluminatorClass", ""];

			if (_illuminatorClassActive != _illuminatorClass) then {
				deleteVehicle _illuminator;
				_illuminator = objNull;
				_x setVariable ["RS_MH6V3_izlidIlluminatorClass", _illuminatorClass];
			};

			if (isNull _illuminator && {isClass (configFile >> "CfgVehicles" >> _illuminatorClass)}) then {
				_illuminator = _illuminatorClass createVehicleLocal [0, 0, 0];
				_x setVariable ["RS_MH6V3_izlidIlluminator", _illuminator];
			};

			if (!isNull _illuminator) then {
				_illuminator setPosASL _origin;
				_illuminator setVectorDirAndUp [_direction, [0, 1, 0]];
			};

			drawLaser [_origin, _direction, [250, 0, 0, 1], [], 0.45, 0.8, 3000, true];
		};
	} else {
		private _illuminator = _x getVariable ["RS_MH6V3_izlidIlluminator", objNull];
		if (!isNull _illuminator) then {
			deleteVehicle _illuminator;
			_x setVariable ["RS_MH6V3_izlidIlluminator", objNull];
			_x setVariable ["RS_MH6V3_izlidIlluminatorClass", ""];
		};
	};
} forEach (vehicles select {_x isKindOf "RHS_MELB_AH6M"});
