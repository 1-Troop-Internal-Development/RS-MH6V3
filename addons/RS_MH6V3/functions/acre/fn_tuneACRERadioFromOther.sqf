params [
	["_sourceList", controlNull],
	["_sourceIndex", -1]
];

if (!hasInterface) exitWith {};

private _display = uiNamespace getVariable ["RS_MH6V3_acreProgrammerDisplay", displayNull];
if (isNull _display) exitWith {};

if (isNull _sourceList) then {
	private _sourceIdc = uiNamespace getVariable ["RS_MH6V3_acreOtherRadioSource", 86311];
	_sourceList = _display displayCtrl _sourceIdc;
	_sourceIndex = lbCurSel _sourceList;

	if (_sourceIndex < 0) then {
		{
			private _list = _display displayCtrl _x;
			private _index = lbCurSel _list;
			if (_index >= 0) exitWith {
				_sourceList = _list;
				_sourceIndex = _index;
			};
		} forEach [86311, 86313];
	};
};

if (isNull _sourceList || {_sourceIndex < 0}) exitWith {
	systemChat "RS MH-6V3: select an other seat radio to copy.";
};

private _channel = _sourceList lbValue _sourceIndex;
if (_channel < 1) exitWith {
	systemChat "RS MH-6V3: selected other seat radio does not expose a channel.";
};

private _channelEdit = _display displayCtrl 86322;
_channelEdit ctrlSetText str _channel;
[] call RS_MH6V3_fnc_tuneACRERadio;
