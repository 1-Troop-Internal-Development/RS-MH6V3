/*MFD Targeting System by Firewill*/

private ["_plane","_tgtpos","_targetset","_select_mem","_data"];

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

_planetype = typeof _plane;

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat "You Must get in the Aircraft!";};

systemChat "SYSTEM : Data erased from FCS";
	
_marker_d = _plane getvariable "ITGT_C_MARKER";
deleteMarkerLocal _marker_d;
	
_plane setvariable ["ITGT_NEW","no",true];		

_plane setvariable ["ITGT_C_DATA",[],true];	
_plane setVariable ["ITGT_C_MARKER","none"];	
_plane setVariable ["ITGT_TGT_SET","no",true];	
