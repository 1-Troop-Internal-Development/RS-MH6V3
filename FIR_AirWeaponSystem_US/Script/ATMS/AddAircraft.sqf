
private _data = lbData [1500, (lbCurSel 1500)];
private _team_data = lbData [2100, (lbCurSel 2100)];
private _callsign = ctrlText 1400;
private _hdeh = 0;

private _status = missionNamespace getVariable ["ATMS_Search_Status","no"];
private _applylist = missionNamespace getVariable "ATMS_Aircraft_List";	

if (_status isEqualTo "no") exitWith {hintSilent "search aircraft first"};

private _plane = missionNamespace getVariable _data;

private _id = _plane getVariable "AWS_ACMI_PLANE";

if (_id isEqualTo _data and not (_id in _applylist)) exitWith 
{
		_plane setvariable ["AWS_ACMI_PLANE_DATA",[_id,_callsign,_team_data],true];
		_plane setVariable ["AWS_ACMI_PLANE_STATUS","yes",true];
		_applylist pushback _plane;
		missionNamespace setVariable ["ATMS_Aircraft_List",_applylist,true];
		// [[_plane],"FIR_AirWeaponSystem_US\Script\ATMS\ATMS_Init.sqf"] remoteExec ["execVM",([0,-2] select isDedicated)];		
		// _hdeh = _plane addEventHandler ["HandleDamage", {[[_this],"FIR_AirWeaponSystem_US\Script\ATMS\TWAS.sqf"] remoteExec ["execVM",0];}]; 		
		_hdeh = [_plane,["HandleDamage", {[[_this],"FIR_AirWeaponSystem_US\Script\ATMS\TWAS.sqf"] remoteExec ["execVM",([0,-2] select isDedicated)];}]] remoteExec ["addEventHandler",([0,-2] select isDedicated)];	
		hintSilent format ["%1 added, callsign %2 to %3 team",_id,_callsign,_team_data];		

		switch (_team_data) do
		{
			case "red":
			{
				lbSetColor [1500, (lbCurSel 1500), [1, 0, 0, 1]];		
			};
			case "blue":
			{
				lbSetColor [1500, (lbCurSel 1500), [0, 0.1, 1, 1]];			
			};
			case "green":
			{
				lbSetColor [1500, (lbCurSel 1500), [0, 1, 0, 1]];		
			};
			case "yellow":
			{
				lbSetColor [1500, (lbCurSel 1500), [1, 1, 0, 1]];			
			};		
		};		
};


