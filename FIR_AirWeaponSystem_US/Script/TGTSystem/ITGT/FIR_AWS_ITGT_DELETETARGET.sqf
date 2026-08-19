/*MFD Targeting System by Firewill*/

private ["_plane","_tgtpos","_targetset","_select_mem","_data","_backup_data","_backup_data_c"];

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

_slotcheck = _plane getvariable ["AWS_MEMORYSLOT",1];

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat "You Must get in the Aircraft!";};

if (_plane getVariable "ITGT_TGT_SET" == "yes") exitWith{systemChat "ERROR : CLEAR THE DESIGNATED DATA FIRST."};
systemChat "SYSTEM : Delete Memory Data";
_backup_data_c = _plane getVariable "ITGT_C_DATA";

	Switch (_slotcheck) do
	{
		case 1:
		{
			_backup_data = _plane getVariable "ITGT_DATA_1";
			systemChat "SYSTEM : SLOT 1 ERASED";	
			_plane setvariable ["ITGT_DATA_1",[],true];			
			
			_marker_v = _plane getvariable "ITGT_MARKER_1";
			deleteMarkerLocal _marker_v;
		};
		case 2:
		{
			_backup_data = _plane getVariable "ITGT_DATA_2";
			systemChat "SYSTEM : SLOT 2 ERASED";	
			_plane setvariable ["ITGT_DATA_2",[],true];			
			
			_marker_v = _plane getvariable "ITGT_MARKER_2";
			deleteMarkerLocal _marker_v;
		};
		case 3:
		{
			_backup_data = _plane getVariable "ITGT_DATA_3";
			systemChat "SYSTEM : SLOT 3 ERASED";	
			_plane setvariable ["ITGT_DATA_3",[],true];			
			
			_marker_v = _plane getvariable "ITGT_MARKER_3";
			deleteMarkerLocal _marker_v;
		};
		case 4:
		{
			_backup_data = _plane getVariable "ITGT_DATA_4";
			systemChat "SYSTEM : SLOT 4 ERASED";	
			_plane setvariable ["ITGT_DATA_4",[],true];			
			
			_marker_v = _plane getvariable "ITGT_MARKER_4";
			deleteMarkerLocal _marker_v;
		};
		case 5:
		{
			_backup_data = _plane getVariable "ITGT_DATA_5";
			systemChat "SYSTEM : SLOT 5 ERASED";	
			_plane setvariable ["ITGT_DATA_5",[],true];			
			
			_marker_v = _plane getvariable "ITGT_MARKER_5";
			deleteMarkerLocal _marker_v;
		};
	};
	

