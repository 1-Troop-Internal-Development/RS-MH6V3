// WORK IN PROGRESS
// EXPECT LOTS OF BUG
//



private ["_plane","_status","_index","_cam","_mssl","_weapon","_mssl","_mssl_status","_mssl_vector_dir","_mssl_vector_up","_mssl_vector_dir_x","_mssl_vector_dir_y","_mssl_vector_dir_z","_mssl_vector_up_x","_mssl_vector_up_y","_mssl_vector_up_z"];

_mssl = _this select 0;
_plane = _this select 1;
_weapon = _this select 2;

_mssl_vector = 0;

_planetype = typeof _plane;

_status = _plane getvariable ["EO_Tracking","no"];
_check = _plane getvariable "ITGT_NEW";

if (_weapon != "FIR_AGM84H") exitWith {};
if (_check != "no") ExitWith {_plane vehiclechat "CAUTION : I-TGT RUNNING. PRESS CLR BUTTON IN I-TGT MENU.";};
if (_status == "run") exitWith {};

_plane setvariable ["EO_Tracking","run",true];
_plane setvariable ["ITGT_VT","yes"];


/*check cam_targeting screen in aircraft. */
	_index = -1;
	{
		if (_x == "cam_tracking") exitwith {_index = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

	_index_wso = -1;
	{
		if (_x == "cam_tracking_wso") exitwith {_index_wso = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
	
_index2 = -1;
{
	if (_x == "mfd_overlay") exitwith {_index2 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");
	
_get_overlay = getText (configFile >> "CfgVehicles" >> _planetype >> "AWS_MFD_OVERLAY_TGP");	

_mssl_vector_dir = vectorDir _mssl;
_mssl_vector_dir_x = _mssl_vector_dir select 0;
_mssl_vector_dir_y = _mssl_vector_dir select 1;
_mssl_vector_dir_z = _mssl_vector_dir select 2;

_mssl_vector_up = vectorUp _mssl;
_mssl_vector_up_x = _mssl_vector_up select 0;
_mssl_vector_up_y = _mssl_vector_up select 1;
_mssl_vector_up_z = _mssl_vector_up select 2;

/*create the cam and attach to aircraft, also setting FLIR mode*/
_cam = "camera" camCreate [0,0,0];
_cam cameraEffect ["Internal", "Back", "eocamrtt"];
_cam attachTo [_mssl, [0,0,0]];
_cam camSetFov 0.7;
// "eocamrtt" setPiPEffect [2];

_cam setVectorDir [_mssl_vector_dir_x,_mssl_vector_dir_y,_mssl_vector_dir_z];
_cam setVectorUp [_mssl_vector_up_x,_mssl_vector_up_y,_mssl_vector_up_z];

	_plane setObjectTextureGlobal [_index , "#(argb,512,512,1)r2t(eocamrtt,1)"];
	_plane setObjectTextureGlobal [_index_wso , "#(argb,512,512,1)r2t(eocamrtt,1)"];

_plane setVariable ["AWS_TGP_CAM","eocamrtt",true];


_plane setObjectTextureGlobal [_index2,_get_overlay];
		
	
while {alive _mssl} do
{
	_zoom_switch = _plane getvariable "AWS_TGP_ZOOM_Switch";
	
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
		_cam camSetTarget _mssl;
		_cam camSetRelPos [0,0.5,0];	
		_cam camCommit 0;
	// _pos = getpos _mssl;
	// _dir = getdir _mssl;
	// _cam setpos _pos;
	// _cam setdir _dir;
	// _mssl_vector_dir = vectorDir _mssl;
	// _mssl_vector_dir_x = _mssl_vector_dir select 0;
	// _mssl_vector_dir_y = _mssl_vector_dir select 1;
	// _mssl_vector_dir_z = _mssl_vector_dir select 2;

	// _mssl_vector_up = vectorUp _mssl;
	// _mssl_vector_up_x = _mssl_vector_up select 0;
	// _mssl_vector_up_y = _mssl_vector_up select 1;
	// _mssl_vector_up_z = _mssl_vector_up select 2;

	// _cam setVectorDir [_mssl_vector_dir_x,_mssl_vector_dir_y,_mssl_vector_dir_z];
	// _cam setVectorUp [_mssl_vector_up_x,_mssl_vector_up_y,_mssl_vector_up_z];

    sleep 0.01;
};

_plane setvariable ["ITGT_VT","no"];
_cam cameraEffect ["terminate","back","eocamrtt"];
camdestroy _cam;
_plane setvariable ["EO_Tracking","no",true];
_plane setObjectTextureGlobal [_index, ""];
_plane setObjectTextureGlobal [_index_wso, ""];
_plane setObjectTextureGlobal [_index2, ""];
_plane setVariable ["AWS_TGP_CAM","",true];
