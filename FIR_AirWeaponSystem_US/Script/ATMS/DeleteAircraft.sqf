
private _list = missionNamespace getVariable "ATMS_Aircraft_List";

private _data = lbData [1500, (lbCurSel 1500)];
private _team_data = lbData [2100, (lbCurSel 2100)];
lbSetColor [1500,  (lbCurSel 1500), [1, 1, 1, 1]];		
private _applylist = [];

_status = missionNamespace getVariable ["ATMS_Search_Status","no"];
_applylist = missionNamespace getVariable "ATMS_Aircraft_List";	

if (_status isEqualTo "no") exitWith {hintSilent "search aircraft first"};

private _plane = missionNamespace getVariable _data;
private _check = _plane getVariable ["AWS_ACMI_PLANE_STATUS","no"];

if (_check == "no") exitWith {hintSilent "this aircraft is not in the list.";};

private _index = _list find _plane;
 
_list deleteAt _index;

missionNamespace setVariable ["ATMS_Aircraft_List",_list,true];
_plane removeAllEventHandlers "HandleDamage";
_plane setvariable ["AWS_ACMI_PLANE_DATA",[],true];
_plane setVariable ["AWS_ACMI_PLANE_STATUS","no",true];

hintSilent "aircraft removed from the list";

