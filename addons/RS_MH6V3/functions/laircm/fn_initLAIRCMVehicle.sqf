params [["_vehicle", objNull, [objNull]]];

if (isNull _vehicle) exitWith {};
if !(_vehicle isKindOf "RHS_MELB_base") exitWith {};

[_vehicle] call RS_MH6V3_fnc_applyLAIRCMMode;

if !(_vehicle getVariable ["RS_MH6V3_laircmLocalEH", false]) then {
	_vehicle setVariable ["RS_MH6V3_laircmLocalEH", true, false];
	_vehicle addEventHandler ["Local", {
		params ["_vehicle", "_local"];

		if (_local) then {
			[_vehicle] call RS_MH6V3_fnc_applyLAIRCMMode;
		};
	}];
};

if (!isServer) exitWith {};

if (_vehicle getVariable ["RS_MH6V3_laircmIncomingMissileEH", false]) exitWith {};

_vehicle setVariable ["RS_MH6V3_laircmIncomingMissileEH", true, false];
_vehicle addEventHandler ["IncomingMissile", {
	_this call RS_MH6V3_fnc_handleIncomingMissile;
}];
