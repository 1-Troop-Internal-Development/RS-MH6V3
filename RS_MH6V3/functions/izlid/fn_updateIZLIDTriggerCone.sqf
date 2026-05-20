if (!hasInterface) exitWith {};

private _previousVehicle = player getVariable ["RS_MH6V3_izlidTriggerConeVehicle", objNull];
private _vehicle = vehicle player;
private _validVehicle = !isNull _vehicle && {_vehicle isKindOf "RHS_MELB_AH6M"} && {player in _vehicle};

if (!isNull _previousVehicle && {!(_previousVehicle isEqualTo _vehicle)}) then {
	_previousVehicle setVariable ["RS_MH6V3_izlidConeTriggerNarrow", false, true];
};

if (!_validVehicle) exitWith {
	player setVariable ["RS_MH6V3_izlidTriggerConeVehicle", objNull, false];
};

private _isAircrew = player isEqualTo driver _vehicle || {player isEqualTo (_vehicle turretUnit [0])};
if (!_isAircrew) exitWith {
	_vehicle setVariable ["RS_MH6V3_izlidConeTriggerNarrow", false, true];
	player setVariable ["RS_MH6V3_izlidTriggerConeVehicle", objNull, false];
};

player setVariable ["RS_MH6V3_izlidTriggerConeVehicle", _vehicle, false];

private _activeCopilot = _vehicle getVariable ["RS_MH6V3_activeCopilot", objNull];
private _brightnessOwner = if (!isNull _activeCopilot) then {
	_activeCopilot
} else {
	driver _vehicle
};

if (player isEqualTo _brightnessOwner) then {
	private _brightnessPercent = missionNamespace getVariable ["RS_MH6V3_irIlluminatorBrightness", 100];
	_brightnessPercent = 0 max (_brightnessPercent min 100);

	if (_vehicle getVariable ["RS_MH6V3_izlidEnabled", false]) then {
		if (isNil {_vehicle getVariable "RS_MH6V3_irIlluminatorBrightnessActive"}) then {
			_vehicle setVariable ["RS_MH6V3_irIlluminatorBrightnessActive", _brightnessPercent, true];
		};
	} else {
		if !((_vehicle getVariable ["RS_MH6V3_irIlluminatorBrightnessPercent", -1]) isEqualTo _brightnessPercent) then {
			_vehicle setVariable ["RS_MH6V3_irIlluminatorBrightnessPercent", _brightnessPercent, true];
		};
	};
};

if (isNil {_vehicle getVariable "RS_MH6V3_izlidFiredEh"}) then {
	private _firedEh = _vehicle addEventHandler ["Fired", {
		params ["_vehicle"];

		_vehicle setVariable ["RS_MH6V3_izlidLastFiredTime", diag_tickTime, true];
	}];

	_vehicle setVariable ["RS_MH6V3_izlidFiredEh", _firedEh, false];
};

private _mode = _vehicle getVariable ["RS_MH6V3_izlidMode", 3];
private _coneMode = _vehicle getVariable ["RS_MH6V3_izlidConeMode", 1];
private _fireInputHeld =
	(inputAction "Fire") > 0 ||
	{(inputAction "DefaultAction") > 0} ||
	{missionNamespace getVariable ["RS_MH6V3_fireInputHeld", false]};
private _recentFire = (diag_tickTime - (_vehicle getVariable ["RS_MH6V3_izlidLastFiredTime", -10])) < 0.2;
private _shouldNarrow =
	alive _vehicle &&
	{isEngineOn _vehicle} &&
	{_vehicle getVariable ["RS_MH6V3_izlidEnabled", false]} &&
	{_mode in [2, 3]} &&
	{_coneMode == 3} &&
	{_fireInputHeld || {_recentFire}};

if ((_vehicle getVariable ["RS_MH6V3_izlidConeTriggerNarrow", false]) isEqualTo _shouldNarrow) exitWith {};

_vehicle setVariable ["RS_MH6V3_izlidConeTriggerNarrow", _shouldNarrow, true];
