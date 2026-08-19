
_plane = _this select 0;
_pilot = driver _plane;
_planetype = typeof _plane;

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

if (!local _plane) exitwith{};

private _prefix = _Prefix_Number;
private _num = "";
private _subfix = ".paa";

private _result = "";

private _pylonlist = GetPylonMagazines _plane;

private _pylonlist_c = count _pylonlist;

for "_i" from 0 to _pylonlist_c-1  do
{
	_pylon = _pylonlist select _i;
	_p_a = _Pylon_Ary select  _i;	
	_wep_code = getText (configFile >> "CfgMagazines" >> _pylon >> _SMS_Code);
	_wep_count = getNumber (configFile >> "CfgMagazines" >> _pylon >> "count");

	private _index = -1;
	{
		if (_x == _p_a) exitwith {_index = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
	_plane setObjectTextureGlobal [_index, _wep_code];	
	
	if (_WeaponOnly == 0) then
	{
		private _num10 = floor(_wep_count / 10);
		private _num1 = floor(_wep_count % 10);

		_num10 = str _num10;
		_num1 = str _num1;	
			
		if (_Pylon_Type == 0) then
		{
			private _pa_1 = _Pylon_Ary_1 select _i;
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
			private _pa_1 = _Pylon_Ary_1 select _i;
			private _pa_10 = _Pylon_Ary_10 select _i;		
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
	};

};
