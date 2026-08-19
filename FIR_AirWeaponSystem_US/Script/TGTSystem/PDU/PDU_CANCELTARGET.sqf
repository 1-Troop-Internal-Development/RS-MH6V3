/*MFD Targeting System by Firewill*/

private ["_user","_tgtpos","_targetset","_select_mem","_data"];

_lb = (findDisplay 5589) displayCtrl 2100;

_select_mem = lbCurSel _lb;
_user = player;


systemChat "SYSTEM : Erase the Data from FCS";

_marker_d = _user getvariable "ITGT_C_MARKER";
deleteMarkerLocal _marker_d;

_user setvariable ["ITGT_NEW","no",true];		

_user setvariable ["ITGT_C_DATA",[],true];	
_user setVariable ["ITGT_C_MARKER","none"];	
_user setVariable ["ITGT_TGT_SET","no",true];	
