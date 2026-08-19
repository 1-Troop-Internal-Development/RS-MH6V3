
private ["_texture","_loadout"];

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
if (_weapon == _checkweapon) exitwith{};

_num = "";
_subfix = ".paa";

_result = "";

_pylonlist = GetPylonMagazines _plane;
_list_count = (count _pylonlist) - 1;

for "_i" from 0 to _list_count do
{
	private _csms_get = _csms_list select _i;	
	
	private ["_index_num1"];
	_index_num1 = -1;
	{
		if (_x == _csms_get) exitwith {_index_num1 = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
	private _csms_ammo = _plane AmmoOnPylon _i+1;
	if (_csms_ammo >= 0) then
	{
		_num = str _csms_ammo;
		_result = _prefix_Number + _num + _subfix;
		_plane setObjectTextureGlobal [_index_num1, _result];	
	}
	else
	{
		_plane setObjectTextureGlobal [_index_num1, ""];		
	};

};
