/*MFD Targeting System by Firewill*/

private ["_user","_tgtpos","_targetset","_select_mem"];

_lb = (findDisplay 5589) displayCtrl 2100;

_select_mem = lbCurSel _lb;
_user = player;

targetset = false;

systemChat "SYSTEM : Portable I-TARGETING System is Running. Select the Target Location.";

onMapSingleClick "tgtpos = _pos;targetset = true"; 

waitUntil {targetset}; 

systemChat "SYSTEM : Record Target Coordinate to Memory.";

_nan = round(random 10000);


	Switch (_select_mem) do
	{
		case -1:
		{
			_marker_v = _user getvariable "ITGT_MARKER_1";
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
			_user setVariable ["ITGT_MARKER_1",_default_marker,true];
			
			systemChat "SYSTEM : SAVE THE DEFAULT SLOT 1";
			_user setvariable ["ITGT_DATA_1",tgtpos,true];

		};
		case 0:
		{
			_marker_v = _user getvariable "ITGT_MARKER_1";
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
			_user setVariable ["ITGT_MARKER_1",_default_marker,true];		
		
			systemChat "SYSTEM : SAVE THE SLOT 1";	
			_user setvariable ["ITGT_DATA_1",tgtpos,true];

		};
		case 1:
		{
			_marker_v = _user getvariable "ITGT_MARKER_2";
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
			_user setVariable ["ITGT_MARKER_2",_default_marker,true];		
		
			systemChat "SYSTEM : SAVE THE SLOT 2";	
			_user setvariable ["ITGT_DATA_2",tgtpos,true];

		};
		case 2:
		{
			_marker_v = _user getvariable "ITGT_MARKER_3";
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
			_user setVariable ["ITGT_MARKER_3",_default_marker,true];		
		
			systemChat "SYSTEM : SAVE THE SLOT 3";	
			_user setvariable ["ITGT_DATA_3",tgtpos,true];

		};
		case 3:
		{
			_marker_v = _user getvariable "ITGT_MARKER_4";
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
			_user setVariable ["ITGT_MARKER_4",_default_marker,true];		
		
			systemChat "SYSTEM : SAVE THE SLOT 4";	
			_user setvariable ["ITGT_DATA_4",tgtpos,true];

		};
		case 4:
		{
			_marker_v = _user getvariable "ITGT_MARKER_5";
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
			_user setVariable ["ITGT_MARKER_5",_default_marker,true];		
		
			systemChat "SYSTEM : SAVE THE SLOT 5";	
			_user setvariable ["ITGT_DATA_5",tgtpos,true];

		};
	};

onMapSingleClick "";
targetset = false;