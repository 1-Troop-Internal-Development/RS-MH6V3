
private _plane = _this select 0;
private _pilot = driver _plane;

private _teamscore = missionNamespace getVariable "ATMS_Team_Score";

_plane vehicleChat format ["SCORE - RED : %1 pts / BLUE : %2 pts / GREEN : %3 pts / YELLOW : %4 pts",_teamscore select 0, _teamscore select 1, _teamscore select 2,_teamscore select 3];

