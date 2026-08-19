//RFD with Channel display//

private ["_plane","_frequency","_freq","_channel","_chan","_chan_array","_freq_array","_freq_result","_chan_result","_result"];

_plane = vehicle player;
_pilot = driver _plane;
_planetype = typeof _plane;
if (!local _plane) exitwith{};
if (_planetype iskindof "Plane") then
{

_get_font= getText (configFile >> "CfgVehicles" >> _planetype >> "AWS_RFD_FONT_TYPE");
_font_data = [["CfgAWS_RFD_Font",_get_font],configfile] call bis_fnc_loadclass;
_prefix = gettext (_font_data >> "prefix");
_num = "";
_subfix = ".paa";

_result = "";


	private ["_ded_1","_ded_2","_ded_3","_index","_index2","_index3","_index4","_index5","_num10","_num1","_nums","_chan_1","_chan_2"];
	_index = -1;
	{
		if (_x == "ded_freq_1") exitwith {_index = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
	_index2 = -1;
	{
		if (_x == "ded_freq_2") exitwith {_index2 = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
	_index3 = -1;
	{
		if (_x == "ded_freq_3") exitwith {_index3 = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");
	_index4 = -1;
	{
		if (_x == "ded_chan_1") exitwith {_index4 = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
	_index5 = -1;
	{
		if (_x == "ded_chan_2") exitwith {_index5 = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
		_plane setObjectTextureGlobal [_index, ""];	
		_plane setObjectTextureGlobal [_index2, ""];	
		_plane setObjectTextureGlobal [_index3, ""];			
		_plane setObjectTextureGlobal [_index4, ""];			
		_plane setObjectTextureGlobal [_index5, ""];			
	_frequency = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency;
	_freq = str _frequency;
	_freq_array = toArray(_freq);	
	_freq_result = [];	
	
	_channel = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrChannel;	
	_channel = _channel + 1;
	_chan = str _channel;	
	
	for "_i" from 0 to (count _freq_array) do
	{
		_freq_result = _freq_result + [toString([_freq_array select _i])];	
	};	
	

	
	if (count _freq_array == 6) then
	{
		_ded_1 = _freq_result select 1;
		_ded_2 = _freq_result select 2;
		_ded_3 = _freq_result select 4;
		_result = _prefix + _ded_1 + _subfix;
		_plane setObjectTextureGlobal [_index, _result];
		_result = _prefix + _ded_2 + _subfix;
		_plane setObjectTextureGlobal [_index2, _result];
		_result = _prefix + _ded_3 + _subfix;
		_plane setObjectTextureGlobal [_index3, _result];		
	}
	else
	{
		_ded_1 = _freq_result select 1;
		_ded_2 = _freq_result select 2;
		_result = _prefix + _ded_1 + _subfix;
		_plane setObjectTextureGlobal [_index, _result];
		_result = _prefix + _ded_2 + _subfix;
		_plane setObjectTextureGlobal [_index2, _result];
	};
	
	_chan_1 = "0";
	_chan_2 = _chan;
	_result = _prefix + _chan_1 + _subfix;
	_plane setObjectTextureGlobal [_index4, _result];
	_result = _prefix + _chan_2 + _subfix;
	_plane setObjectTextureGlobal [_index5, _result];	
};
