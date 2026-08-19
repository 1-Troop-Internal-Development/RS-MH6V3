/*MFD Targeting System by Firewill*/

private ["_plane","_tgtpos","_targetset","_select_mem","_data","_des_marker","_lsr_marker","_lsr_tgt","_lsr"];

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


systemChat "SYSTEM : Designate the target coordinates to FCS";
_data = "";
_nan = round(random 10000);

if (_plane getVariable "ITGT_TGT_SET" == "yes") exitWith{systemChat "ERROR : CLEAR THE DESIGNATED DATA FIRST."};

	Switch (_slotcheck) do
	{
		case 1:
		{
			systemChat "SYSTEM : SLOT 1 DESIGNATED";	
			_data = _plane getvariable "ITGT_DATA_1";
			_plane setvariable ["ITGT_C_DATA",_data,true];

		};
		case 2:
		{
			systemChat "SYSTEM : SLOT 2 DESIGNATED";	
			_data = _plane getvariable "ITGT_DATA_2";
			_plane setvariable ["ITGT_C_DATA",_data,true];

		};
		case 3:
		{
			systemChat "SYSTEM : SLOT 3 DESIGNATED";	
			_data = _plane getvariable "ITGT_DATA_3";
			_plane setvariable ["ITGT_C_DATA",_data,true];

		};
		case 4:
		{
			systemChat "SYSTEM : SLOT 4 DESIGNATED";	
			_data = _plane getvariable "ITGT_DATA_4";
			_plane setvariable ["ITGT_C_DATA",_data,true];

		};
		case 5:
		{
			systemChat "SYSTEM : SLOT 5 DESIGNATED";	
			_data = _plane getvariable "ITGT_DATA_5";
			_plane setvariable ["ITGT_C_DATA",_data,true];

		};
	};

_mn = format["%1_des_marker",_nan];		

_des_marker = createMarkerLocal [_mn, [0,0]];
_des_marker setMarkerColorLocal "ColorBlue";
_des_marker setMarkerShapeLocal "ICON";
_des_marker setMarkerSizeLocal [0.8,0.8];
_des_marker setMarkerTypeLocal "selector_selectedMission";
_des_marker setMarkerTextLocal "";
_des_marker setMarkerAlphaLocal 1;
_des_marker setMarkerPosLocal _data;	

_plane setvariable ["ITGT_NEW","yes",true];	

_plane setVariable ["ITGT_C_MARKER",_des_marker,true];	
_plane setVariable ["ITGT_TGT_SET","yes",true];
	

