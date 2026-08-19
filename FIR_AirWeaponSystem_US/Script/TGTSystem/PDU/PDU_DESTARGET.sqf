/*MFD Targeting System by Firewill*/

private ["_user","_tgtpos","_targetset","_select_mem","_data","_des_marker","_lsr_marker","_lsr_tgt","_lsr"];

_lb = (findDisplay 5589) displayCtrl 2100;

_select_mem = lbCurSel _lb;
_user = player;




systemChat "SYSTEM : Send the Target Coordinate to the FCS";
_data = "";
_nan = round(random 10000);

if (_user getVariable "ITGT_TGT_SET" == "yes") exitWith{systemChat "ERROR : CLEAR THE DESIGNATED DATA FIRST."};

	Switch (_select_mem) do
	{
		case -1:
		{
			systemChat "SYSTEM : SEND THE DEFAULT SLOT 1";
			_data = _user getvariable "ITGT_DATA_1";
			_user setvariable ["ITGT_C_DATA",_data,true];

					
		};
		case 0:
		{
			systemChat "SYSTEM : SEND THE SLOT 1";	
			_data = _user getvariable "ITGT_DATA_1";
			_user setvariable ["ITGT_C_DATA",_data,true];

		};
		case 1:
		{
			systemChat "SYSTEM : SEND THE SLOT 2";	
			_data = _user getvariable "ITGT_DATA_2";
			_user setvariable ["ITGT_C_DATA",_data,true];

		};
		case 2:
		{
			systemChat "SYSTEM : SEND THE SLOT 3";	
			_data = _user getvariable "ITGT_DATA_3";
			_user setvariable ["ITGT_C_DATA",_data,true];

		};
		case 3:
		{
			systemChat "SYSTEM : SEND THE SLOT 4";	
			_data = _user getvariable "ITGT_DATA_4";
			_user setvariable ["ITGT_C_DATA",_data,true];

		};
		case 4:
		{
			systemChat "SYSTEM : SEND THE SLOT 5";	
			_data = _user getvariable "ITGT_DATA_5";
			_user setvariable ["ITGT_C_DATA",_data,true];

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
		
		_user setvariable ["ITGT_NEW","yes",true];	
	
_user setVariable ["ITGT_C_MARKER",_des_marker,true];	
_user setVariable ["ITGT_TGT_SET","yes",true];
	

