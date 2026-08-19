private _applylist = missionNamespace getVariable "ATMS_Aircraft_List";

private _index = count _applylist;
_index = _index - 1;
private _team_array = [0,0,0,0];
private _r_text = "RED TEAM : ";
private _b_text = "BLUE TEAM : ";
private _g_text = "GREEN TEAM : ";
private _y_text = "YELLOW TEAM : ";
disableSerialization;
_mydisplay = findDisplay 5981;

_stext = _mydisplay displayCtrl 1100;

_status = missionNamespace getVariable ["ATMS_Search_Status","no"];

if (_status == "no") exitWith {hintSilent "search aircraft first"};

for "_i" from 0 to _index do
{

	_plane = _applylist select _i;
	
	_data = _plane getVariable "AWS_ACMI_PLANE_DATA";
	_id = _data select 0;
	_callsign = _data select 1;
	_team = _data select 2;
	
	switch (_team) do
	{
		case "red":
		{
			_r_c = _team_array select 0;
			_r_c = _r_c + 1;
			_team_array set [0, _r_c];
			_r_text  = _r_text + "/" +  _callsign;
		};
		case "blue":
		{
			_b_c = _team_array select 1;
			_b_c = _b_c + 1;
			_team_array set [1, _b_c];
			_b_text  = _b_text + "/" +  _callsign;			
		};
		case "green":
		{
			_g_c = _team_array select 2;
			_g_c = _g_c + 1;
			_team_array set [2, _g_c];
			_g_text  = _g_text + "/" +  _callsign;			
		};
		case "yellow":
		{
			_y_c = _team_array select 3;
			_y_c = _y_c + 1;
			_team_array set [3, _y_c];
			_y_text  = _y_text + "/" +  _callsign;			
		};		
	};


};

_txt = composeText ["CURRENT TEAM",lineBreak, _r_text," x", str (_team_array select 0),lineBreak,_b_text," x", str (_team_array select 1),lineBreak,_g_text," x", str (_team_array select 2),lineBreak,_y_text," x",str (_team_array select 3),lineBreak];
_stext ctrlSetStructuredText _txt;