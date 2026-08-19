if (not Local player) Exitwith {};
// _plane = vehicle player;


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

private _weap = _this;
private _weapcount = (count _weap)-1;
private _count = 1;
private _interval = 0.5;
private _custom = false;
private _mass = 0;

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "AMSData";
private _checkboxarray = getArray (_configPath >> "CheckboxArray");
private _dialogNumber = getNumber (_configPath >> "DialogNumber");

disableSerialization;
_mydisplay = findDisplay _dialogNumber;


if (isNil "AWS_AMS_LoadingTime") then 
{
	systemchat "custom value not found. standard inverval time : 0.5s";
}
else
{
	systemchat "Weight-based Loading time enabled.";
	_custom = true;
};


for "_i" from 0 to _weapcount do
{
	if (isEngineOn _plane) exitWith {systemChat "AMS cancelled : engine is on."};
	_equip = _weap select _i;
	if (_custom) then
	{
		_mass = getNumber  (configFile >> "CfgMagazines" >> _equip >> "mass");		
		_interval = _mass * 0.1;
	};
	systemchat format ["%1 / load time : %2 s",_equip,_interval];	
	sleep _interval;	
	private _check = _checkboxarray select _count;
	private _cb_ctrl = _mydisplay displayCtrl _check;	
	private _checked = cbChecked _cb_ctrl;
	if (_checked) then
	{
			_plane setPylonLoadOut [_count, _equip, false, [0]];	
	}
	else
	{
			_plane setPylonLoadOut [_count, _equip, false, []];		
	};
	
	_count = _count + 1;
};


