/*
	Shows TrueAFMHitters.paa once per client session for listed Steam IDs
	when that player enters an RS MELB aircraft as pilot or co-pilot.
	Add or remove Steam64 IDs in _steamIds below.
*/
if (!hasInterface) exitWith {};

private _forceShow = false;
if ((count _this) > 0 && {(_this # 0) isEqualType false}) then {
	_forceShow = _this # 0;
};

private _steamIds =
[
	"76561198415177675",
	"76561198321772098"
];

missionNamespace setVariable ["RS_MH6V3_trueAFMHittersSteamIds", _steamIds];

missionNamespace setVariable ["RS_MH6V3_fnc_showTrueAFMHittersLocal", {
	private _forceShow = false;
	if ((count _this) > 0 && {(_this # 0) isEqualType false}) then {
		_forceShow = _this # 0;
	};

	private _uid = getPlayerUID player;
	private _steamIds = missionNamespace getVariable ["RS_MH6V3_trueAFMHittersSteamIds", []];
	if (!_forceShow && {!(_uid in _steamIds)}) exitWith {};
	if (!_forceShow && {missionNamespace getVariable ["RS_MH6V3_trueAFMHittersShown", false]}) exitWith {};

	[] spawn {
		missionNamespace setVariable ["RS_MH6V3_trueAFMHittersShown", true];

		86600 cutRsc ["RS_MH6V3_TrueAFMHitters", "PLAIN", 1.25, false];
		sleep 2.75;
		86600 cutText ["", "PLAIN", 1.5];
		sleep 1.6;
	};
}];

if (_forceShow) exitWith {
	[true] call (missionNamespace getVariable ["RS_MH6V3_fnc_showTrueAFMHittersLocal", {}]);
};

["RS_MH6V3_showTrueAFMHitters", {
	[false] call (missionNamespace getVariable ["RS_MH6V3_fnc_showTrueAFMHittersLocal", {}]);
}] call CBA_fnc_addEventHandler;

missionNamespace setVariable ["RS_MH6V3_fnc_tryShowTrueAFMHittersForSeat", {
	params [
		["_unit", objNull],
		["_role", ""],
		["_vehicle", objNull],
		["_turret", []]
	];

	if (missionNamespace getVariable ["RS_MH6V3_trueAFMHittersShown", false]) exitWith {};
	if (isNull _unit || {!(_unit isEqualTo player)}) exitWith {};
	if (isNull _vehicle || {!(_vehicle isKindOf "RHS_MELB_base")}) exitWith {};

	private _isPilot = _role isEqualTo "driver";
	private _isCopilot = (_role in ["gunner", "commander"]) && {_turret isEqualTo [0]};
	if !(_isPilot || {_isCopilot}) exitWith {};

	[false] call (missionNamespace getVariable ["RS_MH6V3_fnc_showTrueAFMHittersLocal", {}]);
}];

[] spawn {
	waitUntil {
		sleep 0.25;
		!isNull player && {getPlayerUID player != ""}
	};

	private _uid = getPlayerUID player;
	private _steamIds = missionNamespace getVariable ["RS_MH6V3_trueAFMHittersSteamIds", []];
	if (!(_uid in _steamIds)) exitWith {};

	player addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle", "_turret"];
		[_unit, _role, _vehicle, _turret] call (missionNamespace getVariable ["RS_MH6V3_fnc_tryShowTrueAFMHittersForSeat", {}]);
	}];

	player addEventHandler ["Respawn", {
		params ["_unit"];
		_unit addEventHandler ["GetInMan", {
			params ["_unit", "_role", "_vehicle", "_turret"];
			[_unit, _role, _vehicle, _turret] call (missionNamespace getVariable ["RS_MH6V3_fnc_tryShowTrueAFMHittersForSeat", {}]);
		}];
	}];

	while {!(missionNamespace getVariable ["RS_MH6V3_trueAFMHittersShown", false])} do {
		private _vehicle = vehicle player;
		if (!isNull _vehicle && {_vehicle != player} && {_vehicle isKindOf "RHS_MELB_base"}) then {
			private _isPilot = driver _vehicle isEqualTo player;
			private _isCopilot = (_vehicle turretUnit [0]) isEqualTo player;
			if (_isPilot || {_isCopilot}) then {
				[false] call (missionNamespace getVariable ["RS_MH6V3_fnc_showTrueAFMHittersLocal", {}]);
			};
		};

		sleep 0.25;
	};
};
