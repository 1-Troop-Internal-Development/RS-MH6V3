params [["_vehicle", objNull, [objNull]]];

if (isNull _vehicle) exitWith {};
if !(_vehicle isKindOf "RHS_MELB_base") exitWith {};
if (!local _vehicle && {isServer}) exitWith {
	[_vehicle] remoteExecCall ["RS_MH6V3_fnc_applyLAIRCMMode", _vehicle];
};
if (!local _vehicle) exitWith {};

private _scriptedEnabled = missionNamespace getVariable ["RS_MH6V3_laircmEnabled", true];
private _serverLoaded = missionNamespace getVariable ["RS_MH6V3_laircmServerLoaded", isServer];
private _weapon = "rhsusf_weap_LWIRCM";
private _magazine = "rhsusf_mag_LWIRCM";
private _turrets = [[-1]] + (allTurrets [_vehicle, true]);

if (_scriptedEnabled && {_serverLoaded}) then {
	if (_weapon in weapons _vehicle) then {
		_vehicle removeWeaponGlobal _weapon;
	};

	_vehicle removeMagazines _magazine;
	{
		if (_weapon in (_vehicle weaponsTurret _x)) then {
			_vehicle removeWeaponTurret [_weapon, _x];
		};
		_vehicle removeMagazinesTurret [_magazine, _x];
	} forEach _turrets;
} else {
	if (_weapon in weapons _vehicle) then {
		_vehicle removeWeaponGlobal _weapon;
	};

	_vehicle removeMagazines _magazine;
	{
		if (_weapon in (_vehicle weaponsTurret _x)) then {
			_vehicle removeWeaponTurret [_weapon, _x];
		};
		_vehicle removeMagazinesTurret [_magazine, _x];
	} forEach _turrets;

	for "_i" from 1 to 10 do {
		_vehicle addMagazineGlobal _magazine;
	};
	_vehicle addWeaponGlobal _weapon;

	if !(_weapon in (_vehicle weaponsTurret [-1])) then {
		_vehicle addMagazinesTurret [_magazine, [-1], 10];
		_vehicle addWeaponTurret [_weapon, [-1]];
	};
};
