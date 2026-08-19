
private _plane = _this select 0;
private _pilot = driver _plane;
private _planetype = typeof _plane;
if (!local _plane) exitwith{};

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "SMSData";
private _SMSEnabled = getNumber (_configPath >> "SMSEnabled"); if (_SMSEnabled == 0) exitWith {};
private _DisplayGun = getText (_configPath >> "DisplayGun");
private _Prefix_Number = getText (_configPath >> "Prefix_Number");
private _SMS_Code = getText (_configPath >> "SMS_Code");
private _Gun_Array = getArray (_configPath >> "Gun_Array");
private _Gun_Count = getNumber (_configPath >> "Gun_Count");

_Gun_Count = _Gun_Count - 1;

private _prefix = _Prefix_Number;
private _num = "";
private _subfix = ".paa";

private _result = "";

private _ammo_value = _plane ammo _DisplayGun;

private _gun = [];

private _num1000 = floor(_ammo_value / 1000);
private _num100 = floor((_ammo_value % 1000) / 100);
private _num10 = floor(((_ammo_value % 1000) % 100) / 10);
private _num1 = floor(((_ammo_value % 1000) % 100) % 10);

_num1000 = str _num1000;
_num100 = str _num100;
_num10 = str _num10;
_num1 = str _num1;

switch (_Gun_Count) do
{
	case 0:
	{
		_gun = [_num1];
	};
	case 1:
	{
		_gun = [_num1,_num10];
	};
	case 2:
	{
		_gun = [_num1,_num10,_num100];
	};	
	case 3:
	{
		_gun = [_num1,_num10,_num100,_num1000];
	};	
};

for "_i" from 0 to _Gun_Count  do
{
	_gun_display = _Gun_Array select _i;
	_gun_num = _gun select _i;
	private ["_index"];
	_index = -1;
	{
		if (_x == _gun_display) exitwith {_index = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
	_result = _prefix + _gun_num + _subfix;
	_plane setObjectTextureGlobal [_index, _result];
};
