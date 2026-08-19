private ["_plane","_status","_index","_index_wso","_cam","_campos","_camdir","_camtgt","_camrot","_dir","_faketarget","_start_pos","_end_pos","_seater"];

_plane = [_this,0,objnull] call BIS_fnc_param;
_seater = [_this,1,"single"] call BIS_fnc_param;
_start_pos = [_this,2,"pip_pos_0"] call BIS_fnc_param;
_end_pos = [_this,3,"pip_dir_0"] call BIS_fnc_param;


_plane = _this select 0;
_planetype = typeof _plane;
_TGP_CAM = _plane getvariable "AWS_TGP_CAM";

if (_seater == "single") then
{
	_index = -1;
	{
		if (_x == "cam_tracking") exitwith {_index = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");
}
else
{
	_index = -1;
	{
		if (_x == "cam_tracking") exitwith {_index = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

	_index_wso = -1;
	{
		if (_x == "cam_tracking_wso") exitwith {_index_wso = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
};

_index2 = -1;
{
	if (_x == "mfd_overlay") exitwith {_index2 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");
	
_get_overlay = getText (configFile >> "CfgVehicles" >> _planetype >> "AWS_MFD_OVERLAY_TGP");

// _plane setObjectTextureGlobal [_index , "#(argb,512,512,1)r2t(tgprtt,1)"];
_cam = "camera" camCreate [0,0,0];
_cam cameraEffect ["Internal", "Back", "tgprtt"];
_cam attachTo [_plane, [0,0,0], _start_pos];
_cam camSetFov 0.7;

"tgprtt" setPiPEffect [0];

if (_seater == "single") then
{
	_plane setObjectTextureGlobal [_index , "#(argb,512,512,1)r2t(tgprtt,1)"];
}
else
{
	_plane setObjectTextureGlobal [_index , "#(argb,512,512,1)r2t(tgprtt,1)"];
	_plane setObjectTextureGlobal [_index_wso , "#(argb,512,512,1)r2t(tgprtt,1)"];
};

_plane setVariable ["AWS_TGP_CAM","tgprtt",true];


_plane setObjectTextureGlobal [_index2,_get_overlay];
	
while {alive _plane and _plane getvariable "ITGT_VT" == "yes" and (driver _plane != objnull) } do
{

	_zoom_switch = _plane getvariable "AWS_TGP_ZOOM_Switch";
	_dir = (_plane selectionPosition _start_pos) vectorFromTo (_plane selectionPosition _end_pos);
	_cam setVectorDirAndUp [_dir,_dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]];

	switch (_zoom_switch) do
	{
		case "1":
		{
			_cam camSetFov 0.7;	
		};
		case "2":
		{
			_cam camSetFov 0.093;	
		};
		case "3":
		{
			_cam camSetFov 0.029;	
		};
	};
	


	sleep 0.003;
};
_plane vehiclechat "cam closed";
onEachFrame {};
_plane setvariable ["ITGT_VT","no"];
_cam cameraEffect ["terminate","back","tgprtt"];
camdestroy _cam;

if (_seater == "single") then
{
	_plane setObjectTextureGlobal [_index, ""];
}
else
{
	_plane setObjectTextureGlobal [_index, ""];
	_plane setObjectTextureGlobal [_index_wso, ""];
};


// _plane setObjectTextureGlobal [_index, ""];
// _plane setObjectTextureGlobal [_index_wso, ""];
_plane setObjectTextureGlobal [_index2, ""];
_plane setVariable ["AWS_TGP_CAM","",true];