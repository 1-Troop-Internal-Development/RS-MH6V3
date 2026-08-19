
private _array = _this select 0;
private _weapon = _array select 1;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _plane = _array select 0;

private _pilot = driver _plane;
private _planetype = typeof _plane;

if (!local _plane) exitwith{};

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "SMSData";
private _SMSEnabled = getNumber (_configPath >> "SMSEnabled"); if (_SMSEnabled == 0) exitWith {};
private _DisplayGun = getText (_configPath >> "DisplayGun");
private _Prefix_Number = getText (_configPath >> "Prefix_Number");
private _SMS_Code = getText (_configPath >> "SMS_Code");
private _Gun_Array = getArray (_configPath >> "Gun_Array");
private _Pylon_Count = getNumber (_configPath >> "Pylon_Count");
private _Pylon_Type = getNumber (_configPath >> "Pylon_Type");
private _Pylon_Ary = getArray (_configPath >> "Pylon_Ary");
private _Pylon_Ary_1 = getArray (_configPath >> "Pylon_Ary_1");
private _Pylon_Ary_10 = getArray (_configPath >> "Pylon_Ary_10");		
private _WeaponOnly = getNumber (_configPath >> "WeaponOnly");
if (_weapon == _DisplayGun or _weapon == "FIR_GEPOD30") exitwith{};

_Pylon_Type = _Pylon_Type - 1;

private _prefix = _Prefix_Number;
private _num = "";
private _subfix = ".paa";

private _result = "";
private _wep_c = 0;

for "_i" from 1 to _Pylon_Count  do
{
	_wep_c = _plane AmmoOnPylon _i;
	private _count = _i - 1;
	private _p_a = _Pylon_Ary select  _count;		
	if (_WeaponOnly == 0) then
	{
		private _num10 = floor(_wep_c / 10);
		private _num1 = floor(_wep_c % 10);

		_num10 = str _num10;
		_num1 = str _num1;	
		
		if (_Pylon_Type == 0) then
		{
			_pa_1 = _Pylon_Ary_1 select _count;
			private ["_index_num1","_index_num10"];
			_index_num1 = -1;
			{
				if (_x == _pa_1) exitwith {_index_num1 = _foreachindex;};
			} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
			_result = _prefix + _num1 + _subfix;
			_plane setObjectTextureGlobal [_index_num1, _result];		
			
		}
		else
		{
			_pa_1 = _Pylon_Ary_1 select _count;
			_pa_10 = _Pylon_Ary_10 select _count;		
			private ["_index_num1","_index_num10"];
			_index_num1 = -1;
			{
				if (_x == _pa_1) exitwith {_index_num1 = _foreachindex;};
			} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
			_result = _prefix + _num1 + _subfix;
			_plane setObjectTextureGlobal [_index_num1, _result];		

			_index_num10 = -1;
			{
				if (_x == _pa_10) exitwith {_index_num10 = _foreachindex;};
			} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
			_result = _prefix + _num10 + _subfix;
			_plane setObjectTextureGlobal [_index_num10, _result];				
		};	
	}
	else
	{
		if (_wep_c == 0) then
		{
			private _index = -1;
			{
				if (_x == _p_a) exitwith {_index = _foreachindex;};
			} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
			_plane setObjectTextureGlobal [_index, ""];			
		};
	};

	
};

