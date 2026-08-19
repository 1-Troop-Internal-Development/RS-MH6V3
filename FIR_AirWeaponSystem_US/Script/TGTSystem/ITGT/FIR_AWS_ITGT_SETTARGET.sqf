/*MFD Targeting System by Firewill*/

private ["_plane","_tgtpos","_targetset","_select_mem"];

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

targetset = false;

systemChat "SYSTEM : Advanced I-TARGETING System is running. Select the target location.";

onMapSingleClick "tgtpos = _pos;targetset = true"; 

waitUntil {targetset}; 

systemChat "SYSTEM : Target coordinates confirmed. converting data..";

_nan = round(random 10000);

	Switch (_slotcheck) do
	{
		case 1:
		{
			_marker_v = _plane getvariable "ITGT_MARKER_1";
			if (_marker_v == "none") then
			{
			}
			else
			{
				deleteMarkerLocal _marker_v;
			};
			_mn = format["%1_default_slot_marker",_nan];			
			_default_marker = createMarkerLocal [_mn, [0,0]];
			_default_marker setMarkerColorLocal "ColorBlue";
			_default_marker setMarkerShapeLocal "ICON";
			_default_marker setMarkerSizeLocal [0.8,0.8];
			_default_marker setMarkerTypeLocal "mil_triangle";
			_default_marker setMarkerTextLocal "TGT POS 1";
			_default_marker setMarkerAlphaLocal 1;
			_default_marker setMarkerPosLocal tgtpos;	
			_plane setVariable ["ITGT_MARKER_1",_default_marker,true];		
		
			systemChat "SYSTEM : SLOT 1 SAVED";	
			_plane setvariable ["ITGT_DATA_1",tgtpos,true];

		};
		case 2:
		{
			_marker_v = _plane getvariable "ITGT_MARKER_2";
			if (_marker_v == "none") then
			{
			}
			else
			{
				deleteMarkerLocal _marker_v;
			};
			_mn = format["%1_default_slot_marker",_nan];			
			_default_marker = createMarkerLocal [_mn, [0,0]];
			_default_marker setMarkerColorLocal "ColorBlue";
			_default_marker setMarkerShapeLocal "ICON";
			_default_marker setMarkerSizeLocal [0.8,0.8];
			_default_marker setMarkerTypeLocal "mil_triangle";
			_default_marker setMarkerTextLocal "TGT POS 2";
			_default_marker setMarkerAlphaLocal 1;
			_default_marker setMarkerPosLocal tgtpos;	
			_plane setVariable ["ITGT_MARKER_2",_default_marker,true];		
		
			systemChat "SYSTEM : SLOT 2 SAVED";	
			_plane setvariable ["ITGT_DATA_2",tgtpos,true];

		};
		case 3:
		{
			_marker_v = _plane getvariable "ITGT_MARKER_3";
			if (_marker_v == "none") then
			{
			}
			else
			{
				deleteMarkerLocal _marker_v;
			};
			_mn = format["%1_default_slot_marker",_nan];			
			_default_marker = createMarkerLocal [_mn, [0,0]];
			_default_marker setMarkerColorLocal "ColorBlue";
			_default_marker setMarkerShapeLocal "ICON";
			_default_marker setMarkerSizeLocal [0.8,0.8];
			_default_marker setMarkerTypeLocal "mil_triangle";
			_default_marker setMarkerTextLocal "TGT POS 3";
			_default_marker setMarkerAlphaLocal 1;
			_default_marker setMarkerPosLocal tgtpos;	
			_plane setVariable ["ITGT_MARKER_3",_default_marker,true];		
		
			systemChat "SYSTEM : SLOT 3 SAVED";	
			_plane setvariable ["ITGT_DATA_3",tgtpos,true];

		};
		case 4:
		{
			_marker_v = _plane getvariable "ITGT_MARKER_4";
			if (_marker_v == "none") then
			{
			}
			else
			{
				deleteMarkerLocal _marker_v;
			};
			_mn = format["%1_default_slot_marker",_nan];			
			_default_marker = createMarkerLocal [_mn, [0,0]];
			_default_marker setMarkerColorLocal "ColorBlue";
			_default_marker setMarkerShapeLocal "ICON";
			_default_marker setMarkerSizeLocal [0.8,0.8];
			_default_marker setMarkerTypeLocal "mil_triangle";
			_default_marker setMarkerTextLocal "TGT POS 4";
			_default_marker setMarkerAlphaLocal 1;
			_default_marker setMarkerPosLocal tgtpos;	
			_plane setVariable ["ITGT_MARKER_4",_default_marker,true];		
		
			systemChat "SYSTEM : SLOT 4 SAVED";	
			_plane setvariable ["ITGT_DATA_4",tgtpos,true];

		};
		case 5:
		{
			_marker_v = _plane getvariable "ITGT_MARKER_5";
			if (_marker_v == "none") then
			{
			}
			else
			{
				deleteMarkerLocal _marker_v;
			};
			_mn = format["%1_default_slot_marker",_nan];			
			_default_marker = createMarkerLocal [_mn, [0,0]];
			_default_marker setMarkerColorLocal "ColorBlue";
			_default_marker setMarkerShapeLocal "ICON";
			_default_marker setMarkerSizeLocal [0.8,0.8];
			_default_marker setMarkerTypeLocal "mil_triangle";
			_default_marker setMarkerTextLocal "TGT POS 5";
			_default_marker setMarkerAlphaLocal 1;
			_default_marker setMarkerPosLocal tgtpos;	
			_plane setVariable ["ITGT_MARKER_5",_default_marker,true];		
		
			systemChat "SYSTEM : SLOT 5 SAVED";	
			_plane setvariable ["ITGT_DATA_5",tgtpos,true];

		};
	};

	
onMapSingleClick "";
targetset = false;