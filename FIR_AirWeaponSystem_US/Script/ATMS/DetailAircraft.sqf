
if ((lbcursel 1500) == -1) exitWith {hintSilent "select aircraft";};
private _data = lbData [1500, (lbCurSel 1500)];
disableSerialization;
_mydisplay = findDisplay 5981;

_stext = _mydisplay displayCtrl 1100;

private _status = missionNamespace getVariable ["ATMS_Search_Status","no"];
private _applylist = missionNamespace getVariable "ATMS_Aircraft_List";	

if (_status isEqualTo "no") exitWith {hintSilent "search aircraft first"};

private _plane = missionNamespace getVariable _data;


private _status =  _plane getVariable ["AWS_ACMI_PLANE_STATUS","no"];

if (_status == "yes") then
{
private _aircrtaft_data = _plane getVariable "AWS_ACMI_PLANE_DATA";
private _id = _aircrtaft_data select 0;
private _callsign = _aircrtaft_data select 1;
private _team = _aircrtaft_data select 2;

private _name = getText (configFile >> "CfgVehicles" >> typeof _plane >> "displayName");	


_txt = composeText ["AIRCRAFT INFO",lineBreak, "NAME : ",_name, lineBreak, "ID : ",_id, lineBreak, "CALLSIGN : ", _callsign,lineBreak,"TEAM : ",_team, lineBreak];
_stext ctrlSetStructuredText _txt;
}
else
{
private _name = getText (configFile >> "CfgVehicles" >> typeof _plane >> "displayName");	

_txt = composeText ["AIRCRAFT INFO",lineBreak, "NAME : ",_name, lineBreak, "DATA NOT FOUND"];
_stext ctrlSetStructuredText _txt;
};

