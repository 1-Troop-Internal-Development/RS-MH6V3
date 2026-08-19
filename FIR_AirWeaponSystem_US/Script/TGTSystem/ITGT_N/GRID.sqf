/*I-TGT 2.0 Designate  location function by Firewill
only adding target location.
*/

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

_planetype = typeof _plane;	

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat localize "str_FIR_ITGT_AIRCRAFT_WARN";};

if (ctrlShown ((findDisplay 5581) displayCtrl 1202)) exitWith {systemChat localize "str_FIR_ITGT_NOT_MAP"};


targetset = false;
systemChat localize "str_FIR_ITGT_GRID_MSG";
onMapSingleClick "tgtpos = _pos;targetset = true"; 

waitUntil {targetset}; 

systemChat format [localize "str_FIR_ITGT_GRID_INFO",tgtpos];
	
onMapSingleClick "";
targetset = false;

