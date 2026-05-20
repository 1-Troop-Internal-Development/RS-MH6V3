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

RS_MH6V3_fnc_notifyAircrew = {
	params ["_message", ["_vehicle", objNull]];

	if (isNull _vehicle) exitWith {
		diag_log _message;
	};

	private _recipients = [driver _vehicle, gunner _vehicle] select {
		!isNull _x && {isPlayer _x}
	};

	{
		if (hasInterface && {player == _x}) then {
			systemChat _message;
		} else {
			[_message] remoteExecCall ["systemChat", owner _x];
		};
	} forEach (_recipients arrayIntersect _recipients);
};

RS_MH6V3_fnc_canService = {
	params ["_vehicle"];

	alive _vehicle
	&& {typeOf _vehicle in RS_MH6V3_SERVICE_CLASSES}
	&& {crew _vehicle isEqualTo []}
	&& {isNull attachedTo _vehicle}
};

RS_MH6V3_fnc_serviceFxLocalStart = {
	params ["_unit", "_duration", "_fxId"];

	if !(hasInterface) exitWith {};
	if (isNull _unit || {!local _unit}) exitWith {};
	if (vehicle _unit != _unit) exitWith {};

	_unit setVariable ["RS_MH6V3_serviceFxId", _fxId, true];
	_unit switchMove RS_MH6V3_SERVICE_ANIMATION;
	_unit playMoveNow RS_MH6V3_SERVICE_ANIMATION;

	[_unit, _duration, _fxId] spawn {
		params ["_unit", "_duration", "_fxId"];

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
	params ["_unit", "_fxId"];

	if !(hasInterface) exitWith {};
	if (isNull _unit || {!local _unit}) exitWith {};
	if !((_unit getVariable ["RS_MH6V3_serviceFxId", ""]) in [_fxId, ""]) exitWith {};

	_unit setVariable ["RS_MH6V3_serviceFxId", "", true];
	if (vehicle _unit == _unit) then {
		_unit switchMove "";
	};
};

RS_MH6V3_fnc_serviceSoundLocalStart = {
	params ["_vehicle", "_unit", "_duration", "_fxId"];

	if !(hasInterface) exitWith {};
	if (isNull _unit) exitWith {};

	[_vehicle, _unit, _duration, _fxId] spawn {
		params ["_vehicle", "_unit", "_duration", "_fxId"];

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
	};
};

RS_MH6V3_fnc_startServiceFx = {
	params ["_vehicle", "_unit", "_duration"];

	if (isNull _unit) exitWith {""};

	private _fxId = format ["RS_MH6V3_service_%1_%2", round (diag_tickTime * 1000), floor random 10000];
	_unit setVariable ["RS_MH6V3_serviceFxId", _fxId, true];
	[_unit, _duration, _fxId] remoteExecCall ["RS_MH6V3_fnc_serviceFxLocalStart", owner _unit];
	[_vehicle, _unit, _duration, _fxId] remoteExecCall ["RS_MH6V3_fnc_serviceSoundLocalStart", 0];
	_fxId
};

RS_MH6V3_fnc_stopServiceFx = {
	params ["_unit", "_fxId"];

	if (_fxId == "") exitWith {};
	_unit setVariable ["RS_MH6V3_serviceFxId", "", true];
	[_unit, _fxId] remoteExecCall ["RS_MH6V3_fnc_serviceFxLocalStop", owner _unit];
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
	params ["_vehicle"];

	if !(hasInterface) exitWith {};
	if (isNull _vehicle) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_fuelDrainSoundLoopLocal", false]) exitWith {};

	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundLoopLocal", true];

	[_vehicle] spawn {
		params ["_vehicle"];

		private _soundSource = "Land_HelipadEmpty_F" createVehicleLocal [0, 0, 0];
		_soundSource attachTo [_vehicle, [0, 0, 0]];
		_vehicle setVariable ["RS_MH6V3_fuelDrainSoundSourceLocal", _soundSource];

		while {
			!isNull _vehicle
			&& {alive _vehicle}
			&& {_vehicle getVariable ["RS_MH6V3_fuelDrainSoundActive", false]}
			&& {!isNull _soundSource}
		} do {
			[_soundSource] call RS_MH6V3_fnc_playFuelDrainSound;

			private _sleepUntil = time + RS_MH6V3_FUEL_DRAIN_SOUND_INTERVAL;
			waitUntil {
				sleep 0.1;
				time >= _sleepUntil
				|| {!(_vehicle getVariable ["RS_MH6V3_fuelDrainSoundActive", false])}
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
			_vehicle setVariable ["RS_MH6V3_fuelDrainSoundSourceLocal", objNull];
			_vehicle setVariable ["RS_MH6V3_fuelDrainSoundLoopLocal", false];
		};
	};
};

RS_MH6V3_fnc_fuelDrainSoundStopLocal = {
	params ["_vehicle"];

	if !(hasInterface) exitWith {};
	if (isNull _vehicle) exitWith {};

	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", false];

	private _soundSource = _vehicle getVariable ["RS_MH6V3_fuelDrainSoundSourceLocal", objNull];
	if (!isNull _soundSource) then {
		detach _soundSource;
		deleteVehicle _soundSource;
	};
};

RS_MH6V3_fnc_cancelFuelDrain = {
	params ["_vehicle"];

	if (isNull _vehicle) exitWith {};

	_vehicle setVariable ["RS_MH6V3_cancelDrainFuel", true, true];
	_vehicle setVariable ["RS_MH6V3_drainingFuel", false, true];
	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", false, true];
	[_vehicle] remoteExecCall ["RS_MH6V3_fnc_fuelDrainSoundStopLocal", 0];
};

RS_MH6V3_fnc_drainFuel = {
	params ["_vehicle", "_targetFuel", ["_caller", objNull], ["_duration", RS_MH6V3_DRAIN_FUEL_TIME]];

	if (!isServer) exitWith {
		[_vehicle, _targetFuel, _caller, _duration] remoteExec ["RS_MH6V3_fnc_drainFuel", 2];
	};

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_drainingFuel", false]) exitWith {};
	if ((fuel _vehicle) <= _targetFuel) exitWith {};

	_vehicle setVariable ["RS_MH6V3_drainingFuel", true, true];
	_vehicle setVariable ["RS_MH6V3_cancelDrainFuel", false, true];
	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", true, true];
	[_vehicle] remoteExecCall ["RS_MH6V3_fnc_fuelDrainSoundLocal", 0];

	[_vehicle, _targetFuel, _caller, _duration] spawn {
		params ["_vehicle", "_targetFuel", "_caller", "_duration"];

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
			[_vehicle] remoteExecCall ["RS_MH6V3_fnc_fuelDrainSoundStopLocal", 0];
		};
	};
};

RS_MH6V3_fnc_startDrainFuel = {
	params ["_vehicle", "_targetFuel", ["_caller", player]];

	if !(hasInterface) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_drainingFuel", false]) exitWith {};
	if ((fuel _vehicle) <= _targetFuel) exitWith {};

	[_vehicle, _targetFuel, _caller, RS_MH6V3_DRAIN_FUEL_TIME] remoteExec ["RS_MH6V3_fnc_drainFuel", 2];
	[format ["RS MH-6V3: fuel drain started. Target: %1%2.", round (_targetFuel * 100), "%"], _vehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_stopDrainFuel = {
	params ["_vehicle", ["_caller", player]];

	if !(hasInterface) exitWith {};
	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !(_vehicle getVariable ["RS_MH6V3_drainingFuel", false]) exitWith {};

	_vehicle setVariable ["RS_MH6V3_cancelDrainFuel", true, true];
	_vehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", false, true];
	[_vehicle] remoteExecCall ["RS_MH6V3_fnc_fuelDrainSoundStopLocal", 0];
	["RS MH-6V3: fuel drain stopped.", _vehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_isAmmoSupportVehicle = {
	params ["_source"];

	if (isNull _source || {!alive _source}) exitWith {false};
	if !(_source isKindOf "LandVehicle") exitWith {false};

	private _cfg = configFile >> "CfgVehicles" >> typeOf _source;
	private _currentSupply = _source getVariable ["ace_rearm_currentSupply", 0];
	private _supply = _source getVariable ["ace_rearm_supply", 0];

	(getNumber (_cfg >> "transportAmmo")) > 0
	|| {(getNumber (_cfg >> "ace_rearm_defaultSupply")) > 0}
	|| {_source getVariable ["ace_rearm_isSupplyVehicle", false]}
	|| {_currentSupply isEqualType 0 && {_currentSupply > 0}}
	|| {_supply isEqualType 0 && {_supply > 0}}
};

RS_MH6V3_fnc_isNearAmmoSupport = {
	params ["_vehicle"];

	if (isNull _vehicle) exitWith {false};

	private _sources = (nearestObjects [_vehicle, ["LandVehicle"], RS_MH6V3_AMMO_SUPPORT_RADIUS]) select {
		_x != _vehicle && {[_x] call RS_MH6V3_fnc_isAmmoSupportVehicle}
	};

	!(_sources isEqualTo [])
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
		[_vehicle] remoteExec ["RS_MH6V3_fnc_enforceAttackPackageAmmoSource", 2];
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
			[_vehicle] remoteExec ["RS_MH6V3_fnc_enforceAttackPackageAmmoSource", 2];
		};

		[_vehicle] call ace_pylons_fnc_showDialog;
		sleep 1;
		waitUntil {
			sleep 0.5;
			!dialog || {isNull _vehicle} || {!alive _vehicle}
		};
		[_vehicle] remoteExec ["RS_MH6V3_fnc_enforceAttackPackageAmmoSource", 2];
	};
};

RS_MH6V3_fnc_setRotorDamage = {
	params ["_bird", "_damage"];

	{
		_bird setHitIndex [_x, _damage, false, objNull, objNull, true];
	} forEach RS_MH6V3_ROTOR_HIT_INDICES;
};

RS_MH6V3_fnc_applyRotorDamageGlobal = {
	params ["_bird", "_damage"];

	[_bird, _damage] remoteExecCall ["RS_MH6V3_fnc_setRotorDamage", 0, _bird];
	[_bird, _damage] call RS_MH6V3_fnc_setRotorDamage;
};

RS_MH6V3_fnc_breakRotorsForCargo = {
	params ["_bird"];

	if (isNull _bird) exitWith {};

	private _damageAllowed = isDamageAllowed _bird;
	_bird allowDamage true;
	_bird setVariable ["RS_MH6V3_rotorsAssembled", false, true];
	[_bird, 1] call RS_MH6V3_fnc_applyRotorDamageGlobal;
	_bird allowDamage _damageAllowed;
};

RS_MH6V3_fnc_disassembleRotors = {
	params ["_vehicle", ["_caller", objNull]];

	if (!isServer) exitWith {
		[_vehicle, _caller] remoteExec ["RS_MH6V3_fnc_disassembleRotors", 2];
	};

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};

	[_vehicle] call RS_MH6V3_fnc_breakRotorsForCargo;
	[format ["RS MH-6V3: rotors disassembled on %1.", typeOf _vehicle], _vehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_assembleRotors = {
	params ["_vehicle", ["_caller", objNull]];

	if (!isServer) exitWith {
		[_vehicle, _caller] remoteExec ["RS_MH6V3_fnc_assembleRotors", 2];
	};

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_assemblingRotors", false]) exitWith {};

	_vehicle setVariable ["RS_MH6V3_assemblingRotors", true, true];

	private _className = typeOf _vehicle;
	private _pos = getPosWorld _vehicle;
	private _dir = getDir _vehicle;
	private _vectorUp = vectorUp _vehicle;
	private _fuel = fuel _vehicle;
	private _texture = (_vehicle getVariable ["RS_MH6V3_liveryTexture", ""]);

	[_vehicle] call RS_MH6V3_fnc_cancelFuelDrain;
	deleteVehicle _vehicle;

	private _newVehicle = createVehicle [_className, [0, 0, 1000], [], 0, "CAN_COLLIDE"];
	_newVehicle setPosWorld _pos;
	_newVehicle setDir _dir;
	_newVehicle setVectorUp _vectorUp;
	_newVehicle setFuel _fuel;
	_newVehicle setDamage 0;
	_newVehicle setVariable ["RS_MH6V3_rotorsAssembled", true, true];
	_newVehicle setVariable ["RS_MH6V3_assemblingRotors", false, true];
	_newVehicle setVariable ["RS_MH6V3_cancelDrainFuel", false, true];
	_newVehicle setVariable ["RS_MH6V3_drainingFuel", false, true];
	_newVehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", false, true];
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

	[format ["RS MH-6V3: rotors assembled on %1.", _className], _newVehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_startAssembleRotors = {
	params ["_vehicle", ["_caller", player]];

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
			[_vehicle, _caller] remoteExec ["RS_MH6V3_fnc_assembleRotors", 2];
		},
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
		},
		"Assembling Little Bird rotors"
	] call ace_common_fnc_progressBar;
};

RS_MH6V3_fnc_startDisassembleRotors = {
	params ["_vehicle", ["_caller", player]];

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
			[_vehicle, _caller] remoteExec ["RS_MH6V3_fnc_disassembleRotors", 2];
		},
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
		},
		"Disassembling Little Bird rotors"
	] call ace_common_fnc_progressBar;
};

RS_MH6V3_fnc_convertVariant = {
	params ["_vehicle", "_newClass", ["_caller", objNull]];

	if (!isServer) exitWith {
		[_vehicle, _newClass, _caller] remoteExec ["RS_MH6V3_fnc_convertVariant", 2];
	};

	if (isNull _vehicle || {!alive _vehicle}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if !(_newClass in RS_MH6V3_SERVICE_CLASSES) exitWith {};

	private _pos = getPosWorld _vehicle;
	private _dir = getDir _vehicle;
	private _vectorUp = vectorUp _vehicle;
	private _fuel = fuel _vehicle;
	private _damage = damage _vehicle;
	private _rotorsAssembled = _vehicle getVariable ["RS_MH6V3_rotorsAssembled", true];
	private _texture = _vehicle getVariable ["RS_MH6V3_liveryTexture", ""];

	[_vehicle] call RS_MH6V3_fnc_cancelFuelDrain;
	deleteVehicle _vehicle;

	private _newVehicle = createVehicle [_newClass, _pos, [], 0, "CAN_COLLIDE"];
	_newVehicle setPosWorld _pos;
	_newVehicle setDir _dir;
	_newVehicle setVectorUp _vectorUp;
	_newVehicle setFuel _fuel;
	_newVehicle setDamage _damage;
	_newVehicle setVariable ["RS_MH6V3_rotorsAssembled", _rotorsAssembled, true];
	_newVehicle setVariable ["RS_MH6V3_cancelDrainFuel", false, true];
	_newVehicle setVariable ["RS_MH6V3_drainingFuel", false, true];
	_newVehicle setVariable ["RS_MH6V3_fuelDrainSoundActive", false, true];
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
			[_newVehicle] remoteExecCall ["RS_MH6V3_fnc_openRearmMenu", owner _caller];
		};
	};

	if (!_rotorsAssembled) then {
		[_newVehicle] call RS_MH6V3_fnc_breakRotorsForCargo;
	};

	[format ["RS MH-6V3: aircraft package changed to %1.", _newClass], _newVehicle] call RS_MH6V3_fnc_notifyAircrew;
};

RS_MH6V3_fnc_removeAh6ArmamentsForCargo = {
	params ["_vehicle", ["_caller", objNull], ["_duration", RS_MH6V3_CONVERT_TIME]];

	if (!isServer) exitWith {
		[_vehicle, _caller, _duration] remoteExec ["RS_MH6V3_fnc_removeAh6ArmamentsForCargo", 2];
	};

	if (isNull _vehicle || {!alive _vehicle} || {typeOf _vehicle != RS_MH6V3_AH6_CLASS}) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_removingAh6Armaments", false]) exitWith {};

	_vehicle setVariable ["RS_MH6V3_removingAh6Armaments", true, true];
	_vehicle setVehicleAmmo 0;

	[_vehicle, _caller, _duration] spawn {
		params ["_vehicle", "_caller", "_duration"];

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
	params ["_vehicle", "_newClass", ["_caller", player]];

	if !(hasInterface) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};

	[_vehicle] remoteExecCall ["RS_MH6V3_fnc_cancelFuelDrain", 2];

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
			[_vehicle, _newClass, _caller] remoteExec ["RS_MH6V3_fnc_convertVariant", 2];
		},
		{
			params ["_args"];
			_args params ["_vehicle", "_newClass", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
		},
		_label
	] call ace_common_fnc_progressBar;
};

RS_MH6V3_fnc_startMh6CargoPrep = {
	params ["_vehicle", ["_caller", player]];

	if !(hasInterface) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (typeOf _vehicle != RS_MH6V3_MH6_CLASS) exitWith {};

	[_vehicle] remoteExecCall ["RS_MH6V3_fnc_cancelFuelDrain", 2];

	private _fxId = [_vehicle, _caller, RS_MH6V3_CONVERT_TIME] call RS_MH6V3_fnc_startServiceFx;

	[
		RS_MH6V3_CONVERT_TIME,
		[_vehicle, _caller, _fxId],
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
			[_vehicle, RS_MH6V3_OH6_CLASS, _caller] remoteExec ["RS_MH6V3_fnc_convertVariant", 2];
		},
		{
			params ["_args"];
			_args params ["_vehicle", "_caller", "_fxId"];
			[_caller, _fxId] call RS_MH6V3_fnc_stopServiceFx;
		},
		"Removing benches and FRIES bar"
	] call ace_common_fnc_progressBar;
};

RS_MH6V3_fnc_startAh6CargoPrep = {
	params ["_vehicle", ["_caller", player]];

	if !(hasInterface) exitWith {};
	if !([_vehicle] call RS_MH6V3_fnc_canService) exitWith {};
	if (typeOf _vehicle != RS_MH6V3_AH6_CLASS) exitWith {};
	if (_vehicle getVariable ["RS_MH6V3_removingAh6Armaments", false]) exitWith {};

	[_vehicle] remoteExecCall ["RS_MH6V3_fnc_cancelFuelDrain", 2];
	[_vehicle, _caller, RS_MH6V3_CONVERT_TIME] remoteExec ["RS_MH6V3_fnc_removeAh6ArmamentsForCargo", 2];

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
	] call ace_common_fnc_progressBar;
};

if (!hasInterface) exitWith {};
if !(isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) exitWith {};
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
		params ["_target", "_player"];
		alive _target
		&& {typeOf _target in RS_MH6V3_SERVICE_CLASSES}
		&& {_player in [driver _target, gunner _target]}
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
		params ["_target", "_player", "_params"];
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
		params ["_target", "_player", "_params"];
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

{
	[_x, 0, ["ACE_MainActions"], _rootAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, [], _disassembleAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, [], _assembleAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _drainFuel25Action, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _drainFuelEmptyAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _stopDrainFuelAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _liveryAction, true] call ace_interact_menu_fnc_addActionToClass;
	[_x, 0, ["ACE_MainActions", "RS_MH6V3_packages"], _cameraResetAction, true] call ace_interact_menu_fnc_addActionToClass;
} forEach RS_MH6V3_SERVICE_CLASSES;

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
			params ["_target", "_player", "_params"];
			_params params ["_servicePos"];
			[_target] call RS_MH6V3_fnc_canService
			&& {typeOf _target == RS_MH6V3_MH6_CLASS}
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
			params ["_target", "_player", "_params"];
			_params params ["_servicePos"];
			[_target] call RS_MH6V3_fnc_canService
			&& {typeOf _target == RS_MH6V3_OH6_CLASS}
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
		params ["_target", "_player", "_params"];
		_params params ["_servicePos"];
		[_target] call RS_MH6V3_fnc_canService
		&& {typeOf _target == RS_MH6V3_AH6_CLASS}
		&& {!(_target getVariable ["RS_MH6V3_removingAh6Armaments", false])}
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
		params ["_target", "_player", "_params"];
		_params params ["_servicePos"];
		[_target] call RS_MH6V3_fnc_canService
		&& {typeOf _target == RS_MH6V3_OH6_CLASS}
		&& {_player distance (_target modelToWorld _servicePos) <= RS_MH6V3_AH6_PACKAGE_DISTANCE}
	},
	{},
	[RS_MH6V3_AH6_PACKAGE_POSITION],
	RS_MH6V3_AH6_PACKAGE_POSITION,
	RS_MH6V3_AH6_PACKAGE_DISTANCE
] call ace_interact_menu_fnc_createAction;

[RS_MH6V3_AH6_CLASS, 0, [], _ah6PackageAction, true] call ace_interact_menu_fnc_addActionToClass;
[RS_MH6V3_OH6_CLASS, 0, [], _ah6InstallAction, true] call ace_interact_menu_fnc_addActionToClass;
