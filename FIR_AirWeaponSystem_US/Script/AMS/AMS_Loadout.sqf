/*loadout system by Firewill*/
if (not Local player) Exitwith {};
// private _plane = vehicle Player;

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

_loadout_status = _plane getVariable "Loadout_Status";

if (_loadout_status == "yes") ExitWith {systemchat "Loadout Dialog is working."};

_plane setvariable ["Loadout_Status","yes",true];

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "AMSData";
private _AMSEnabled = getNumber (_configPath >> "AMSEnabled"); if (_AMSEnabled == 0) exitWith {};
private _DialogClass = getText (_configPath >> "DialogClass");
private _AircraftBase = getText (_configPath >> "AircraftBase");
private _CustomPreset = getText (_configPath >> "CustomPreset");
private _CustomPresetAttachment = getText (_configPath >> "CustomPresetAttachment");
private _presetNumber = getNumber (_configPath >> "presetNumber");
private _EditNumber = getNumber (_configPath >> "EditNumber");
private _ListboxArray = getArray (_configPath >> "ListboxArray");
private _loadout_scriptenabled = getNumber (_configPath >> "loadout_scriptenabled");
private _loadout_script = getText (_configPath >> "loadout_script");
private _loadout_pre = getText (_configPath >> "loadout_pre");
private _loadout_apply = getText (_configPath >> "loadout_apply");
private _loadout_post = getText (_configPath >> "loadout_post");
private _CustomFuelEnabled = getNumber (_configPath >> "CustomFuelEnabled");
private _CustomFuelScript = getText (_configPath >> "CustomFuelScript");
private _apply = "";

_preset = lbCurSel _presetNumber;

private _hardpoint_ary = [];
private _listbox_count = count _ListboxArray;

for "_g" from 1 to _listbox_count - 1 do
{
	private _get_hp = _ListboxArray select _g;
	private _hp = lbData [_get_hp,(lbCurSel _get_hp)];
	_hardpoint_ary pushBack _hp;
};

_pre = execVM _loadout_pre;
waitUntil {scriptDone _pre};	
_apply = _hardpoint_ary execVM _loadout_apply;
waitUntil {scriptDone _apply};	
_post = execVM _loadout_post;
waitUntil {scriptDone _post};

_plane setvariable ["Loadout_Status","no",true];

//reset I-TGT list
private _pylonlist = GetPylonMagazines _plane;
_gps_array = [];
private _pylon_count = (count _pylonlist)-1;

for "_i" from 0 to _pylon_count do
{
	_mag = _pylonlist select _i;
	_ammoname = getText (Configfile >> "CfgMagazines" >> _mag >> "ammo" );
	_gps_bomb = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_Bomb_Guide");
	_gps_mssl = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_MSSL_Guide");	

	//systemChat format ["%1 / %2 / %3 / %4",_mag,_ammoname,_gps_bomb,_gps_mssl];		
	
	If (_gps_bomb isEqualTo 1 or _gps_mssl isEqualTo 1) then
	{
		_ammo_c = _plane ammoOnPylon (_i+1);
		_code = "hp" + str (_i+1);
		// array [pylon code,pylon index, current ammo count,wep_name,tgtid,islock,mode]
		_ary = [_code,(_i+1),_ammo_c,_mag,"",false,"gps"];

		_gps_array pushBack _ary;		
	};
};

_plane setVariable ["AWS_ITGT_GPS_ARRAY",_gps_array,true];
	