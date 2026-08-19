/*AMS Lite dialog By Firewill*/
/*FOR NEW PYLON SYSTEM*/

if (not(isNil "AWS_AMS_Disable")) exitWith
{
	systemchat "AMS deactivated via AWS_AMS_Disable command.";
};

private _plane = "";
private _planetype = "";

private _UAV = getConnectedUAV player;

//if not UAV
if (_UAV isEqualTo objNull) then
{
	_plane = vehicle player;
	_plane_pilot = driver _plane;
}
else
{
// if UAV and MQ-81U only

		_plane = _UAV;	
		_plane_pilot = player;		
};

private _data = lbData [1500, (lbCurSel 1500)];
private _wep_list = _plane getCompatiblePylonMagazines _data;
private _wep_cnt = count _wep_list;
private _mag_ary = [];

lbClear 1501;

for "_i" from 0 to _wep_cnt-1 do
{
	if (isNil "AWS_AMS_Blacklist") then 
	{
		private _wep = _wep_list select _i;
		private _wep_name = getText (configFile >> "CfgMagazines" >> _wep >> "displayName");
		private _wep_ary = [_wep_name,_wep];
		_mag_ary pushback _wep_ary;
	}
	else
	{
		private _blacklist = AWS_AMS_Blacklist;
		private _wep = _wep_list select _i;
		
		if (_wep in _blacklist) then
		{
			
		}
		else
		{
			private _wep_name = getText (configFile >> "CfgMagazines" >> _wep >> "displayName");
			private _wep_ary = [_wep_name,_wep];
			_mag_ary pushback _wep_ary;						
		};
	};	
}; 
[1501,_mag_ary] call FIR_fnc_lbadd;
_mag_ary = [];		
