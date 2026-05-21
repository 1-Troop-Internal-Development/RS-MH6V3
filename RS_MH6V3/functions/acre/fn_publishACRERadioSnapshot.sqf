params [
	["_requester", objNull],
	["_vehicle", vehicle player]
];

if (!hasInterface) exitWith {};
if (isNull _requester || {!isPlayer _requester}) exitWith {};
if (isNull _vehicle || {!alive _vehicle}) exitWith {};
if !(player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]]) exitWith {};

private _inventoryRows = [];
private _rackRows = [];

private _acreReady = false;
if (!isNil "acre_api_fnc_isInitialized") then {
	_acreReady = [] call acre_api_fnc_isInitialized;
	if (isNil "_acreReady" || {!(_acreReady isEqualType true)}) then {
		_acreReady = false;
	};
};

if (_acreReady) then {
	private _lists = [_vehicle] call RS_MH6V3_fnc_getACRERadioLists;
	private _pushRows = {
		params ["_rows", "_radios"];

		{
			private _info = [_x, false] call RS_MH6V3_fnc_getACRERadioInfo;
			private _on = ["OFF", "ON"] select (_info get "on");
			_rows pushBack createHashMapFromArray [
				["id", _x],
				["channelNumber", _info get "channelNumber"],
				["text", format ["%1 | %2 | %3", _info get "name", _info get "channel", _on]]
			];
		} forEach _radios;
	};

	[_inventoryRows, _lists get "inventory"] call _pushRows;
	[_rackRows, _lists get "racks"] call _pushRows;
};

if (_inventoryRows isEqualTo []) then {
	_inventoryRows = ["No inventory radios detected."];
};

[player, createHashMapFromArray [["inventory", _inventoryRows], ["racks", _rackRows]]] remoteExecCall ["RS_MH6V3_fnc_receiveACRERadioSnapshot", owner _requester];
