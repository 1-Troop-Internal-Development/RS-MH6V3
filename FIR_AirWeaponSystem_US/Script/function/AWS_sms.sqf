
private ["_texture","_loadout","_prefix","_num","_subfix","_result"];

_plane = _this select 0;
_pilot = driver _plane;
_planetype = typeof _plane;
if (!local _plane) exitwith{};

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "SMSData";
private _smsEnabled = getNumber (_configPath >> "SMSEnabled"); if (_smsEnabled == 0) exitWith {};
private _prefix = getText (_configPath >> "Prefix"); 
private _prefix_Number = getText (_configPath >> "Prefix_Number"); 
private _sms_list = getArray (_configPath >> "SMSList");
private _csms_list = getArray (_configPath >> "CSMSList");
private _gunlist = getArray (_configPath >> "GunList");
private _code = getText (_configPath >> "SMSCode"); 
private _weapon = getText (_configPath >> "WeaponCheck"); 

_num = "";
_subfix = ".paa";

_result = "";

_pylonlist = GetPylonMagazines _plane;
_list_count = (count _pylonlist) - 1;



for "_i" from 0 to _list_count do
{
	private _pylonmag = _pylonlist select _i;
	private _sms_get = _sms_list select _i;
	private _csms_get = _csms_list select _i;	
	
	if (_pylonmag != "") then
	{
		_csms_1_code = getText (configFile >> "CfgMagazines" >> _pylonmag >> _code);
		_csms_1_count = getNumber (configFile >> "CfgMagazines" >> _pylonmag >> "count");

		private ["_index","_index_num1"];
		_index = -1;
		{
			if (_x == _sms_get) exitwith {_index = _foreachindex;};
		} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
		_index_num1 = -1;
		{
			if (_x == _csms_get) exitwith {_index_num1 = _foreachindex;};
		} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
		_plane setObjectTextureGlobal [_index, _csms_1_code];
		_num = str _csms_1_count;
		_result = _prefix_Number + _num + _subfix;
		_plane setObjectTextureGlobal [_index_num1, _result];	
	}
	else
	{
		private ["_index","_index_num1"];
		_index = -1;
		{
			if (_x == _sms_get) exitwith {_index = _foreachindex;};
		} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
		_index_num1 = -1;
		{
			if (_x == _csms_get) exitwith {_index_num1 = _foreachindex;};
		} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");		
		_plane setObjectTextureGlobal [_index, ""];		
		_plane setObjectTextureGlobal [_index_num1, ""];				
	};
};
