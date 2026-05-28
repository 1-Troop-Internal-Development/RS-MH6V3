params [
	["_vehicle", vehicle player]
];

if (!hasInterface) exitWith {};

private _display = uiNamespace getVariable ["RS_MH6V3_acreRadioStatusDisplay", displayNull];
if (isNull _display) exitWith {};

if !(missionNamespace getVariable ["RS_MH6V3_acreStatusOverlayEnabled", true]) exitWith {
	"RS_MH6V3_ACRERadioStatusLayer" cutText ["", "PLAIN"];
	uiNamespace setVariable ["RS_MH6V3_acreRadioStatusRows", createHashMap];
	uiNamespace setVariable ["RS_MH6V3_acreRadioStatusLayout", ""];
	missionNamespace setVariable ["RS_MH6V3_acreRadioStatusVisible", false];
};

private _rowCache = uiNamespace getVariable ["RS_MH6V3_acreRadioStatusRows", createHashMap];
private _infoCache = uiNamespace getVariable ["RS_MH6V3_acreRadioStatusInfoCache", createHashMap];
private _setRow = {
	params [
		"_idc",
		"_text",
		"_color"
	];

	private _ctrl = _display displayCtrl _idc;
	if (isNull _ctrl) exitWith {};

	private _cacheKey = str _idc;
	private _rowState = format ["%1|%2", _text, _color];
	if ((_rowCache getOrDefault [_cacheKey, ""]) isEqualTo _rowState) exitWith {};

	_ctrl ctrlSetStructuredText parseText format [
		"<t font='RobotoCondensed' align='center' size='1.08' color='%1'>%2</t>",
		_color,
		_text
	];
	_rowCache set [_cacheKey, _rowState];
};

private _setCtrlPos = {
	params [
		"_idc",
		"_x",
		"_y",
		"_w",
		"_h"
	];

	private _ctrl = _display displayCtrl _idc;
	if (isNull _ctrl) exitWith {};

	_ctrl ctrlSetPosition [
		safeZoneX + (_x * safeZoneW),
		safeZoneY + (_y * safeZoneH),
		_w * safeZoneW,
		_h * safeZoneH
	];
	_ctrl ctrlCommit 0;
};

private _clearRows = {
	{
		[_x, "", "#ffffff"] call _setRow;
	} forEach [86203, 86211, 86212, 86213, 86214, 86215, 86216, 86231, 86232, 86233];
};

if (
	isNull _vehicle ||
	{!(_vehicle isKindOf "RHS_MELB_AH6M")} ||
	{!(player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]])}
) exitWith {
	call _clearRows;
};

if (
	isNil "acre_api_fnc_isInitialized" ||
	{isNil "acre_api_fnc_getCurrentRadio"} ||
	{isNil "acre_api_fnc_getCurrentRadioList"}
) exitWith {
	call _clearRows;
};

private _acreReady = [] call acre_api_fnc_isInitialized;
if (isNil "_acreReady" || {!(_acreReady isEqualTo true)}) exitWith {
	call _clearRows;
};

private _currentRadio = [] call acre_api_fnc_getCurrentRadio;
if (isNil "_currentRadio" || {!(_currentRadio isEqualType "")}) then {
	_currentRadio = "";
};

private _formatRadio = {
	params [
		"_radioId",
		"_active",
		["_isRack", false],
		["_rackInUse", true]
	];

	private _info = _infoCache getOrDefault [_radioId, objNull];
	if !(_info isEqualType createHashMap) then {
		_info = [_radioId, _active] call RS_MH6V3_fnc_getACRERadioInfo;
	};
	private _channel = _info get "channel";
	private _channelName = _info get "channelName";
	private _suffix = "";
	private _color = "#8cff9b";
	private _selectedMarker = ["", "* "] select (_radioId isEqualTo (missionNamespace getVariable ["RS_MH6V3_acreSelectedRadioId", ""]));

	if !(_info get "monitoring") then {
		_color = ["#8a8a8a", "#ff4f4f"] select _isRack;
	};

	if (_isRack && {!_rackInUse}) then {
		_color = "#ff4f4f";
	};

	if ((_info get "incoming") && {!_isRack || {_rackInUse}}) then {
		_color = "#ffffff";
		_suffix = " (INC)";
	};

	if ((_info get "ptt") && {!_isRack || {_rackInUse}}) then {
		_color = "#ffffff";
		_suffix = " (+PTT)";
	};

	private _channelText = if (_channel isEqualTo "") then {
		"CH -"
	} else {
		_channel
	};
	if (_channelName isNotEqualTo "") then {
		_channelText = format ["%1 %2", _channelText, _channelName];
	};

	[format ["%1%2  %3%4", _selectedMarker, _info get "name", _channelText, _suffix], _color]
};

private _lists = uiNamespace getVariable ["RS_MH6V3_acreRadioStatusListCache", createHashMap];
if !(_lists isEqualType createHashMap) then {
	_lists = [_vehicle] call RS_MH6V3_fnc_getACRERadioLists;
};
private _inventoryRadios = _lists get "inventory";
private _rackRadios = _lists get "racks";
if (isNil "_inventoryRadios" || {!(_inventoryRadios isEqualType [])}) then {
	_inventoryRadios = [];
};
if (isNil "_rackRadios" || {!(_rackRadios isEqualType [])}) then {
	_rackRadios = [];
};
private _accessibleRackRadios = if (isNil "ACRE_ACCESSIBLE_RACK_RADIOS") then {[]} else {+ACRE_ACCESSIBLE_RACK_RADIOS};
private _hearableRackRadios = if (isNil "ACRE_HEARABLE_RACK_RADIOS") then {[]} else {+ACRE_HEARABLE_RACK_RADIOS};
private _inUseRackRadios = _accessibleRackRadios + _hearableRackRadios;
private _inventoryCount = ((count _inventoryRadios) min 7) max 1;
private _rackCount = (count _rackRadios) min 3;
private _panelX = missionNamespace getVariable ["RS_MH6V3_acreStatusOverlayX", 0.034];
private _panelY = missionNamespace getVariable ["RS_MH6V3_acreStatusOverlayY", 0.535];
private _panelW = 0.178;
_panelX = 0 max (_panelX min (1 - _panelW));
_panelY = 0 max (_panelY min 0.94);
private _padX = 0.005;
private _titleH = 0.026;
private _headerH = 0.020;
private _rowH = 0.022;
private _rowGap = 0.002;
private _y = _panelY + 0.006;
private _layoutKey = format ["%1:%2:%3:%4", _inventoryCount, _rackCount, _panelX, _panelY];
private _layoutChanged = _layoutKey isNotEqualTo (uiNamespace getVariable ["RS_MH6V3_acreRadioStatusLayout", ""]);

if (_layoutChanged) then {
	[86200, _panelX, _panelY, _panelW, 0.07] call _setCtrlPos;
	[86201, _panelX + _padX, _y, _panelW - (_padX * 2), _titleH] call _setCtrlPos;
};
_y = _y + _titleH + 0.004;
if (_layoutChanged) then {
	[86202, _panelX + _padX, _y, _panelW - (_padX * 2), _headerH] call _setCtrlPos;
};
_y = _y + _headerH + 0.002;

{
	private _idc = _x;
	private _idx = _forEachIndex;

	if (_layoutChanged) then {
		[_idc, _panelX + _padX, _y + ((_rowH + _rowGap) * _idx), _panelW - (_padX * 2), _rowH] call _setCtrlPos;
	};
	if (_idx < count _inventoryRadios) then {
		private _radio = _inventoryRadios select _idx;
		([_idc] + ([_radio, _radio isEqualTo _currentRadio] call _formatRadio)) call _setRow;
	} else {
		[_idc, "", "#ffffff"] call _setRow;
	};
} forEach [86203, 86211, 86212, 86213, 86214, 86215, 86216];

_y = _y + ((_rowH + _rowGap) * _inventoryCount) + 0.004;
if (_layoutChanged) then {
	[86230, _panelX + _padX, _y, _panelW - (_padX * 2), _headerH] call _setCtrlPos;
};
_y = _y + _headerH + 0.002;

{
	private _idc = _x;
	private _idx = _forEachIndex;

	if (_layoutChanged) then {
		[_idc, _panelX + _padX, _y + ((_rowH + _rowGap) * _idx), _panelW - (_padX * 2), _rowH] call _setCtrlPos;
	};
	if (_idx < count _rackRadios) then {
		private _radio = _rackRadios select _idx;
		([_idc] + ([_radio, _radio isEqualTo _currentRadio, true, _radio in _inUseRackRadios] call _formatRadio)) call _setRow;
	} else {
		[_idc, "", "#ffffff"] call _setRow;
	};
} forEach [86231, 86232, 86233];

private _panelH = (_y + ((_rowH + _rowGap) * (_rackCount max 1)) + 0.006) - _panelY;
if (_layoutChanged) then {
	[86200, _panelX, _panelY, _panelW, _panelH] call _setCtrlPos;
	uiNamespace setVariable ["RS_MH6V3_acreRadioStatusLayout", _layoutKey];
};

if ((count _inventoryRadios) == 0 && {(count _rackRadios) == 0}) then {
	[86203, "No available ACRE radios", "#8a8a8a"] call _setRow;
};

uiNamespace setVariable ["RS_MH6V3_acreRadioStatusRows", _rowCache];
