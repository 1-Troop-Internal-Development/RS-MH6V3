/*
	Reassign AH-6M pylon ownership after crew changes.
	Default owner is the pilot. If the copilot is the current pilot/controller,
	pylons move to turret [0] so the copilot gets the active weapon controls.
*/
private _vehicle = objNull;

if (_this isEqualType objNull) then {
	_vehicle = _this;
};

if (_this isEqualType []) then {
	{
		if (_x isEqualType objNull && {_x isKindOf "Air"}) exitWith {
			_vehicle = _x;
		};
	} forEach _this;
};

if (isNull _vehicle) exitWith {};

if (!local _vehicle) exitWith {
	[_vehicle] remoteExecCall ["RS_MH6V3_fnc_syncPylonOwner", _vehicle];
};

if !(_vehicle getVariable ["RS_MH6V3_pylonOwnerMonitor", false]) then {
	_vehicle setVariable ["RS_MH6V3_pylonOwnerMonitor", true];
	[_vehicle] spawn {
		params ["_vehicle"];

		while {!isNull _vehicle && {alive _vehicle}} do {
			[_vehicle] call RS_MH6V3_fnc_syncPylonOwner;
			sleep 1;
		};

		if (!isNull _vehicle) then {
			_vehicle setVariable ["RS_MH6V3_pylonOwnerMonitor", false];
		};
	};
};

[_vehicle] spawn {
	params ["_vehicle"];

	sleep 0.1;

	if (isNull _vehicle || {!local _vehicle}) exitWith {};

	private _ownerTurret = [];
	private _ownerKey = "driver";
	private _copilot = _vehicle turretUnit [0];

	if (!isNull _copilot && {currentPilot _vehicle isEqualTo _copilot}) then {
		_ownerTurret = [0];
		_ownerKey = "copilot";
	};

	private _ownerSignature = str [_ownerKey, getPylonMagazines _vehicle];

	if ((_vehicle getVariable ["RS_MH6V3_pylonOwner", ""]) != _ownerSignature) then {
		{
			private _pylonIndex = _forEachIndex + 1;
			if (_x != "") then {
				private _ammo = _vehicle ammoOnPylon _pylonIndex;
				_vehicle setPylonLoadOut [_pylonIndex, _x, true, _ownerTurret];
				_vehicle setAmmoOnPylon [_pylonIndex, _ammo];
			};
		} forEach getPylonMagazines _vehicle;

		_vehicle setVariable ["RS_MH6V3_pylonOwner", _ownerSignature];
	};
};
