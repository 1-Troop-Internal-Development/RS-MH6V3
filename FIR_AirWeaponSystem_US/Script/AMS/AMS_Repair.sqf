/*Loadout Repair by Firewill*/
if (not Local player) Exitwith {};
// _plane = vehicle Player;

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

systemchat "Repairing..";

sleep 5;

_plane setdamage 0;

systemchat "Repair is Completed!";