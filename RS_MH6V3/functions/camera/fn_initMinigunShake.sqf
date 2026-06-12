if (!hasInterface) exitWith {};

if (!isNil "RS_MH6V3_minigunShakePfh") then {
	[RS_MH6V3_minigunShakePfh] call CBA_fnc_removePerFrameHandler;
};

RS_MH6V3_minigunShakePfh = [{
	private _vehicle = vehicle player;

	if (
		_vehicle isEqualTo player ||
		{!(_vehicle isKindOf "RHS_MELB_AH6M")} ||
		{cameraView != "INTERNAL"}
	) exitWith {
		player setVariable ["RS_MH6V3_minigunShakeMotionSample", nil, false];
	};

	private _pulse = _vehicle getVariable ["RS_MH6V3_minigunShakePulse", [-1, 0]];
	_pulse params ["_firedAt", "_strength"];

	if ((serverTime - _firedAt) <= 0.18) then {
		private _now = diag_tickTime;
		private _airspeed = speed _vehicle;
		private _airspeedMultiplier = if (_airspeed <= 70) then {
			linearConversion [0, 40, _airspeed, 1, 1.4, true]
		} else {
			linearConversion [70, 220, _airspeed, 1.4, 1.8, true]
		};

		private _currentDirection = vectorDirVisual _vehicle;
		private _currentUp = vectorUpVisual _vehicle;
		private _previousMotionSample = player getVariable [
			"RS_MH6V3_minigunShakeMotionSample",
			[_now, _currentDirection, _currentUp]
		];
		_previousMotionSample params ["_previousTime", "_previousDirection", "_previousUp"];

		private _sampleDuration = 0.01 max (_now - _previousTime);
		private _angularMotion = (
			(_currentDirection vectorDistance _previousDirection) +
			(_currentUp vectorDistance _previousUp)
		) / _sampleDuration;
		private _maneuverMultiplier = linearConversion [0.08, 0.9, _angularMotion, 1, 1.45, true];

		player setVariable [
			"RS_MH6V3_minigunShakeMotionSample",
			[_now, _currentDirection, _currentUp],
			false
		];

		addCamShake [
			0.48 * _strength * _airspeedMultiplier * _maneuverMultiplier,
			0.12,
			32
		];
	} else {
		player setVariable ["RS_MH6V3_minigunShakeMotionSample", nil, false];
	};

	private _launchPulse = _vehicle getVariable ["RS_MH6V3_launchShakePulse", [-1, 0]];
	_launchPulse params ["_launchedAt", "_launchStrength"];

	private _lastLaunchHandled = player getVariable ["RS_MH6V3_lastLaunchShakeHandled", -1];
	if (
		_launchedAt > _lastLaunchHandled &&
		{(serverTime - _launchedAt) <= 0.4}
	) then {
		addCamShake [5.5 * _launchStrength, 0.55, 12];
		player setVariable ["RS_MH6V3_lastLaunchShakeHandled", _launchedAt, false];
	};
}, 0.08] call CBA_fnc_addPerFrameHandler;
