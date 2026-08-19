private ["_plane","_status","_index","_cam","_campos","_camdir","_camtgt","_camrot","_dir","_faketarget","_start_pos","_end_pos"];

_plane = [_this,0,objnull] call BIS_fnc_param;
_start_pos = [_this,1,"pip_pos_0"] call BIS_fnc_param;
_end_pos = [_this,2,"pip_dir_0"] call BIS_fnc_param;

_plane = _this select 0;
_planetype = typeof _plane;
_TGP_CAM = _plane getvariable "AWS_TGP_CAM";


if (currentMagazine _plane == "FIR_AGM65L_P_1rnd_M") ExitWith{_plane vehiclechat "SYSTEM : AGM-65L doesn't support TVM function.";_plane setvariable ["ITGT_VT","no"];};
if (_plane ammo "FIR_AGM65" == 0) ExitWith{_plane vehiclechat "SYSTEM : no ammo";};
_index = -1;
{
	if (_x == "cam_tracking") exitwith {_index = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");
	
_index2 = -1;
{
	if (_x == "mfd_overlay") exitwith {_index2 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");
	
_get_overlay = getText (configFile >> "CfgVehicles" >> _planetype >> "AWS_MFD_OVERLAY_MAV");
_get_overlay_zoom = getText (configFile >> "CfgVehicles" >> _planetype >> "AWS_MFD_OVERLAY_MAV_Zoom");

_plane setObjectTextureGlobal [_index , "#(argb,512,512,1)r2t(tgprtt,1)"];
_cam = "camera" camCreate [0,0,0];
_cam cameraEffect ["Internal", "Back", "tgprtt"];
_cam attachTo [_plane, [0,0,0], _start_pos];
//_cam attachTo [_plane, [0,0,0], "pip_pos_0"];
_cam camSetFov 0.7;


// "tgprtt" setPiPEffect [0];

_plane setObjectTextureGlobal [_index2,_get_overlay];

_plane setVariable ["AWS_TGP_CAM","tgprtt",true];

/*_plane setObjectTextureGlobal [_index,"#(argb,512,512,1)r2t(transportPipViewDriver,1.0)"];*/
/*"transportPipViewDriver" setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];*/
	
while {alive _plane and _plane getvariable "ITGT_VT" == "yes" and (driver _plane != objnull) } do
{

	_zoom_switch = _plane getvariable "AWS_TGP_ZOOM_Switch";
	_dir = (_plane selectionPosition _start_pos) vectorFromTo (_plane selectionPosition _end_pos);
	_cam setVectorDirAndUp [_dir,_dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]];

	if (currentMagazine _plane == "FIR_AGM65D_P_1rnd_M" or currentMagazine _plane == "FIR_AGM65D_P_3rnd_M" or currentMagazine _plane == "FIR_AGM65G_P_1rnd_M") then
	{
		"tgprtt" setPiPEffect [2];			
	}
	else
	{
		"tgprtt" setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
	};	
	
	switch (_zoom_switch) do
	{
		case "1":
		{
			_cam camSetFov 0.7;	
			_plane setObjectTextureGlobal [_index2,_get_overlay];
		};
		case "2":
		{
			_cam camSetFov 0.093;	
			_plane setObjectTextureGlobal [_index2,_get_overlay_zoom];
		};
		case "3":
		{		
			_cam camSetFov 0.029;	
			_plane setObjectTextureGlobal [_index2,_get_overlay_zoom];
		};
	};
	


	sleep 0.003;
};
_plane vehiclechat "cam closed";
onEachFrame {};
_plane setvariable ["ITGT_VT","no"];
_cam cameraEffect ["terminate","back","tgprtt"];
camdestroy _cam;
_plane setObjectTextureGlobal [_index, ""];
_plane setObjectTextureGlobal [_index2, ""];
_plane setVariable ["AWS_TGP_CAM","",true];