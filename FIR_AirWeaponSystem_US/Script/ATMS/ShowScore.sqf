private _teamscore = missionNamespace getVariable "ATMS_Team_Score";

private _r_text = "RED TEAM : ";
private _b_text = "BLUE TEAM : ";
private _g_text = "GREEN TEAM : ";
private _y_text = "YELLOW TEAM : ";
disableSerialization;
_mydisplay = findDisplay 5981;

_stext = _mydisplay displayCtrl 1100;

_txt = composeText ["CURRENT SCORE",lineBreak, _r_text, str (_teamscore select 0),"Points",lineBreak,_b_text, str (_teamscore select 1),"Points",lineBreak,_g_text, str (_teamscore select 2),"Points",lineBreak,_y_text, str (_teamscore select 3),"Points",lineBreak];
_stext ctrlSetStructuredText _txt;