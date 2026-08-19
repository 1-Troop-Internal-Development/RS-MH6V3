/*Loadout Refuel by Firewill*/
if (not Local player) Exitwith {};
// private _plane = vehicle Player;

private _plane = "";

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

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "AMSData";
private _CustomFuelEnabled = getNumber (_configPath >> "CustomFuelEnabled");
private _CustomFuelScript = getText (_configPath >> "CustomFuelScript");

systemchat "Refueling..";

sleep 5;

if (_CustomFuelEnabled == 1) then
{
	_handle = execVM _CustomFuelScript;
}
else
{
	_plane setfuel 1;
};

systemchat "Refueling Completed.";