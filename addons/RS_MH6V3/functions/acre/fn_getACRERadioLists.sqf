params [
	["_vehicle", vehicle player]
];

private _inventoryRadios = [];
private _rackRadios = [];

private _acreReady = false;
if (!isNil "acre_api_fnc_isInitialized") then {
	_acreReady = [] call acre_api_fnc_isInitialized;
	if (isNil "_acreReady" || {!(_acreReady isEqualType true)}) then {
		_acreReady = false;
	};
};

if (!_acreReady || {isNil "acre_api_fnc_getCurrentRadioList"}) exitWith {
	createHashMapFromArray [["inventory", []], ["racks", []], ["all", []]]
};

_inventoryRadios = [] call acre_api_fnc_getCurrentRadioList;
if (isNil "_inventoryRadios" || {!(_inventoryRadios isEqualType [])}) then {
	_inventoryRadios = [];
};

if (
	!isNull _vehicle &&
	{!isNil "acre_api_fnc_areVehicleRacksInitialized"} &&
	{!isNil "acre_api_fnc_getVehicleRacks"} &&
	{!isNil "acre_api_fnc_getMountedRackRadio"}
) then {
	private _racksInitialized = [_vehicle] call acre_api_fnc_areVehicleRacksInitialized;
	if (!isNil "_racksInitialized" && {_racksInitialized isEqualTo true}) then {
		private _racks = [_vehicle] call acre_api_fnc_getVehicleRacks;
		if (!isNil "_racks" && {_racks isEqualType []}) then {
			{
				private _rackId = if (_x isEqualType []) then {
					_x param [0, ""]
				} else {
					_x
				};

				if (_rackId isEqualType "" && {_rackId isNotEqualTo ""}) then {
					private _mountedRadio = [_rackId] call acre_api_fnc_getMountedRackRadio;
					if (!isNil "_mountedRadio" && {_mountedRadio isEqualType ""} && {_mountedRadio isNotEqualTo ""}) then {
						_rackRadios pushBackUnique _mountedRadio;
					};
				};
			} forEach _racks;
		};
	};
};

_inventoryRadios = _inventoryRadios - _rackRadios;

createHashMapFromArray [
	["inventory", _inventoryRadios],
	["racks", _rackRadios],
	["all", _inventoryRadios + _rackRadios]
]
