
_handle= CreateDialog "FIR_ATMS_GUI";
disableSerialization;
_mydisplay = findDisplay 5981;

_check = missionNamespace getVariable ["ATMS_Check","no"];

if (_check == "yes") then
{

}
else
{
		missionNamespace setVariable ["ATMS_Check","yes",true];
		missionNamespace setVariable ["ATMS_Search_Status","no",true];		
		missionNamespace setVariable ["ATMS_Aircraft_List",[],true];
		missionNamespace setVariable ["ATMS_Team_Score",[0,0,0,0],true];	

};

[2100,[["Red Team","red"],["Blue Team","blue"],["Green Team","green"],["Yellow Team","yellow"]]] call FIR_fnc_lbadd;
