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

[_vehicle] spawn {
	params ["_vehicle"];

	sleep 0.1;

	if (isNull _vehicle) exitWith {};

	if (!local _vehicle) exitWith {
		[_vehicle] remoteExecCall ["RS_MH6V3_fnc_syncPylonOwner", _vehicle];
	};

	private _copilot = _vehicle turretUnit [0];
	private _activeCopilot = _vehicle getVariable ["RS_MH6V3_activeCopilot", objNull];
	private _copilotHasControl = (
		!isNull _copilot
		&& {
			currentPilot _vehicle isEqualTo _copilot
			|| {_activeCopilot isEqualTo _copilot}
		}
	);
	private _overrides = _vehicle getVariable ["RS_MH6V3_pylonOwnerOverride", []];
	private _magazines = getPylonMagazines _vehicle;

	private _ownerKeys = [];
	{
		private _override = _overrides param [_forEachIndex, ""];
		private _ownerKey = "driver";
		if (_override == "copilot" && {!isNull _copilot}) then {
			_ownerKey = "copilot";
		} else {
			if (_override == "" && {_copilotHasControl}) then {
				_ownerKey = "copilot";
			};
		};
		_ownerKeys pushBack _ownerKey;
	} forEach _magazines;

	private _ownerSignature = str [_ownerKeys, _magazines];

	if ((_vehicle getVariable ["RS_MH6V3_pylonOwner", ""]) != _ownerSignature) then {
		private _allSucceeded = true;
		{
			private _pylonIndex = _forEachIndex + 1;
			if (_x != "") then {
				private _ownerTurret = if ((_ownerKeys select _forEachIndex) == "copilot") then {[0]} else {[]};
				private _ammo = _vehicle ammoOnPylon _pylonIndex;
				private _loaded = _vehicle setPylonLoadOut [_pylonIndex, _x, true, _ownerTurret];
				_allSucceeded = _allSucceeded && {_loaded};
				_vehicle setAmmoOnPylon [_pylonIndex, _ammo];
			};
		} forEach _magazines;

		if (_allSucceeded) then {
			_vehicle setVariable ["RS_MH6V3_pylonOwner", _ownerSignature, true];
		};
	};
};
