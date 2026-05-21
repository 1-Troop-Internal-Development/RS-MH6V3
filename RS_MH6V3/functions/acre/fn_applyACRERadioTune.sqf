params [
	["_requester", objNull],
	["_vehicle", objNull],
	["_radioId", ""],
	["_channel", -1]
];

if (!hasInterface) exitWith {};
if (isNull _requester || {!isPlayer _requester}) exitWith {};
if (isNull _vehicle || {!alive _vehicle} || {!(_vehicle isKindOf "RHS_MELB_AH6M")}) exitWith {};
if (_radioId isEqualTo "" || {_channel < 1}) exitWith {};
if (isNil "acre_api_fnc_setRadioChannel") exitWith {};

private _crew = [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]];
if (!(player in _crew) || {!(_requester in _crew)}) exitWith {};

private _lists = [_vehicle] call RS_MH6V3_fnc_getACRERadioLists;
if !(_radioId in (_lists get "all")) exitWith {};

private _success = [_radioId, _channel] call acre_api_fnc_setRadioChannel;
if (isNil "_success" || {!(_success isEqualTo false)}) then {
	playSound "RS_MH6V3_ACRETune";
	[_requester, _vehicle] call RS_MH6V3_fnc_publishACRERadioSnapshot;
};
