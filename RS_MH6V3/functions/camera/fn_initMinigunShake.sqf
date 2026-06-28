if (!hasInterface) exitWith {};

if (isNil "RS_MH6V3_minigunShakeEventEh") then {
	RS_MH6V3_minigunShakeEventEh = [
		"RS_MH6V3_cameraShake",
		{
			params [
				["_vehicle", objNull],
				["_effect", "", [""]],
				["_strength", 1, [0]]
			];

			if !(missionNamespace getVariable ["RS_MH6V3_weaponVibrationEnabled", true]) exitWith {};

			if (
				isNull _vehicle ||
				{vehicle player != _vehicle} ||
				{cameraView != "INTERNAL"}
			) exitWith {};

			if (_effect == "launch") exitWith {
				setCamShakeParams [0.016, 0.85, 0.85, 1.05, true];
				addCamShake [2.4 * _strength, 0.42, 11];
			};

			if (_effect != "gun") exitWith {};

			missionNamespace setVariable ["RS_MH6V3_gunShakeVehicle", _vehicle];
			missionNamespace setVariable ["RS_MH6V3_gunShakeStrength", _strength];
			missionNamespace setVariable ["RS_MH6V3_gunShakeUntil", diag_tickTime + 0.35];

			if (!isNil "RS_MH6V3_minigunShakePfh") exitWith {};

			missionNamespace setVariable [
				"RS_MH6V3_gunShakeManeuverSample",
				[diag_tickTime, vectorDirVisual _vehicle]
			];

			RS_MH6V3_minigunShakePfh = [{
				private _vehicle = missionNamespace getVariable [
					"RS_MH6V3_gunShakeVehicle",
					objNull
				];
				private _shakeUntil = missionNamespace getVariable [
					"RS_MH6V3_gunShakeUntil",
					-1
				];
				private _validView =
					(missionNamespace getVariable ["RS_MH6V3_weaponVibrationEnabled", true]) &&
					!isNull _vehicle &&
					{vehicle player == _vehicle} &&
					{cameraView == "INTERNAL"} &&
					{diag_tickTime <= _shakeUntil};

				if (!_validView) exitWith {
					setCamShakeParams [0, 1, 1, 1, true];
					[RS_MH6V3_minigunShakePfh] call CBA_fnc_removePerFrameHandler;
					RS_MH6V3_minigunShakePfh = nil;
					missionNamespace setVariable ["RS_MH6V3_gunShakeVehicle", objNull];
					missionNamespace setVariable ["RS_MH6V3_gunShakeManeuverSample", nil];
				};

				private _strength = missionNamespace getVariable [
					"RS_MH6V3_gunShakeStrength",
					1
				];
				private _now = diag_tickTime;
				private _currentDirection = vectorDirVisual _vehicle;
				private _maneuverSample = missionNamespace getVariable [
					"RS_MH6V3_gunShakeManeuverSample",
					[_now, _currentDirection]
				];
				_maneuverSample params ["_sampleTime", "_sampleDirection"];

				private _sampleDuration = 0.01 max (_now - _sampleTime);
				private _turnRate = (_currentDirection vectorDistance _sampleDirection) / _sampleDuration;
				private _upVector = vectorUpVisual _vehicle;
				private _bankAmount = 1 - (abs (_upVector select 2));
				private _verticalSpeed = abs ((velocity _vehicle) select 2);
				private _maneuverBoost =
					1 +
					((_bankAmount min 0.7) * 0.65) +
					((_turnRate min 3.5) * 0.16) +
					(((_verticalSpeed min 22) / 22) * 0.16);
				_maneuverBoost = _maneuverBoost min 1.85;

				missionNamespace setVariable [
					"RS_MH6V3_gunShakeManeuverSample",
					[_now, _currentDirection]
				];

				private _phase = diag_tickTime * 900;
				private _horizontalBias = 0.585 + (abs (cos _phase)) * 0.91;
				private _verticalBias = 0.585 + (abs (sin _phase)) * 0.91;
				private _irregularity = 0.9 + (abs (sin (_phase * 0.37))) * 0.2;
				private _bankBias = 0.585 + (abs (sin (_phase * 0.53))) * 0.91;

				setCamShakeParams [
					0.00715 * _strength * _irregularity * _maneuverBoost,
					_verticalBias * _irregularity * _maneuverBoost,
					_horizontalBias * _irregularity * _maneuverBoost,
					_bankBias * _maneuverBoost,
					false
				];
				addCamShake [0.416 * _strength * _maneuverBoost, 0.1, 31];
			}, 0.025] call CBA_fnc_addPerFrameHandler;
		}
	] call CBA_fnc_addEventHandler;
};
