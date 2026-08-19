/*MFD Targeting System by Firewill*/

private ["_user","_tgtpos","_targetset","_select_mem","_data","_backup_data","_backup_data_c"];

_lb = (findDisplay 5589) displayCtrl 2100;

_select_mem = lbCurSel _lb;
_user = player;


if (_user getVariable "ITGT_TGT_SET" == "yes") exitWith{systemChat "ERROR : CLEAR THE DESIGNATED DATA FIRST."};
systemChat "SYSTEM : Delete Memory Data";
_backup_data_c = _user getVariable "ITGT_C_DATA";

	Switch (_select_mem) do
	{
		case -1:
		{
			_backup_data = _user getVariable "ITGT_DATA_1";
			systemChat "SYSTEM : ERASE THE DEFAULT SLOT 1";
			_user setvariable ["ITGT_DATA_1",[],true];			
			
			_marker_v = _user getvariable "ITGT_MARKER_1";
			deleteMarkerLocal _marker_v;
		};
		case 0:
		{
			_backup_data = _user getVariable "ITGT_DATA_1";
			systemChat "SYSTEM : ERASE THE SLOT 1";	
			_user setvariable ["ITGT_DATA_1",[],true];			
			
			_marker_v = _user getvariable "ITGT_MARKER_1";
			deleteMarkerLocal _marker_v;
		};
		case 1:
		{
			_backup_data = _user getVariable "ITGT_DATA_2";
			systemChat "SYSTEM : ERASE THE SLOT 2";	
			_user setvariable ["ITGT_DATA_2",[],true];			
			
			_marker_v = _user getvariable "ITGT_MARKER_2";
			deleteMarkerLocal _marker_v;
		};
		case 2:
		{
			_backup_data = _user getVariable "ITGT_DATA_3";
			systemChat "SYSTEM : ERASE THE SLOT 3";	
			_user setvariable ["ITGT_DATA_3",[],true];			
			
			_marker_v = _user getvariable "ITGT_MARKER_3";
			deleteMarkerLocal _marker_v;
		};
		case 3:
		{
			_backup_data = _user getVariable "ITGT_DATA_4";
			systemChat "SYSTEM : ERASE THE SLOT 4";	
			_user setvariable ["ITGT_DATA_4",[],true];			
			
			_marker_v = _user getvariable "ITGT_MARKER_4";
			deleteMarkerLocal _marker_v;
		};
		case 4:
		{
			_backup_data = _user getVariable "ITGT_DATA_5";
			systemChat "SYSTEM : ERASE THE SLOT 5";	
			_user setvariable ["ITGT_DATA_5",[],true];			
			
			_marker_v = _user getvariable "ITGT_MARKER_5";
			deleteMarkerLocal _marker_v;
		};
	};
	
	
