params [["_vehicle", objNull]];

private _vehicleClass = if (isNull _vehicle) then {
	"RHS_MELB_AH6M"
} else {
	typeOf _vehicle
};

private _liveries = [];
private _addLivery = {
	params ["_id", "_name", "_texture"];

	if (_texture == "") exitWith {};
	if ((_liveries findIf {(_x # 2) == _texture}) >= 0) exitWith {};

	_liveries pushBack [_id, _name, _texture];
};

private _textureSources = configFile >> "CfgVehicles" >> _vehicleClass >> "TextureSources";
for "_i" from 0 to ((count _textureSources) - 1) do {
	private _source = _textureSources select _i;
	if (isClass _source) then {
		private _textures = getArray (_source >> "textures");
		if ((count _textures) > 0) then {
			private _name = getText (_source >> "displayName");
			if (_name == "") then {
				_name = configName _source;
			};

			[configName _source, _name, _textures # 0] call _addLivery;
		};
	};
};

private _defaultTextures = getArray (configFile >> "CfgVehicles" >> _vehicleClass >> "hiddenSelectionsTextures");
if ((count _defaultTextures) > 0) then {
	["default", "Default", _defaultTextures # 0] call _addLivery;
};

_liveries
