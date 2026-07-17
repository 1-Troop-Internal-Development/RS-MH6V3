/*
	RS MH-6V3 MELB FLIR HUD handler.
	Handles copilot FLIR HUD effects, zoom telemetry, and explicit GEOLOCK input.
*/
disableSerialization;

params [
	["_display", displayNull]
];

if (isNull _display) exitWith {};

uiNameSpace setVariable ["RS_MH6V3_MELB_FLIRCtrl", _display];

[] spawn {
	private _aberrEffect = ppEffectCreate ["ChromAberration", 200];
	_aberrEffect ppEffectAdjust [0.002, 0.002, 200];
	_aberrEffect ppEffectCommit 0;

	private _nvEffect = ppEffectCreate ["colorCorrections", 1500];
	_nvEffect ppEffectAdjust [0.5, 0.9, -0.01, [1, 1, 1, 0], [0.5, 1, 0.5, 0], [1, 1, 1, 0], false];
	_nvEffect ppEffectForceInNVG true;
	_nvEffect ppEffectCommit 0;

	private _noiseEffect = ppEffectCreate ["FilmGrain", 2000];
	_noiseEffect ppEffectAdjust [0.15, 1, 1, 0.45, 1, false];
	_noiseEffect ppEffectCommit 0;

	disableSerialization;
	private _player = player;
	private _vehicle = vehicle _player;

	private _display = uiNamespace getVariable ["RS_MH6V3_MELB_FLIRCtrl", displayNull];
	private _zoomSource = _display displayCtrl 180;
	private _distance = _display displayCtrl 151;
	private _geoLock = _display displayCtrl 154;
	private _zoom = _display displayCtrl 2;
	private _altitude = _display displayCtrl 189;

	private _previousMode = _vehicle getVariable ["MELB_mode", -1];
	private _lockInputDown = false;

	private _geolockPfh = _vehicle getVariable ["RS_MH6V3_copilotGeolockPfh", -1];
	if (_geolockPfh >= 0) then {
		[_geolockPfh] call CBA_fnc_removePerFrameHandler;
	};
	private _geolockHelper = _vehicle getVariable ["RS_MH6V3_copilotGeolockHelper", objNull];
	if (!isNull _geolockHelper) then {
		deleteVehicle _geolockHelper;
	};
	_vehicle lockCameraTo [objNull, [0]];
	_vehicle enableDirectionStabilization [false, [0]];
	_vehicle setTurretOpticsMode [[0], 0];
	_vehicle setVariable ["RS_MH6V3_copilotGeolockPfh", -1, false];
	_vehicle setVariable ["RS_MH6V3_copilotGeolockBaseMode", 0, false];
	_vehicle setVariable ["RS_MH6V3_copilotGeolockHelper", objNull, false];
	_vehicle setVariable ["RS_MH6V3_FLIRGeolockTarget", objNull, false];
	_vehicle setVariable ["RS_MH6V3_FLIRGeolockActive", false, false];
	_geoLock ctrlSetText "----";

	while {!isNull _distance} do {
		if (cameraView == "gunner") then {
			private _visionMode = currentVisionMode _player;
			if (_visionMode != _previousMode) then {
				_vehicle setVariable ["MELB_mode", _visionMode, true];
				_previousMode = _visionMode;

				switch (_visionMode) do {
					case 0: {
						{_x ppEffectEnable true} forEach [_aberrEffect];
						{_x ppEffectEnable false} forEach [_noiseEffect, _nvEffect];
					};
					case 1: {
						{_x ppEffectEnable true} forEach [_noiseEffect, _aberrEffect, _nvEffect];
					};
					case 2: {
						{_x ppEffectEnable true} forEach [_noiseEffect];
						{_x ppEffectEnable false} forEach [_nvEffect, _aberrEffect];
					};
					default {};
				};
			};

			if (_vehicle animationPhase "MFD_CoPilot" isEqualTo 0) then {
				_vehicle animate ["copilotpip", 1];
				_vehicle animate ["MFD_CoPilot", 1];
			};
		} else {
			{_x ppEffectEnable false} forEach [_noiseEffect, _aberrEffect, _nvEffect];
			_previousMode = -1;
			_geoLock ctrlSetText "----";
		};

		private _zoomLevel = (parseNumber (ctrlText _zoomSource)) * 70;
		_zoomLevel = (if (_zoomLevel <= 99) then {"0"} else {""}) + str _zoomLevel;
		private _zoomArray = toArray _zoomLevel;
		_zoom ctrlSetText (toString (call compile (format ["[%1,%2,32,%3]", _zoomArray select 0, _zoomArray select 1, _zoomArray select 2])));

		private _canToggleGeolock = cameraView == "gunner" && {_player isEqualTo (_vehicle turretUnit [0])};
		private _pressed = _canToggleGeolock && {
			((inputAction "LockTurretView") > 0) ||
			{((inputAction "lockTurretView") > 0) ||
			{(inputAction "lockTarget") > 0}}
		};

		if (_pressed && {!_lockInputDown}) then {
			[_vehicle] call RS_MH6V3_fnc_toggleCopilotGeolock;
		};
		_lockInputDown = _pressed;

		_geoLock ctrlSetText (if (_vehicle getVariable ["RS_MH6V3_FLIRGeolockActive", false]) then {"TRK COR"} else {"----"});

		if (!isNull _altitude) then {
			private _agl = (getPosATL _vehicle) # 2;
			private _speed = velocity _vehicle;
			private _verticalSpeed = _speed # 2;
			private _futurePositionASL = (getPosASL _vehicle) vectorAdd (_speed vectorMultiply 2.5);
			private _futureAgl = (_futurePositionASL # 2) - (getTerrainHeightASL _futurePositionASL);
			private _impactWarning = cameraView == "gunner"
				&& {_agl < 45}
				&& {_verticalSpeed < -1.0}
				&& {_futureAgl < 8};

			if (_impactWarning && {((floor (diag_tickTime * 4)) mod 2) isEqualTo 0}) then {
				_altitude ctrlSetBackgroundColor [0.85, 0, 0, 0.82];
			} else {
				_altitude ctrlSetBackgroundColor [0, 0, 0, 0];
			};
		};

		sleep 0.01;
	};

	if (!isNull _altitude) then {
		_altitude ctrlSetBackgroundColor [0, 0, 0, 0];
	};
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

	ppEffectDestroy _noiseEffect;
	ppEffectDestroy _aberrEffect;
	ppEffectDestroy _nvEffect;
	uiNameSpace setVariable ["RS_MH6V3_MELB_FLIRCtrl", displayNull];
};

[] spawn {
	disableSerialization;
	private _player = player;
	private _vehicle = vehicle _player;

	private _display = uiNamespace getVariable ["RS_MH6V3_MELB_FLIRCtrl", displayNull];
	private _zoomSource = _display displayCtrl 180;
	private _distance = _display displayCtrl 151;
	private _oldZoom = 0.3;

	while {!isNull _distance} do {
		private _zoomLevel = (parseNumber (ctrlText _zoomSource)) * 70;
		if (_oldZoom != _zoomLevel) then {
			_vehicle setVariable ["MELB_zoom", _zoomLevel, true];
			_oldZoom = _zoomLevel;
		};

		sleep 1;
	};
};
