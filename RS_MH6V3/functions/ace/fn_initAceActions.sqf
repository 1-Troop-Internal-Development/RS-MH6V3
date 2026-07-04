RS_MH6V3_OH6_CLASS = "RHS_MELB_H6M";
RS_MH6V3_MH6_CLASS = "RHS_MELB_MH6M";
RS_MH6V3_AH6_CLASS = "RHS_MELB_AH6M";
RS_MH6V3_SERVICE_CLASSES = [RS_MH6V3_OH6_CLASS, RS_MH6V3_MH6_CLASS, RS_MH6V3_AH6_CLASS];
RS_MH6V3_CONVERT_TIME = 10;
RS_MH6V3_DRAIN_FUEL_TIME = 25;
RS_MH6V3_ASSEMBLE_ROTORS_TIME = 10;
RS_MH6V3_DISASSEMBLE_ROTORS_TIME = 10;
RS_MH6V3_ROTOR_SERVICE_POSITION = [-0.0424805, 0.696106, 0.592959];
RS_MH6V3_ROTOR_HIT_INDICES = [5];
RS_MH6V3_FUEL_DRAIN_SOUND = "RS_MH6V3_FuelDrain";
RS_MH6V3_FUEL_DRAIN_SOUND_INTERVAL = 1;
RS_MH6V3_SERVICE_ANIMATION = "InBaseMoves_repairVehicleKnl";
RS_MH6V3_SERVICE_SOUND = "A3\Sounds_F\sfx\UI\vehicles\vehicle_repair.wss";
RS_MH6V3_SERVICE_SOUND_INTERVAL = 2.2;
RS_MH6V3_MH6_PACKAGE_POSITIONS = [
	[-0.866211, 0.827637, -1.20747],
	[1.01953, 0.753662, -1.30649]
];
RS_MH6V3_AH6_PACKAGE_POSITION = [-0.0869141, 0.72403, -0.607061];
RS_MH6V3_AH6_PACKAGE_DISTANCE = 3.25;
RS_MH6V3_AMMO_SUPPORT_RADIUS = 25;
RS_MH6V3_C130_CLASS = "USAF_C130J_Cargo";
RS_MH6V3_C130_MODEL_CHANGE_PROTECT_RADIUS = 40;
RS_MH6V3_SAFE_SPAWN_HEIGHT = 25;

if (isServer) then {
	missionNamespace setVariable ["RS_MH6V3_serverModActive", true, true];
};
missionNamespace setVariable ["RS_MH6V3_useServerPackageEvents", isServer || {missionNamespace getVariable ["RS_MH6V3_serverModActive", false]}];

if (isNil "RS_MH6V3_cbaNetworkEventsRegistered") then {
	RS_MH6V3_cbaNetworkEventsRegistered = true;

	["RS_MH6V3_notify", {
		params ["_message"];
		systemChat _message;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_serviceFxStart", {
		_this call RS_MH6V3_fnc_serviceFxLocalStart;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_serviceFxStop", {
		_this call RS_MH6V3_fnc_serviceFxLocalStop;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_serviceSoundStart", {
		_this call RS_MH6V3_fnc_serviceSoundLocalStart;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_fuelDrainSoundStart", {
		_this call RS_MH6V3_fnc_fuelDrainSoundLocal;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_fuelDrainSoundStop", {
		_this call RS_MH6V3_fnc_fuelDrainSoundStopLocal;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_setRotorDamage", {
		_this call RS_MH6V3_fnc_setRotorDamage;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_openRearmMenu", {
		_this call RS_MH6V3_fnc_openRearmMenu;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_resetCameras", {
		_this call RS_MH6V3_fnc_resetCameras;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_trackIZLIDVehicle", {
		_this call RS_MH6V3_fnc_trackIZLIDVehicle;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_cleanupIlluminator", {
		_this call RS_MH6V3_fnc_cleanupIlluminator;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_receiveACRERadioSnapshot", {
		_this call RS_MH6V3_fnc_receiveACRERadioSnapshot;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_publishACRERadioSnapshot", {
		_this call RS_MH6V3_fnc_publishACRERadioSnapshot;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_applyACRERadioTune", {
		_this call RS_MH6V3_fnc_applyACRERadioTune;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_requestDrainFuel", {
		_this call RS_MH6V3_fnc_drainFuel;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_requestCancelFuelDrain", {
		_this call RS_MH6V3_fnc_cancelFuelDrain;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_requestEnforceAmmoSource", {
		_this call RS_MH6V3_fnc_enforceAttackPackageAmmoSource;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_requestDisassembleRotors", {
		_this call RS_MH6V3_fnc_disassembleRotors;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_requestAssembleRotors", {
		_this call RS_MH6V3_fnc_assembleRotors;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_requestConvertVariant", {
		_this call RS_MH6V3_fnc_convertVariant;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_requestRemoveAh6ArmamentsForCargo", {
		_this call RS_MH6V3_fnc_removeAh6ArmamentsForCargo;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_requestApplyLivery", {
		_this call RS_MH6V3_fnc_applyLivery;
	}] call CBA_fnc_addEventHandler;

	["RS_MH6V3_requestQuickLaunchHydra", {
		_this call RS_MH6V3_fnc_quickLaunchHydra;
	}] call CBA_fnc_addEventHandler;
};

if (hasInterface && {!isServer}) then {
	[{
		missionNamespace setVariable ["RS_MH6V3_useServerPackageEvents", missionNamespace getVariable ["RS_MH6V3_serverModActive", false]];
	}, [], 3] call CBA_fnc_waitAndExecute;
};

RS_MH6V3_fnc_notifyAircrew = {
	params [
		"_message",
		["_vehicle", objNull]
	];

	if (isNull _vehicle) exitWith {
		diag_log _message;
	};

	private _recipients = [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]] select {
		!isNull _x && {isPlayer _x}
	};

	{
		if (hasInterface && {player == _x}) then {
			systemChat _message;
		} else {
			["RS_MH6V3_notify", [_message], _x] call CBA_fnc_targetEvent;
		};
	} forEach (_recipients arrayIntersect _recipients);
};

RS_MH6V3_fnc_useServerPackageEvents = {
	missionNamespace getVariable ["RS_MH6V3_useServerPackageEvents", isServer || {missionNamespace getVariable ["RS_MH6V3_serverModActive", false]}]
};

RS_MH6V3_fnc_canService = {
	params ["_vehicle"];

	alive _vehicle
	&& {typeOf _vehicle in RS_MH6V3_SERVICE_CLASSES}
	&& {crew _vehicle isEqualTo []}
	&& {isNull attachedTo _vehicle}
};

RS_MH6V3_fnc_hasToolkit = {
	params ["_unit"];

	if (isNull _unit) exitWith {false};

	"ToolKit" in (
		items _unit
		+ assignedItems _unit
		+ uniformItems _unit
		+ vestItems _unit
		+ backpackItems _unit
	)
};

RS_MH6V3_fnc_serviceFxLocalStart = {
	params [
		"_unit",
		"_duration",
		"_fxId"
	];

	if !(hasInterface) exitWith {};
	if (isNull _unit || {!local _unit}) exitWith {};
	if (vehicle _unit != _unit) exitWith {};

	_unit setVariable ["RS_MH6V3_serviceFxId", _fxId, true];
	_unit switchMove RS_MH6V3_SERVICE_ANIMATION;
	_unit playMoveNow RS_MH6V3_SERVICE_ANIMATION;

	[_unit, _duration, _fxId] spawn {
		params [
			"_unit",
			"_duration",
			"_fxId"
		];

		private _endTime = time + _duration;
		private _serviceAnimation = toLower RS_MH6V3_SERVICE_ANIMATION;

		while {
			time < _endTime
			&& {!isNull _unit}
			&& {alive _unit}
			&& {vehicle _unit == _unit}
			&& {(_unit getVariable ["RS_MH6V3_serviceFxId", ""]) == _fxId}
		} do {
			waitUntil {
				sleep 0.1;
				time >= _endTime
				|| {isNull _unit}
				|| {!alive _unit}
				|| {vehicle _unit != _unit}
				|| {(_unit getVariable ["RS_MH6V3_serviceFxId", ""]) != _fxId}
				|| {(toLower (animationState _unit)) == _serviceAnimation}
			};
		};

		if (!isNull _unit && {(_unit getVariable ["RS_MH6V3_serviceFxId", ""]) == _fxId}) then {
			_unit setVariable ["RS_MH6V3_serviceFxId", "", true];
		};

		if (!isNull _unit && {local _unit} && {vehicle _unit == _unit}) then {
			_unit switchMove "";
		};
	};
};

RS_MH6V3_fnc_serviceFxLocalStop = {
	params [
		"_unit",
		"_fxId"
	];

	if !(hasInterface) exitWith {};
	if (isNull _unit || {!local _unit}) exitWith {};
	if !((_unit getVariable ["RS_MH6V3_serviceFxId", ""]) in [_fxId, ""]) exitWith {};

	_unit setVariable ["RS_MH6V3_serviceFxId", "", true];
	if (vehicle _unit == _unit) then {
		_unit switchMove "";
	};
};

RS_MH6V3_fnc_serviceSoundLocalStart = {
	params [
		"_vehicle",
		"_unit",
		"_duration",
		"_fxId"
	];

	if !(hasInterface) exitWith {};
	if (isNull _unit) exitWith {};

	[_vehicle, _unit, _duration, _fxId] spawn {
		params [
			"_vehicle",
			"_unit",
			"_duration",
			"_fxId"
		];

		private _soundHost = if (isNull _vehicle) then {_unit} else {_vehicle};
		if (_soundHost getVariable ["RS_LB_serviceSoundLoopLocal", false]) exitWith {};
		_soundHost setVariable ["RS_LB_serviceSoundLoopLocal", true];

		private _endTime = time + _duration;

		while {
			time < _endTime
			&& {!isNull _unit}
			&& {alive _unit}
			&& {(_unit getVariable ["RS_MH6V3_serviceFxId", ""]) == _fxId}
		} do {
			private _soundPos = if (isNull _vehicle) then {
				getPosASL _unit
			} else {
				getPosASL _vehicle
			};

			playSound3D [RS_MH6V3_SERVICE_SOUND, objNull, false, _soundPos, 2, 1, 35];
			sleep RS_MH6V3_SERVICE_SOUND_INTERVAL;
		};

		if (!isNull _soundHost) then {
			_soundHost setVariable ["RS_LB_serviceSoundLoopLocal", false];
		};
	};
};

RS_MH6V3_fnc_startServiceFx = {
	params [
		"_vehicle",
		"_unit",
		"_duration"
	];

	if (isNull _unit) exitWith {""};

	private _fxId = format ["RS_MH6V3_service_%1_%2", round (diag_tickTime * 1000), floor random 10000];
	_unit setVariable ["RS_MH6V3_serviceFxId", _fxId, true];
	["RS_MH6V3_serviceFxStart", [_unit, _duration, _fxId], _unit] call CBA_fnc_targetEvent;
	["RS_MH6V3_serviceSoundStart", [_vehicle, _unit, _duration, _fxId], _unit] call CBA_fnc_targetEvent;
	_fxId
};

RS_MH6V3_fnc_stopServiceFx = {
	params [
		"_unit",
		"_fxId"
	];

	if (_fxId == "") exitWith {};
	_unit setVariable ["RS_MH6V3_serviceFxId", "", true];
	["RS_MH6V3_serviceFxStop", [_unit, _fxId], _unit] call CBA_fnc_targetEvent;
};

RS_MH6V3_fnc_runServiceTask = {
	params [
		["_duration", 0],
		["_args", []],
		["_onComplete", {}],
		["_onCancel", {}],
		["_label", "Servicing aircraft"]
	];

	if !(hasInterface) exitWith {false};

	if !(isNil "ace_common_fnc_progressBar") exitWith {
		[
			_duration,
			_args,
			_onComplete,
			_onCancel,
			_label
		] call ace_common_fnc_progressBar;
	};

	[_duration, _args, _onComplete, _onCancel, _label] spawn {
		params [
			"_duration",
			"_args",
			"_onComplete",
			"_onCancel",
			"_label"
		];

		private _vehicle = if ((count _args) > 0 && {(_args # 0) isEqualType objNull}) then {_args # 0} else {objNull};
		private _caller = player;
		{
			if (_x isEqualType objNull && {_x isKindOf "CAManBase"}) exitWith {
				_caller = _x;
			};
		} forEach _args;

		systemChat format ["RS MH-6V3: %1...", _label];

		private _endTime = time + _duration;
		private _cancelled = false;
		waitUntil {
			sleep 0.1;
			_cancelled =
				isNull _caller
				|| {!alive _caller}
				|| {vehicle _caller != _caller}
				|| {isNull _vehicle}
				|| {!alive _vehicle};

			_cancelled || {time >= _endTime}
		};

		if (_cancelled) then {
			_args call _onCancel;
			systemChat format ["RS MH-6V3: %1 cancelled.", _label];
		} else {
			_args call _onComplete;
		};
	};

	true
};

RS_MH6V3_fnc_playFuelDrainSound = {
	params ["_soundSource"];

	if (isNull _soundSource) exitWith {};

	private _cfg = configFile >> "CfgSounds" >> RS_MH6V3_FUEL_DRAIN_SOUND;
	if (isClass _cfg) then {
		private _sound = getArray (_cfg >> "sound");
		if ((count _sound) > 0) exitWith {
			playSound3D [_sound # 0, _soundSource, false, getPosASL _soundSource, 2, 1, 35];
		};
	};
};

RS_MH6V3_fnc_fuelDrainSoundLocal = {
	params [
		"_vehicle",
		["_sessionId", "", [""]]
	];

	if !(hasInterface) exitWith {};
	if (isNull _vehicle) exitWith {};
	if (_sessionId != "" && {(_vehicle getVariable ["RS_LB_fuelDrainStoppedSessionLocal", ""]) == _sessionId}) exitWith {};
	if (_vehicle getVariable ["RS_LB_fuelDrainSoundLoopLocal", false]) exitWith {};

	if (_sessionId == "") then {
		_sessionId = format [
			"RS_MH6V3_fuelDrain_%1_%2",
			round (diag_tickTime * 1000),
			floor random 100000
		];
	};
	_vehicle setVariable ["RS_LB_fuelDrainSoundActive", true];
	_vehicle setVariable ["RS_LB_fuelDrainSoundLoopLocal", true];
	_vehicle setVariable ["RS_LB_fuelDrainSoundSessionLocal", _sessionId];
	_vehicle setVariable ["RS_LB_fuelDrainStoppedSessionLocal", nil];

	[_vehicle, _sessionId] spawn {
		params ["_vehicle", "_sessionId"];

		private _soundSource = "Land_HelipadEmpty_F" createVehicleLocal [0, 0, 0];
		_soundSource attachTo [_vehicle, [0, 0, 0]];
		_vehicle setVariable ["RS_LB_fuelDrainSoundSourceLocal", _soundSource];

		while {
			!isNull _vehicle
			&& {alive _vehicle}
			&& {_vehicle getVariable ["RS_LB_fuelDrainSoundActive", false]}
			&& {(_vehicle getVariable ["RS_LB_fuelDrainSoundSessionLocal", ""]) == _sessionId}
			&& {!isNull _soundSource}
		} do {
			[_soundSource] call RS_MH6V3_fnc_playFuelDrainSound;

			private _sleepUntil = time + RS_MH6V3_FUEL_DRAIN_SOUND_INTERVAL;
			waitUntil {
				sleep 0.1;
				time >= _sleepUntil
				|| {!(_vehicle getVariable ["RS_LB_fuelDrainSoundActive", false])}
				|| {(_vehicle getVariable ["RS_LB_fuelDrainSoundSessionLocal", ""]) != _sessionId}
				|| {isNull _vehicle}
				|| {!alive _vehicle}
				|| {isNull _soundSource}
			};
		};

		if (!isNull _soundSource) then {
			detach _soundSource;
			deleteVehicle _soundSource;
		};

		if (!isNull _vehicle) then {
			if ((_vehicle getVariable ["RS_LB_fuelDrainSoundSessionLocal", ""]) == _sessionId) then {
				_vehicle setVariable ["RS_LB_fuelDrainSoundSourceLocal", objNull];
				_vehicle setVariable ["RS_LB_fuelDrainSoundLoopLocal", false];
				_vehicle setVariable ["RS_LB_fuelDrainSoundSessionLocal", nil];
			};
		};
	};
};

RS_MH6V3_fnc_fuelDrainSoundStopLocal = {
	params [
		"_vehicle",
		["_sessionId", "", [""]]
	];

	if !(hasInterface) exitWith {};
	if (isNull _vehicle) exitWith {};

	private _activeSession = _vehicle getVariable ["RS_LB_fuelDrainSoundSessionLocal", ""];
	if (_sessionId != "") then {
		_vehicle setVariable ["RS_LB_fuelDrainStoppedSessionLocal", _sessionId];
		if (_activeSession != "" && {_activeSession != _sessionId}) exitWith {};
	};

	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", false];
	_vehicle setVariable ["RS_LB_fuelDrainSoundActive", false];
	_vehicle setVariable ["RS_LB_fuelDrainSoundSessionLocal", nil];
	_vehicle setVariable ["RS_LB_fuelDrainSoundLoopLocal", false];

	private _soundSource = _vehicle getVariable ["RS_LB_fuelDrainSoundSourceLocal", objNull];
	if (!isNull _soundSource) then {
		detach _soundSource;
		deleteVehicle _soundSource;
	};
	_vehicle setVariable ["RS_LB_fuelDrainSoundSourceLocal", objNull];
};

RS_MH6V3_fnc_cancelFuelDrain = {
	params ["_vehicle"];

	if (isNull _vehicle) exitWith {};

	_vehicle setVariable ["RS_MH6V3_cancelDrainFuel", true, true];
	_vehicle setVariable ["RS_MH6V3_drainingFuel", false, true];
	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", false, true];
	_vehicle setVariable ["RS_LB_fuelDrainSoundActive", false, true];
	private _soundSession = _vehicle getVariable ["RS_MH6V3_fuelDrainSoundSession", ""];
	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundSession", nil, true];
	["RS_MH6V3_fuelDrainSoundStop", [_vehicle, _soundSession]] call CBA_fnc_globalEvent;
};

RS_MH6V3_fnc_drainFuelLocal = {
	params [
		"_vehicle",
		"_targetFuel",
		["_caller", objNull],
		["_duration", RS_MH6V3_DRAIN_FUEL_TIME]
	];

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if (!local _vehicle) exitWith {
		[_vehicle, _targetFuel, _caller, _duration] remoteExec ["RS_MH6V3_fnc_drainFuelLocal", _vehicle];
	};

	[_vehicle, _targetFuel, _caller, _duration] spawn {
		params [
			"_vehicle",
			"_targetFuel",
			"_caller",
			"_duration"
		];

		private _startFuel = fuel _vehicle;
		private _steps = 50;
		private _delay = _duration / _steps;

		for "_i" from 1 to _steps do {
			if (isNull _vehicle || {!alive _vehicle}) exitWith {};
			if (_vehicle getVariable ["RS_MH6V3_cancelDrainFuel", false]) exitWith {};

			private _t = _i / _steps;
			private _fuel = _startFuel + ((_targetFuel - _startFuel) * _t);
			_vehicle setFuel ((_fuel max 0) min 1);
			sleep _delay;
		};

		if (!isNull _vehicle && {alive _vehicle}) then {
			if !(_vehicle getVariable ["RS_MH6V3_cancelDrainFuel", false]) then {
				_vehicle setFuel _targetFuel;
				[format ["RS MH-6V3: fuel drained to %1%2.", round (_targetFuel * 100), "%"], _vehicle] call RS_MH6V3_fnc_notifyAircrew;
			};

			_vehicle setVariable ["RS_MH6V3_drainingFuel", false, true];
			_vehicle setVariable ["RS_MH6V3_cancelDrainFuel", false, true];
			_vehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", false, true];
			_vehicle setVariable ["RS_LB_fuelDrainSoundActive", false, true];
			private _soundSession = _vehicle getVariable ["RS_MH6V3_fuelDrainSoundSession", ""];
			_vehicle setVariable ["RS_MH6V3_fuelDrainSoundSession", nil, true];
			["RS_MH6V3_fuelDrainSoundStop", [_vehicle, _soundSession]] call CBA_fnc_globalEvent;
		};
	};
};

RS_MH6V3_fnc_drainFuel = {
	params [
		"_vehicle",
		"_targetFuel",
		["_caller", objNull],
		["_duration", RS_MH6V3_DRAIN_FUEL_TIME]
	];

	if (!isServer && {[] call RS_MH6V3_fnc_useServerPackageEvents}) exitWith {
		["RS_MH6V3_requestDrainFuel", [_vehicle, _targetFuel, _caller, _duration]] call CBA_fnc_serverEvent;
	};

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_drainingFuel", false]) exitWith {};
	if ((fuel _vehicle) <= _targetFuel) exitWith {};

	_vehicle setVariable ["RS_MH6V3_drainingFuel", true, true];
	_vehicle setVariable ["RS_MH6V3_cancelDrainFuel", false, true];
	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", true, true];
	_vehicle setVariable ["RS_LB_fuelDrainSoundActive", true, true];
	private _soundSession = format [
		"RS_MH6V3_fuelDrain_%1_%2",
		round (diag_tickTime * 1000),
		floor random 100000
	];
	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundSession", _soundSession, true];
	["RS_MH6V3_fuelDrainSoundStart", [_vehicle, _soundSession]] call CBA_fnc_globalEvent;

	if (local _vehicle) then {
		[_vehicle, _targetFuel, _caller, _duration] call RS_MH6V3_fnc_drainFuelLocal;
	} else {
		[_vehicle, _targetFuel, _caller, _duration] remoteExec ["RS_MH6V3_fnc_drainFuelLocal", _vehicle];
	};
};

RS_MH6V3_fnc_startDrainFuel = {
	params [
		"_vehicle",
		"_targetFuel",
		["_caller", player]
	];

	if !(hasInterface) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_drainingFuel", false]) exitWith {};
	if ((fuel _vehicle) <= _targetFuel) exitWith {};

	[_vehicle, _targetFuel, _caller, RS_MH6V3_DRAIN_FUEL_TIME] call RS_MH6V3_fnc_drainFuel;
	[format ["RS MH-6V3: fuel drain started. Target: %1%2.", round (_targetFuel * 100), "%"], _vehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_stopDrainFuel = {
	params [
		"_vehicle",
		["_caller", player]
	];

	if !(hasInterface) exitWith {};
	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !(_vehicle getVariable ["RS_MH6V3_drainingFuel", false]) exitWith {};

	_vehicle setVariable ["RS_MH6V3_cancelDrainFuel", true, true];
	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", false, true];
	_vehicle setVariable ["RS_LB_fuelDrainSoundActive", false, true];
	private _soundSession = _vehicle getVariable ["RS_MH6V3_fuelDrainSoundSession", ""];
	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundSession", nil, true];
	["RS_MH6V3_fuelDrainSoundStop", [_vehicle, _soundSession]] call CBA_fnc_globalEvent;
	["RS MH-6V3: fuel drain stopped.", _vehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_isAmmoSupportVehicle = {
	params ["_source"];

	if (isNull _source || {!alive _source}) exitWith {false};

	private _cfg = configFile >> "CfgVehicles" >> typeOf _source;
	private _currentSupply = _source getVariable ["ace_rearm_currentSupply", 0];
	private _supply = _source getVariable ["ace_rearm_supply", 0];

	_source isKindOf "LandVehicle"
	&& {(getNumber (_cfg >> "transportAmmo")) > 0}
	|| {_source isKindOf "ReammoBox_F"}
	|| {(getNumber (_cfg >> "ace_rearm_defaultSupply")) > 0}
	|| {_source getVariable ["ace_rearm_isSupplyVehicle", false]}
	|| {_currentSupply isEqualType 0 && {_currentSupply > 0}}
	|| {_supply isEqualType 0 && {_supply > 0}}
};

RS_MH6V3_fnc_isNearAmmoSupport = {
	params ["_vehicle"];

	if (isNull _vehicle) exitWith {false};

	private _supportClasses = ["LandVehicle", "ReammoBox_F"];
	if (isClass (configFile >> "CfgVehicles" >> "AmmoCrates_NoInteractive_Large")) then {
		_supportClasses pushBackUnique "AmmoCrates_NoInteractive_Large";
	};

	private _sources = (nearestObjects [_vehicle, _supportClasses, RS_MH6V3_AMMO_SUPPORT_RADIUS]) select {
		_x != _vehicle && {[_x] call RS_MH6V3_fnc_isAmmoSupportVehicle}
	};

	!(_sources isEqualTo [])
};

RS_MH6V3_fnc_nearestC130 = {
	params [
		"_vehicle",
		["_radius", RS_MH6V3_C130_MODEL_CHANGE_PROTECT_RADIUS]
	];

	private _c130s = nearestObjects [_vehicle, [RS_MH6V3_C130_CLASS], _radius, true] select {
		alive _x
	};

	if (_c130s isEqualTo []) exitWith {objNull};

	([_c130s, [], {_x distance _vehicle}, "ASCEND"] call BIS_fnc_sortBy) # 0
};

RS_MH6V3_fnc_cachedPushC130 = {
	params ["_vehicle"];

	if (isNull _vehicle || {!alive _vehicle}) exitWith {objNull};

	private _now = diag_tickTime;
	private _cache = _vehicle getVariable ["RS_MH6V3_pushC130Cache", [objNull, -1]];
	_cache params [
		["_cachedC130", objNull],
		["_cacheTime", -1]
	];

	if ((_now - _cacheTime) < 1) exitWith {
		if (!isNull _cachedC130 && {alive _cachedC130}) then {_cachedC130} else {objNull}
	};

	private _searchRadius = missionNamespace getVariable ["SOAR_LB_PUSH_TOWARD_SEARCH_RADIUS", 120];
	private _c130 = [_vehicle, _searchRadius] call RS_MH6V3_fnc_nearestC130;
	if (isNull _c130 && {!isNil "SOAR_fnc_lbNearestC130"}) then {
		_c130 = [_vehicle, _searchRadius] call SOAR_fnc_lbNearestC130;
	};

	_vehicle setVariable ["RS_MH6V3_pushC130Cache", [_c130, _now], false];
	_c130
};

RS_MH6V3_fnc_canPushToC130Cached = {
	params ["_vehicle"];

	if (
		isNil "SOAR_fnc_lbStartPushPlacementPreview"
		|| {isNull _vehicle}
		|| {!alive _vehicle}
		|| {!(typeOf _vehicle in RS_MH6V3_SERVICE_CLASSES)}
		|| {!([_vehicle] call RS_MH6V3_fnc_canService)}
		|| {!isTouchingGround _vehicle}
		|| {abs speed _vehicle >= 1}
		|| {_vehicle getVariable ["SOAR_LB_pushing", false]}
	) exitWith {false};

	private _c130 = [_vehicle] call RS_MH6V3_fnc_cachedPushC130;
	!isNull _c130
	&& {isTouchingGround _c130}
	&& {abs speed _c130 < 1}
};

RS_MH6V3_fnc_protectC130ForModelChange = {
	params ["_c130"];

	if (isNull _c130 || {!alive _c130}) exitWith {};

	private _count = _c130 getVariable ["RS_LB_C130ModelChangeProtectionCount", 0];
	if (_count <= 0) then {
		_c130 setVariable ["RS_LB_C130ModelChangeDamageAllowed", isDamageAllowed _c130, false];
		_c130 setVariable ["RS_LB_C130ModelChangeSimulationEnabled", simulationEnabled _c130, false];
		_c130 allowDamage false;
		_c130 enableSimulationGlobal false;
	};

	_c130 setVariable ["RS_LB_C130ModelChangeProtectionCount", _count + 1, true];
};

RS_MH6V3_fnc_restoreC130AfterModelChange = {
	params ["_c130"];

	if (isNull _c130) exitWith {};

	private _count = (_c130 getVariable ["RS_LB_C130ModelChangeProtectionCount", 0]) - 1;
	_c130 setVariable ["RS_LB_C130ModelChangeProtectionCount", 0 max _count, true];

	if (_count > 0) exitWith {};

	_c130 enableSimulationGlobal (_c130 getVariable ["RS_LB_C130ModelChangeSimulationEnabled", true]);
	_c130 allowDamage (_c130 getVariable ["RS_LB_C130ModelChangeDamageAllowed", true]);
	_c130 setVariable ["RS_LB_C130ModelChangeSimulationEnabled", nil, false];
	_c130 setVariable ["RS_LB_C130ModelChangeDamageAllowed", nil, false];
};

RS_MH6V3_fnc_clearPylonAmmo = {
	params ["_vehicle"];

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};

	{
		if (_x != "") then {
			_vehicle setAmmoOnPylon [_forEachIndex + 1, 0];
		};
	} forEach getPylonMagazines _vehicle;
};

RS_MH6V3_fnc_enforceAttackPackageAmmoSource = {
	params ["_vehicle"];

	if (!isServer) exitWith {
		["RS_MH6V3_requestEnforceAmmoSource", [_vehicle]] call CBA_fnc_serverEvent;
	};

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if (typeOf _vehicle != RS_MH6V3_AH6_CLASS) exitWith {};
	if ([_vehicle] call RS_MH6V3_fnc_isNearAmmoSupport) exitWith {};

	[_vehicle] call RS_MH6V3_fnc_clearPylonAmmo;
	["RS MH-6V3: attack package ammo cleared. Rearm near an ammo support vehicle.", _vehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_openRearmMenu = {
	params ["_vehicle"];

	if !(hasInterface) exitWith {};

	[_vehicle] spawn {
		params ["_vehicle"];

		sleep 0.5;
		if (isNull _vehicle || {!alive _vehicle}) exitWith {};

		if (isNil "ace_pylons_fnc_showDialog") exitWith {
			if (isNil "ace_rearm_fnc_showDialog") exitWith {};
			[_vehicle] call ace_rearm_fnc_showDialog;
			sleep 1;
			waitUntil {
				sleep 0.5;
				!dialog || {isNull _vehicle} || {!alive _vehicle}
			};
			["RS_MH6V3_requestEnforceAmmoSource", [_vehicle]] call CBA_fnc_serverEvent;
		};

		[_vehicle] call ace_pylons_fnc_showDialog;
		sleep 1;
		waitUntil {
			sleep 0.5;
			!dialog || {isNull _vehicle} || {!alive _vehicle}
		};
		["RS_MH6V3_requestEnforceAmmoSource", [_vehicle]] call CBA_fnc_serverEvent;
	};
};

RS_MH6V3_fnc_setRotorDamage = {
	params [
		"_bird",
		"_damage"
	];

	{
		_bird setHitIndex [_x, _damage, false, objNull, objNull, true];
	} forEach RS_MH6V3_ROTOR_HIT_INDICES;
};

RS_MH6V3_fnc_applyRotorDamageGlobal = {
	params [
		"_bird",
		"_damage"
	];

	["RS_MH6V3_setRotorDamage", [_bird, _damage]] call CBA_fnc_globalEvent;
	[_bird, _damage] call RS_MH6V3_fnc_setRotorDamage;
};

RS_MH6V3_fnc_breakRotorsForCargo = {
	params ["_bird"];

	if (isNull _bird) exitWith {};

	private _damageAllowed = isDamageAllowed _bird;
	_bird allowDamage true;
	_bird setVariable ["RS_MH6V3_rotorsAssembled", false, true];
	_bird setVariable ["SOAR_LB_rotorsAssembled", false, true];
	[_bird, 1] call RS_MH6V3_fnc_applyRotorDamageGlobal;
	_bird allowDamage _damageAllowed;
};

RS_MH6V3_fnc_disassembleRotors = {
	params [
		"_vehicle",
		["_caller", objNull]
	];

	if (!isServer && {[] call RS_MH6V3_fnc_useServerPackageEvents}) exitWith {
		["RS_MH6V3_requestDisassembleRotors", [_vehicle, _caller]] call CBA_fnc_serverEvent;
	};

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};

	[_vehicle] call RS_MH6V3_fnc_breakRotorsForCargo;
	[format ["RS MH-6V3: rotors disassembled on %1.", typeOf _vehicle], _vehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_assembleRotors = {
	params [
		"_vehicle",
		["_caller", objNull]
	];

	if (!isServer && {[] call RS_MH6V3_fnc_useServerPackageEvents}) exitWith {
		["RS_MH6V3_requestAssembleRotors", [_vehicle, _caller]] call CBA_fnc_serverEvent;
	};

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_assemblingRotors", false]) exitWith {};

	_vehicle setVariable ["RS_MH6V3_assemblingRotors", true, true];

	[_vehicle] call RS_MH6V3_fnc_cancelFuelDrain;

	private _damageAllowed = isDamageAllowed _vehicle;
	_vehicle allowDamage true;
	[_vehicle, 0] call RS_MH6V3_fnc_applyRotorDamageGlobal;
	_vehicle allowDamage _damageAllowed;
	_vehicle setVariable ["RS_MH6V3_rotorsAssembled", true, true];
	_vehicle setVariable ["SOAR_LB_rotorsAssembled", true, true];
	_vehicle setVariable ["RS_MH6V3_assemblingRotors", false, true];

	[format ["RS MH-6V3: rotors assembled on %1.", typeOf _vehicle], _vehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_startAssembleRotors = {
	params [
		"_vehicle",
		["_caller", player]
	];

	if !(hasInterface) exitWith {};
	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_rotorsAssembled", true]) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_assemblingRotors", false]) exitWith {};

	private _fxId = [_vehicle, _caller, RS_MH6V3_ASSEMBLE_ROTORS_TIME] call RS_MH6V3_fnc_startServiceFx;

	[
		RS_MH6V3_ASSEMBLE_ROTORS_TIME,
		[_vehicle, _caller, _fxId],
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
			[_vehicle, _caller] call RS_MH6V3_fnc_assembleRotors;
		},
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
		},
		"Assembling Little Bird rotors"
	] call RS_MH6V3_fnc_runServiceTask;
};

RS_MH6V3_fnc_startDisassembleRotors = {
	params [
		"_vehicle",
		["_caller", player]
	];

	if !(hasInterface) exitWith {};
	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_rotorsAssembled", true] isEqualTo false) exitWith {};

	private _fxId = [_vehicle, _caller, RS_MH6V3_DISASSEMBLE_ROTORS_TIME] call RS_MH6V3_fnc_startServiceFx;

	[
		RS_MH6V3_DISASSEMBLE_ROTORS_TIME,
		[_vehicle, _caller, _fxId],
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
			[_vehicle, _caller] call RS_MH6V3_fnc_disassembleRotors;
		},
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
		},
		"Disassembling Little Bird rotors"
	] call RS_MH6V3_fnc_runServiceTask;
};

RS_MH6V3_fnc_convertVariant = {
	params [
		"_vehicle",
		"_newClass",
		["_caller", objNull]
	];

	if (!isServer && {[] call RS_MH6V3_fnc_useServerPackageEvents}) exitWith {
		["RS_MH6V3_requestConvertVariant", [_vehicle, _newClass, _caller]] call CBA_fnc_serverEvent;
	};

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if !(_newClass in RS_MH6V3_SERVICE_CLASSES) exitWith {};
	if (!isNull _caller && {!([_caller] call RS_MH6V3_fnc_hasToolkit)}) exitWith {};

	private _terrainPos = getPosATL _vehicle;
	_terrainPos set [2, 0];
	private _terrainLiftPos = +_terrainPos;
	_terrainLiftPos set [2, RS_MH6V3_SAFE_SPAWN_HEIGHT];
	private _dir = getDir _vehicle;
	private _terrainUp = surfaceNormal _terrainPos;
	private _fuel = fuel _vehicle;
	private _damage = damage _vehicle;
	private _damageAllowed = isDamageAllowed _vehicle;
	private _rotorsAssembled = _vehicle getVariable ["RS_MH6V3_rotorsAssembled", true];
	private _texture = _vehicle getVariable ["RS_MH6V3_liveryTexture", ""];
	private _protectedC130 = [_vehicle] call RS_MH6V3_fnc_nearestC130;

	[_vehicle] call RS_MH6V3_fnc_cancelFuelDrain;
	if (!isNull _protectedC130) then {
		[_protectedC130] call RS_MH6V3_fnc_protectC130ForModelChange;
	};
	deleteVehicle _vehicle;

	private _newVehicle = createVehicle [_newClass, [0, 0, 1000], [], 0, "CAN_COLLIDE"];
	_newVehicle allowDamage false;
	_newVehicle setDir _dir;
	_newVehicle setPosATL _terrainLiftPos;
	_newVehicle setVectorUp _terrainUp;
	_newVehicle setVelocity [0, 0, 0];
	_newVehicle setFuel _fuel;
	_newVehicle setDamage _damage;
	_newVehicle setVariable ["RS_MH6V3_rotorsAssembled", _rotorsAssembled, true];
	_newVehicle setVariable ["SOAR_LB_rotorsAssembled", _rotorsAssembled, true];
	_newVehicle setVariable ["RS_MH6V3_cancelDrainFuel", false, true];
	_newVehicle setVariable ["RS_MH6V3_drainingFuel", false, true];
	_newVehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", false, true];
	_newVehicle setVariable ["RS_LB_fuelDrainSoundActive", false, true];
	_newVehicle setVariable ["RS_MH6V3_quickFireArmed", false, true];
	_newVehicle setVariable ["RS_MH6V3_izlidEnabled", false, true];
	_newVehicle setVariable ["RS_MH6V3_izlidMode", 3, true];
	_newVehicle setVariable ["RS_MH6V3_izlidConeMode", 1, true];
	_newVehicle setVariable ["RS_MH6V3_izlidConeTriggerNarrow", false, true];
	_newVehicle setVariable ["RS_MH6V3_irIlluminatorBrightnessPercent", 100, true];
	_newVehicle setVariable ["RS_MH6V3_irIlluminatorBrightnessActive", nil, true];
	_newVehicle setVariable ["RS_MH6V3_activeCopilot", objNull, true];

	if (_texture != "") then {
		_newVehicle setObjectTextureGlobal [0, _texture];
		_newVehicle setVariable ["RS_MH6V3_liveryTexture", _texture, true];
	};

	if (_newClass == RS_MH6V3_AH6_CLASS) then {
		_newVehicle setVehicleAmmo 0;
		{
			_newVehicle setPylonLoadOut [_forEachIndex + 1, _x, true];
		} forEach getPylonMagazines _newVehicle;
		_newVehicle setVehicleAmmo 0;

		if (!isNull _caller) then {
			["RS_MH6V3_openRearmMenu", [_newVehicle], _caller] call CBA_fnc_targetEvent;
		};
	};

	if (!_rotorsAssembled) then {
		[_newVehicle] call RS_MH6V3_fnc_breakRotorsForCargo;
	};

	[_newVehicle, _terrainPos, _dir, _terrainUp, _damageAllowed, _protectedC130] spawn {
		params [
			"_newVehicle",
			"_terrainPos",
			"_dir",
			"_terrainUp",
			"_damageAllowed",
			["_protectedC130", objNull]
		];

		sleep 0.05;
		if (!isNull _newVehicle && {alive _newVehicle}) then {
			_newVehicle setDir _dir;
			_newVehicle setVehiclePosition [_terrainPos, [], 0, "CAN_COLLIDE"];
			_newVehicle setVectorUp _terrainUp;
			_newVehicle setVelocity [0, 0, 0];
		};

		sleep 0.95;
		if (!isNull _newVehicle && {alive _newVehicle}) then {
			_newVehicle setVelocity [0, 0, 0];
			_newVehicle allowDamage _damageAllowed;
		};

		if (!isNull _protectedC130) then {
			[_protectedC130] call RS_MH6V3_fnc_restoreC130AfterModelChange;
		};
	};

	[format ["RS MH-6V3: aircraft package changed to %1.", _newClass], _newVehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_removeAh6ArmamentsForCargo = {
	params [
		"_vehicle",
		["_caller", objNull],
		["_duration", RS_MH6V3_CONVERT_TIME]
	];

	if (!isServer && {[] call RS_MH6V3_fnc_useServerPackageEvents}) exitWith {
		["RS_MH6V3_requestRemoveAh6ArmamentsForCargo", [_vehicle, _caller, _duration]] call CBA_fnc_serverEvent;
	};

	if (isNull _vehicle || {!alive _vehicle} || {typeOf _vehicle != RS_MH6V3_AH6_CLASS}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (!isNull _caller && {!([_caller] call RS_MH6V3_fnc_hasToolkit)}) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_removingAh6Armaments", false]) exitWith {};

	_vehicle setVariable ["RS_MH6V3_removingAh6Armaments", true, true];
	_vehicle setVehicleAmmo 0;

	[_vehicle, _caller, _duration] spawn {
		params [
			"_vehicle",
			"_caller",
			"_duration"
		];

		private _loadedPylonIndexes = [];
		{
			if (_x != "") then {
				_loadedPylonIndexes pushBack (_forEachIndex + 1);
			};
		} forEach getPylonMagazines _vehicle;

		private _delay = if ((count _loadedPylonIndexes) > 0) then {
			_duration / (count _loadedPylonIndexes)
		} else {
			_duration
		};

		{
			if (isNull _vehicle || {!alive _vehicle}) exitWith {};
			sleep _delay;
			if (isNull _vehicle || {!alive _vehicle}) exitWith {};
			_vehicle setPylonLoadOut [_x, "", true];
			_vehicle setVehicleAmmo 0;
		} forEach _loadedPylonIndexes;

		if (isNull _vehicle || {!alive _vehicle}) exitWith {};

		_vehicle setVariable ["RS_MH6V3_removingAh6Armaments", false, true];
		[_vehicle, RS_MH6V3_OH6_CLASS, _caller] call RS_MH6V3_fnc_convertVariant;
	};
};

RS_MH6V3_fnc_startConvertVariant = {
	params [
		"_vehicle",
		"_newClass",
		["_caller", player]
	];

	if !(hasInterface) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if !([_caller] call RS_MH6V3_fnc_hasToolkit) exitWith {
		systemChat "RS MH-6V3: Toolkit required to change aircraft package.";
	};

	if ([] call RS_MH6V3_fnc_useServerPackageEvents) then {
		["RS_MH6V3_requestCancelFuelDrain", [_vehicle]] call CBA_fnc_serverEvent;
	} else {
		[_vehicle] call RS_MH6V3_fnc_cancelFuelDrain;
	};

	private _label = if (_newClass == RS_MH6V3_AH6_CLASS) then {
		"Installing AH-6 attack package"
	} else {
		"Installing MH-6 assault package"
	};
	private _fxId = [_vehicle, _caller, RS_MH6V3_CONVERT_TIME] call RS_MH6V3_fnc_startServiceFx;

	[
		RS_MH6V3_CONVERT_TIME,
		[_vehicle, _newClass, _caller, _fxId],
		{
			params ["_args"];
			_args params ["_vehicle", "_newClass", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
			[_vehicle, _newClass, _caller] call RS_MH6V3_fnc_convertVariant;
		},
		{
			params ["_args"];
			_args params ["_vehicle", "_newClass", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
		},
		_label
	] call RS_MH6V3_fnc_runServiceTask;
};

RS_MH6V3_fnc_startMh6CargoPrep = {
	params [
		"_vehicle",
		["_caller", player]
	];

	if !(hasInterface) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (typeOf _vehicle != RS_MH6V3_MH6_CLASS) exitWith {};
	if !([_caller] call RS_MH6V3_fnc_hasToolkit) exitWith {
		systemChat "RS MH-6V3: Toolkit required to change aircraft package.";
	};

	if ([] call RS_MH6V3_fnc_useServerPackageEvents) then {
		["RS_MH6V3_requestCancelFuelDrain", [_vehicle]] call CBA_fnc_serverEvent;
	} else {
		[_vehicle] call RS_MH6V3_fnc_cancelFuelDrain;
	};

	private _fxId = [_vehicle, _caller, RS_MH6V3_CONVERT_TIME] call RS_MH6V3_fnc_startServiceFx;

	[
		RS_MH6V3_CONVERT_TIME,
		[_vehicle, _caller, _fxId],
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
			[_vehicle, RS_MH6V3_OH6_CLASS, _caller] call RS_MH6V3_fnc_convertVariant;
		},
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
		},
		"Removing benches and FRIES bar"
	] call RS_MH6V3_fnc_runServiceTask;
};

RS_MH6V3_fnc_startAh6CargoPrep = {
	params [
		"_vehicle",
		["_caller", player]
	];

	if !(hasInterface) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (typeOf _vehicle != RS_MH6V3_AH6_CLASS) exitWith {};
	if !([_caller] call RS_MH6V3_fnc_hasToolkit) exitWith {
		systemChat "RS MH-6V3: Toolkit required to change aircraft package.";
	};
	if (_vehicle getVariable ["RS_MH6V3_removingAh6Armaments", false]) exitWith {};

	if ([] call RS_MH6V3_fnc_useServerPackageEvents) then {
		["RS_MH6V3_requestCancelFuelDrain", [_vehicle]] call CBA_fnc_serverEvent;
	} else {
		[_vehicle] call RS_MH6V3_fnc_cancelFuelDrain;
	};
	[_vehicle, _caller, RS_MH6V3_CONVERT_TIME] call RS_MH6V3_fnc_removeAh6ArmamentsForCargo;

	private _fxId = [_vehicle, _caller, RS_MH6V3_CONVERT_TIME] call RS_MH6V3_fnc_startServiceFx;

	[
		RS_MH6V3_CONVERT_TIME,
		[_vehicle, _caller, _fxId],
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
		},
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
		},
		"Removing AH-6 pylons and armaments"
	] call RS_MH6V3_fnc_runServiceTask;
};

RS_MH6V3_fnc_populateLogisticsManagement = {
	disableSerialization;

	private _display = uiNamespace getVariable ["RS_MH6V3_logisticsDisplay", displayNull];
	private _vehicle = uiNamespace getVariable ["RS_MH6V3_logisticsVehicle", objNull];
	if (isNull _display) exitWith {};

	private _aliveService =
		!isNull _vehicle
		&& {alive _vehicle}
		&& {typeOf _vehicle in RS_MH6V3_SERVICE_CLASSES};
	private _canService = _aliveService && {[_vehicle] call RS_MH6V3_fnc_canService};
	private _hasToolkit = [player] call RS_MH6V3_fnc_hasToolkit;
	private _vehicleType = if (_aliveService) then {typeOf _vehicle} else {""};

	(_display displayCtrl 86510) ctrlSetText (if (_aliveService) then {
		format [
			"%1 | Fuel %2%3 | Toolkit %4",
			_vehicleType,
			round ((fuel _vehicle) * 100),
			"%",
			if (_hasToolkit) then {"YES"} else {"NO"}
		]
	} else {
		"No supported MH/AH/OH-6 selected"
	});

	(_display displayCtrl 86520) ctrlEnable (_canService && {!(_vehicle getVariable ["RS_MH6V3_drainingFuel", false])} && {fuel _vehicle > 0.25});
	(_display displayCtrl 86521) ctrlEnable (_canService && {!(_vehicle getVariable ["RS_MH6V3_drainingFuel", false])} && {fuel _vehicle > 0});
	(_display displayCtrl 86522) ctrlEnable (_aliveService && {_vehicle getVariable ["RS_MH6V3_drainingFuel", false]});
	(_display displayCtrl 86523) ctrlEnable _aliveService;
	(_display displayCtrl 86524) ctrlEnable _aliveService;
	(_display displayCtrl 86526) ctrlEnable (_canService && {_vehicle getVariable ["RS_MH6V3_rotorsAssembled", true]});
	(_display displayCtrl 86527) ctrlEnable (_canService && {(_vehicle getVariable ["RS_MH6V3_rotorsAssembled", true]) isEqualTo false} && {!(_vehicle getVariable ["RS_MH6V3_assemblingRotors", false])});
	(_display displayCtrl 86528) ctrlEnable (_canService && {_vehicleType == RS_MH6V3_OH6_CLASS} && {_hasToolkit});
	(_display displayCtrl 86529) ctrlEnable (_canService && {_vehicleType == RS_MH6V3_OH6_CLASS} && {_hasToolkit});
	(_display displayCtrl 86530) ctrlEnable (_canService && {_vehicleType == RS_MH6V3_MH6_CLASS} && {_hasToolkit});
	(_display displayCtrl 86531) ctrlEnable (_canService && {_vehicleType == RS_MH6V3_AH6_CLASS} && {!(_vehicle getVariable ["RS_MH6V3_removingAh6Armaments", false])} && {_hasToolkit});

	private _canPushToC130 = _aliveService && {[_vehicle] call RS_MH6V3_fnc_canPushToC130Cached};
	(_display displayCtrl 86532) ctrlEnable _canPushToC130;
};

RS_MH6V3_fnc_openLogisticsManagement = {
	params [
		["_vehicle", objNull]
	];

	if !(hasInterface) exitWith {};
	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !(typeOf _vehicle in RS_MH6V3_SERVICE_CLASSES) exitWith {};

	uiNamespace setVariable ["RS_MH6V3_logisticsVehicle", _vehicle];
	createDialog "RS_MH6V3_LogisticsManagement";
};

RS_MH6V3_fnc_runLogisticsManagementAction = {
	params [
		["_action", ""]
	];

	private _vehicle = uiNamespace getVariable ["RS_MH6V3_logisticsVehicle", objNull];
	if (isNull _vehicle || {!alive _vehicle}) exitWith {
		closeDialog 0;
	};

	switch (toLower _action) do {
		case "drain25": {
			[_vehicle, 0.25, player] call RS_MH6V3_fnc_startDrainFuel;
		};
		case "drainempty": {
			[_vehicle, 0, player] call RS_MH6V3_fnc_startDrainFuel;
		};
		case "stopdrain": {
			[_vehicle, player] call RS_MH6V3_fnc_stopDrainFuel;
		};
		case "livery": {
			closeDialog 0;
			[_vehicle] call RS_MH6V3_fnc_openLiveryMenu;
		};
		case "cameras": {
			[_vehicle] call RS_MH6V3_fnc_resetCameras;
		};
		case "disassemble": {
			[_vehicle, player] call RS_MH6V3_fnc_startDisassembleRotors;
		};
		case "assemble": {
			[_vehicle, player] call RS_MH6V3_fnc_startAssembleRotors;
		};
		case "installmh6": {
			[_vehicle, RS_MH6V3_MH6_CLASS, player] call RS_MH6V3_fnc_startConvertVariant;
		};
		case "installah6": {
			[_vehicle, RS_MH6V3_AH6_CLASS, player] call RS_MH6V3_fnc_startConvertVariant;
		};
		case "removemh6": {
			[_vehicle, player] call RS_MH6V3_fnc_startMh6CargoPrep;
		};
		case "removeah6": {
			[_vehicle, player] call RS_MH6V3_fnc_startAh6CargoPrep;
		};
		case "pushc130": {
			if !(isNil "SOAR_fnc_lbStartPushPlacementPreview") then {
				[_vehicle, player] call SOAR_fnc_lbStartPushPlacementPreview;
			};
		};
	};

	if !(toLower _action in ["livery", "cameras", "stopdrain", "pushc130"]) then {
		closeDialog 0;
	} else {
		[] call RS_MH6V3_fnc_populateLogisticsManagement;
	};
};

RS_MH6V3_fnc_initVanillaActions = {
	if !(hasInterface) exitWith {};
	if (missionNamespace getVariable ["RS_MH6V3_vanillaActionsStarted", false]) exitWith {};
	missionNamespace setVariable ["RS_MH6V3_vanillaActionsStarted", true];

	RS_MH6V3_fnc_addVanillaActionsToVehicle = {
		params ["_vehicle"];

		if (isNull _vehicle || {!alive _vehicle}) exitWith {};
		if !(typeOf _vehicle in RS_MH6V3_SERVICE_CLASSES) exitWith {};

		if (isNil {_vehicle getVariable "RS_MH6V3_vanillaLogisticsActionId"}) then {
			private _logisticsId = _vehicle addAction [
				"<t color='#8B0000'>MH-6 Logistics Management</t>",
				{
					params ["_target"];
					[_target] call RS_MH6V3_fnc_openLogisticsManagement;
				},
				nil,
				50,
				true,
				true,
				"",
				"alive _target && {typeOf _target in RS_MH6V3_SERVICE_CLASSES} && {vehicle _this == _this} && {_this distance _target <= 6}",
				6,
				false,
				"",
				""
			];
			_vehicle setVariable ["RS_MH6V3_vanillaLogisticsActionId", _logisticsId];
		};

		if (isNil {_vehicle getVariable "RS_MH6V3_vanillaResetCameraActionId"}) then {
			private _resetCameraId = _vehicle addAction [
				"<t color='#8B0000'>Reset Cameras</t>",
				{
					params ["_target"];
					[_target] call RS_MH6V3_fnc_resetCameras;
				},
				nil,
				49,
				false,
				true,
				"",
				"alive _target && {typeOf _target in RS_MH6V3_SERVICE_CLASSES} && {vehicle _this == _target} && {_this in [driver _target, gunner _target, _target turretUnit [0]]}",
				-1,
				false,
				"",
				""
			];
			_vehicle setVariable ["RS_MH6V3_vanillaResetCameraActionId", _resetCameraId];
		};

		if (typeOf _vehicle == RS_MH6V3_AH6_CLASS && {isNil {_vehicle getVariable "RS_MH6V3_vanillaHydraActionId"}}) then {
			private _hydraId = _vehicle addAction [
				"<t color='#8B0000'>Hydra Sequence UI</t>",
				{
					params ["_target"];
					[_target] call RS_MH6V3_fnc_openQuickFirePylonMenu;
				},
				nil,
				48,
				false,
				true,
				"",
				"alive _target && {typeOf _target == RS_MH6V3_AH6_CLASS} && {vehicle _this == _target} && {currentPilot _target isEqualTo _this} && {!(([_target] call RS_MH6V3_fnc_getHydraPylonData) isEqualTo [])}",
				-1,
				false,
				"",
				""
			];
			_vehicle setVariable ["RS_MH6V3_vanillaHydraActionId", _hydraId];
		};
	};

	{
		[_x, "init", {
			params ["_vehicle"];
			[_vehicle] call RS_MH6V3_fnc_addVanillaActionsToVehicle;
		}, false] call CBA_fnc_addClassEventHandler;
	} forEach RS_MH6V3_SERVICE_CLASSES;

	{
		[_x] call RS_MH6V3_fnc_addVanillaActionsToVehicle;
	} forEach (entities [RS_MH6V3_SERVICE_CLASSES, [], false, false] select {
		alive _x
	});
};

if (!hasInterface) exitWith {};
if !(isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) exitWith {
	[] call RS_MH6V3_fnc_initVanillaActions;
};
if (missionNamespace getVariable ["RS_MH6V3_aceActionsAdded", false]) exitWith {};
missionNamespace setVariable ["RS_MH6V3_aceActionsAdded", true];

private _rootAction = [
	"RS_MH6V3_packages",
	"MH/AH-6 Logistics",
	"",
	{},
	{
		params ["_target"];
		alive _target
		&& {typeOf _target in RS_MH6V3_SERVICE_CLASSES}
	}
] call ace_interact_menu_fnc_createAction;

private _drainFuel25Action = [
	"RS_MH6V3_drain_fuel_25",
	"Drain Fuel to 25%",
	"",
	{
		params ["_target"];
		[_target, 0.25, player] call RS_MH6V3_fnc_startDrainFuel;
	},
	{
		params ["_target"];
		[_target] call RS_MH6V3_fnc_canService
		&& {!(_target getVariable ["RS_MH6V3_drainingFuel", false])}
		&& {fuel _target > 0.25}
	}
] call ace_interact_menu_fnc_createAction;

private _drainFuelEmptyAction = [
	"RS_MH6V3_drain_fuel_empty",
	"Drain Fuel to Empty",
	"",
	{
		params ["_target"];
		[_target, 0, player] call RS_MH6V3_fnc_startDrainFuel;
	},
	{
		params ["_target"];
		[_target] call RS_MH6V3_fnc_canService
		&& {!(_target getVariable ["RS_MH6V3_drainingFuel", false])}
		&& {fuel _target > 0}
	}
] call ace_interact_menu_fnc_createAction;

private _stopDrainFuelAction = [
	"RS_MH6V3_stop_drain_fuel",
	"Stop Fuel Drain",
	"",
	{
		params ["_target"];
		[_target, player] call RS_MH6V3_fnc_stopDrainFuel;
	},
	{
		params ["_target"];
		alive _target
		&& {typeOf _target in RS_MH6V3_SERVICE_CLASSES}
		&& {_target getVariable ["RS_MH6V3_drainingFuel", false]}
	}
] call ace_interact_menu_fnc_createAction;

private _liveryAction = [
	"RS_MH6V3_open_livery_menu",
	"Change Livery",
	"",
	{
		params ["_target"];
		[_target] call RS_MH6V3_fnc_openLiveryMenu;
	},
	{
		params ["_target"];
		alive _target
		&& {typeOf _target in RS_MH6V3_SERVICE_CLASSES}
	}
] call ace_interact_menu_fnc_createAction;

private _cameraResetAction = [
	"RS_MH6V3_reset_cameras",
	"Reset Cameras",
	"",
	{
		params ["_target"];
		[_target] call RS_MH6V3_fnc_resetCameras;
	},
	{
		params [
			"_target",
			"_player"
		];
		alive _target
		&& {typeOf _target in RS_MH6V3_SERVICE_CLASSES}
		&& {_player in [driver _target, gunner _target]}
	}
] call ace_interact_menu_fnc_createAction;

private _acreRadioProgrammerAction = [
	"RS_MH6V3_acre_radio_programmer",
	"ACRE Radio Programming",
	"",
	{
		params ["_target"];
		[_target] call RS_MH6V3_fnc_openACRERadioProgrammer;
	},
	{
		params [
			"_target",
			"_player"
		];
		alive _target
		&& {typeOf _target in RS_MH6V3_SERVICE_CLASSES}
		&& {_player in [driver _target, gunner _target, _target turretUnit [0]]}
		&& {[] call RS_MH6V3_fnc_isACREAvailable}
	}
] call ace_interact_menu_fnc_createAction;

private _acreRadioProgrammerSelfAction = [
	"RS_MH6V3_acre_radio_programmer_self",
	"ACRE Radio Management",
	"",
	{
		[vehicle player] call RS_MH6V3_fnc_openACRERadioProgrammer;
	},
	{
		private _vehicle = vehicle player;
		!isNull _vehicle
		&& {_vehicle != player}
		&& {alive _vehicle}
		&& {typeOf _vehicle in RS_MH6V3_SERVICE_CLASSES}
		&& {player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]]}
		&& {[] call RS_MH6V3_fnc_isACREAvailable}
	}
] call ace_interact_menu_fnc_createAction;

private _izlidModeActionRoot = [
	"RS_MH6V3_izlid_mode",
	"IZLID / Illuminator Mode",
	"",
	{},
	{
		params [
			"_target",
			"_player"
		];

		alive _target
		&& {_target isKindOf "RHS_MELB_AH6M"}
		&& {_player in [driver _target, _target turretUnit [0]]}
	}
] call ace_interact_menu_fnc_createAction;

private _pilotIZLIDAction = [
	"RS_MH6V3_pilot_directed_izlid",
	"Toggle Handheld IZLID",
	"",
	{
		[] call RS_MH6V3_fnc_togglePilotIZLID;
	},
	{
		params [
			"_target",
			"_player"
		];

		alive _target
		&& {typeOf _target in RS_MH6V3_SERVICE_CLASSES}
		&& {_player isEqualTo currentPilot _target}
	}
] call ace_interact_menu_fnc_createAction;

private _quickFirePylonMenuAction = [
	"RS_MH6V3_quick_fire_pylon_menu",
	"Hydra Rocket Ripple Configuration",
	"",
	{
		params ["_target", "_player"];
		[vehicle _player] call RS_MH6V3_fnc_openQuickFirePylonMenu;
	},
	{
		params ["_target", "_player"];
		private _vehicle = vehicle _player;

		_vehicle != _player
		&& {alive _vehicle}
		&& {typeOf _vehicle == RS_MH6V3_AH6_CLASS}
		&& {currentPilot _vehicle isEqualTo _player}
		&& {!(([_vehicle] call RS_MH6V3_fnc_getHydraPylonData) isEqualTo [])}
	}
] call ace_interact_menu_fnc_createAction;

private _disassembleAction = [
	"RS_MH6V3_disassemble_rotors",
	"Disassemble Rotors",
	"",
	{
		params ["_target"];
		[_target, player] call RS_MH6V3_fnc_startDisassembleRotors;
	},
	{
		params [
			"_target",
			"_player",
			"_params"
		];
		_params params ["_servicePos"];
		[_target] call RS_MH6V3_fnc_canService
		&& {_target getVariable ["RS_MH6V3_rotorsAssembled", true]}
		&& {_player distance (_target modelToWorld _servicePos) <= 2.5}
	},
	{},
	[RS_MH6V3_ROTOR_SERVICE_POSITION],
	RS_MH6V3_ROTOR_SERVICE_POSITION,
	2.5
] call ace_interact_menu_fnc_createAction;

private _assembleAction = [
	"RS_MH6V3_assemble_rotors",
	"Assemble Rotors",
	"",
	{
		params ["_target"];
		[_target, player] call RS_MH6V3_fnc_startAssembleRotors;
	},
	{
		params [
			"_target",
			"_player",
			"_params"
		];
		_params params ["_servicePos"];
		[_target] call RS_MH6V3_fnc_canService
		&& {_target getVariable ["RS_MH6V3_rotorsAssembled", true] isEqualTo false}
		&& {!(_target getVariable ["RS_MH6V3_assemblingRotors", false])}
		&& {_player distance (_target modelToWorld _servicePos) <= 2.5}
	},
	{},
	[RS_MH6V3_ROTOR_SERVICE_POSITION],
	RS_MH6V3_ROTOR_SERVICE_POSITION,
	2.5
] call ace_interact_menu_fnc_createAction;

private _pushPlacementAction = [
	"RS_MH6V3_push_place_c130",
	"Position Near C-130",
	"",
	{
		params ["_target"];
		[_target, player] call SOAR_fnc_lbStartPushPlacementPreview;
	},
	{
		params ["_target"];
		[_target] call RS_MH6V3_fnc_canPushToC130Cached
	}
] call ace_interact_menu_fnc_createAction;

{
	[_x, 0, ["ACE_MainActions"], _rootAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, [], _disassembleAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, [], _assembleAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _pushPlacementAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _drainFuel25Action, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _drainFuelEmptyAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _stopDrainFuelAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _liveryAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _cameraResetAction, true] call ace_interact_menu_fnc_addActionToClass;
} forEach RS_MH6V3_SERVICE_CLASSES;

[RS_MH6V3_AH6_CLASS, 0, ["ACE_MainActions"], _izlidModeActionRoot, true] call ace_interact_menu_fnc_addActionToClass;
[RS_MH6V3_AH6_CLASS, 0, ["ACE_MainActions", "RS_MH6V3_izlid_mode"], _pilotIZLIDAction, true] call ace_interact_menu_fnc_addActionToClass;
[RS_MH6V3_MH6_CLASS, 0, ["ACE_MainActions"], _pilotIZLIDAction, true] call ace_interact_menu_fnc_addActionToClass;
[RS_MH6V3_OH6_CLASS, 0, ["ACE_MainActions"], _pilotIZLIDAction, true] call ace_interact_menu_fnc_addActionToClass;
[RS_MH6V3_AH6_CLASS, 1, ["ACE_SelfActions"], _quickFirePylonMenuAction, true] call ace_interact_menu_fnc_addActionToClass;

if ([] call RS_MH6V3_fnc_isACREAvailable) then {
	{
		[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _acreRadioProgrammerAction, true] call ace_interact_menu_fnc_addActionToClass;
	} forEach RS_MH6V3_SERVICE_CLASSES;

	[RS_MH6V3_AH6_CLASS, 1, ["ACE_SelfActions"], _acreRadioProgrammerSelfAction, true] call ace_interact_menu_fnc_addActionToClass;
};

{
	_x params ["_id", "_label", "_mode", "_coneMode"];

	private _izlidModeAction = [
		format ["RS_MH6V3_izlid_mode_%1", _id],
		_label,
		"",
		{
			params [
				"_target",
				"_player",
				"_params"
			];
			_params params ["_mode", "_coneMode"];

			[_target, _mode, _coneMode] call RS_MH6V3_fnc_setIZLIDMode;
		},
		{
			params [
				"_target",
				"_player",
				"_params"
			];
			_params params ["_mode", "_coneMode"];

			alive _target
			&& {_target isKindOf "RHS_MELB_AH6M"}
			&& {_player in [driver _target, _target turretUnit [0]]}
			&& {
				(_target getVariable ["RS_MH6V3_izlidMode", 3]) != _mode
				|| {(_target getVariable ["RS_MH6V3_izlidConeMode", 1]) != _coneMode}
			}
		},
		{},
		[_mode, _coneMode]
	] call ace_interact_menu_fnc_createAction;

	[RS_MH6V3_AH6_CLASS, 0, ["ACE_MainActions", "RS_MH6V3_izlid_mode"], _izlidModeAction, true] call ace_interact_menu_fnc_addActionToClass;
} forEach [
	["izlid", "IZLID Only", 1, 1],
	["illum_wide", "IR Illuminator Only - Wide", 2, 1],
	["illum_narrow", "IR Illuminator Only - Narrow", 2, 2],
	["illum_dynamic", "IR Illuminator Only - Dynamic", 2, 3],
	["combined_wide", "IZLID / IR Illuminator - Wide", 3, 1],
	["combined_narrow", "IZLID / IR Illuminator - Narrow", 3, 2],
	["combined_dynamic", "IZLID / IR Illuminator - Dynamic", 3, 3]
];

{
	private _position = _x;
	private _action = [
		format ["RS_MH6V3_remove_mh6_package_%1", _forEachIndex + 1],
		"Remove Benches and FRIES Bar",
		"",
		{
			params ["_target"];
			[_target, player] call RS_MH6V3_fnc_startMh6CargoPrep;
		},
		{
			params [
				"_target",
				"_player",
				"_params"
			];
			_params params ["_servicePos"];
			[_target] call RS_MH6V3_fnc_canService
			&& {typeOf _target == RS_MH6V3_MH6_CLASS}
			&& {[_player] call RS_MH6V3_fnc_hasToolkit}
			&& {_player distance (_target modelToWorld _servicePos) <= 2.5}
		},
		{},
		[_position],
		_position,
		2.5
	] call ace_interact_menu_fnc_createAction;

	[RS_MH6V3_MH6_CLASS, 0, [], _action, true] call ace_interact_menu_fnc_addActionToClass;
} forEach RS_MH6V3_MH6_PACKAGE_POSITIONS;

{
	private _position = _x;
	private _action = [
		format ["RS_MH6V3_install_mh6_package_%1", _forEachIndex + 1],
		"Install Assault Package",
		"",
		{
			params ["_target"];
			[_target, RS_MH6V3_MH6_CLASS, player] call RS_MH6V3_fnc_startConvertVariant;
		},
		{
			params [
				"_target",
				"_player",
				"_params"
			];
			_params params ["_servicePos"];
			[_target] call RS_MH6V3_fnc_canService
			&& {typeOf _target == RS_MH6V3_OH6_CLASS}
			&& {[_player] call RS_MH6V3_fnc_hasToolkit}
			&& {_player distance (_target modelToWorld _servicePos) <= 2.5}
		},
		{},
		[_position],
		_position,
		2.5
	] call ace_interact_menu_fnc_createAction;

	[RS_MH6V3_OH6_CLASS, 0, [], _action, true] call ace_interact_menu_fnc_addActionToClass;
} forEach RS_MH6V3_MH6_PACKAGE_POSITIONS;

private _ah6PackageAction = [
	"RS_MH6V3_remove_ah6_pylons",
	"Remove Pylons and Armaments",
	"",
	{
		params ["_target"];
		[_target, player] call RS_MH6V3_fnc_startAh6CargoPrep;
	},
	{
		params [
			"_target",
			"_player",
			"_params"
		];
		_params params ["_servicePos"];
		[_target] call RS_MH6V3_fnc_canService
		&& {typeOf _target == RS_MH6V3_AH6_CLASS}
		&& {!(_target getVariable ["RS_MH6V3_removingAh6Armaments", false])}
		&& {[_player] call RS_MH6V3_fnc_hasToolkit}
		&& {_player distance (_target modelToWorld _servicePos) <= RS_MH6V3_AH6_PACKAGE_DISTANCE}
	},
	{},
	[RS_MH6V3_AH6_PACKAGE_POSITION],
	RS_MH6V3_AH6_PACKAGE_POSITION,
	RS_MH6V3_AH6_PACKAGE_DISTANCE
] call ace_interact_menu_fnc_createAction;

private _ah6InstallAction = [
	"RS_MH6V3_install_ah6_pylons",
	"Install Attack Package",
	"",
	{
		params ["_target"];
		[_target, RS_MH6V3_AH6_CLASS, player] call RS_MH6V3_fnc_startConvertVariant;
	},
	{
		params [
			"_target",
			"_player",
			"_params"
		];
		_params params ["_servicePos"];
		[_target] call RS_MH6V3_fnc_canService
		&& {typeOf _target == RS_MH6V3_OH6_CLASS}
		&& {[_player] call RS_MH6V3_fnc_hasToolkit}
		&& {_player distance (_target modelToWorld _servicePos) <= RS_MH6V3_AH6_PACKAGE_DISTANCE}
	},
	{},
	[RS_MH6V3_AH6_PACKAGE_POSITION],
	RS_MH6V3_AH6_PACKAGE_POSITION,
	RS_MH6V3_AH6_PACKAGE_DISTANCE
] call ace_interact_menu_fnc_createAction;

[RS_MH6V3_AH6_CLASS, 0, [], _ah6PackageAction, true] call ace_interact_menu_fnc_addActionToClass;
[RS_MH6V3_OH6_CLASS, 0, [], _ah6InstallAction, true] call ace_interact_menu_fnc_addActionToClass;
