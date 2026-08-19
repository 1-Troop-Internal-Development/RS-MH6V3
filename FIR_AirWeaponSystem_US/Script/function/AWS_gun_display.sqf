
private ["_texture","_loadout","_prefix","_num","_subfix","_result"];

_array = _this select 0;
_weapon = _array select 1;
_ammoname = _array select 4;
_magname = _array select 5;
_plane = _array select 0;

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "SMSData";
private _smsEnabled = getNumber (_configPath >> "SMSEnabled"); if (_smsEnabled == 0) exitWith {};
private _prefix = getText (_configPath >> "Prefix"); 
private _prefix_Number = getText (_configPath >> "Prefix_Number"); 
private _sms_list = getArray (_configPath >> "SMSList");
private _csms_list = getArray (_configPath >> "CSMSList");
private _gunlist = getArray (_configPath >> "GunList");
private _code = getText (_configPath >> "SMSCode"); 
private _checkweapon = getText (_configPath >> "WeaponCheck"); 

_pilot = driver _plane;
_planetype = typeof _plane;
if (!local _plane) exitwith{};
if (_weapon != _checkweapon) exitwith{};

_num = "";
_subfix = ".paa";

_result = "";

_ammo_value = _plane ammo _weapon;

private ["_num1000","_num100","_num10","_num1"];

_num100 = floor(_ammo_value / 100);
_num10 = floor((_ammo_value % 100) / 10);
_num1 = floor((_ammo_value % 100) % 10);

_num100 = str _num100;
_num10 = str _num10;
_num1 = str _num1;

private ["_index"];

_index = -1;
{
	if (_x == "gun_100") exitwith {_index = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
_result = _prefix_Number + _num100 + _subfix;
_plane setObjectTextureGlobal [_index, _result];

_index = -1;
{
	if (_x == "gun_10") exitwith {_index = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
_result = _prefix_Number + _num10 + _subfix;
_plane setObjectTextureGlobal [_index, _result];

_index = -1;
{
	if (_x == "gun_1") exitwith {_index = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
_result = _prefix_Number + _num1 + _subfix;
_plane setObjectTextureGlobal [_index, _result];

