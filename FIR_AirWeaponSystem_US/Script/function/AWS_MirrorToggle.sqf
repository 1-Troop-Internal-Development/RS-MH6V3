private ["_plane","_mirror_array","_mirror_array2","_mirror","_mirror_array2_count","_mirror_count","_mirror_del","_mirror_dir","_mirror_rtt","_mirror_rtt_del","_mirror_pos","_mirror_tex","_mirror_tex_del","_index","_dir"];

_plane = [_this,0,objnull] call BIS_fnc_param;
_mirror_array = [_this,1,["mirror_1_tex","PIP0_pos","PIP0_dir","mirror1rtt","#(argb,512,512,1)r2t(mirror1rtt,1)"]] call BIS_fnc_param;

_planetype = typeof _plane;

waitUntil  {_plane animationSourcePhase "mirror_toggle" > 0.9};

_mirror_array2 = [];

_mirror_count = count _mirror_array;

for "_i" from 0 to _mirror_count-1 do
{
	_mirror = _mirror_array select _i;
	
	_mirror_tex = _mirror select 0;
	_mirror_pos = _mirror select 1;
	_mirror_dir = _mirror select 2;
	_mirror_rtt = _mirror select 3;
	_mirror_code = _mirror select 4;
	
	_index = -1;
	{
		if (_x == _mirror_tex) exitwith {_index = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");	
	
	_cam = "camera" camCreate [0,0,0];
	_cam cameraEffect ["Internal", "Back", _mirror_rtt];
	_cam attachTo [_plane, [0,0,0], _mirror_pos];
	_cam camSetFov 0.6;	

	_mirror_rtt setPiPEffect [4];
	
	_plane setObjectTextureGlobal [_index ,_mirror_code];		

	_dir = (_plane selectionPosition _mirror_pos) vectorFromTo (_plane selectionPosition _mirror_dir);
	_cam setVectorDirAndUp [_dir,_dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]];
	
	_mirror_array2 pushback [_cam,_mirror_tex,_mirror_rtt];
};

while {alive _plane and _plane animationSourcePhase "mirror_toggle" > 0.9 } do
{
	sleep 0.03;
};

_mirror_array2_count = count _mirror_array2;

for "_i" from 0 to _mirror_array2_count-1 do
{
	_mirror_del = _mirror_array2 select _i;
	_camera = _mirror_del select 0;
	_mirror_tex_del = _mirror_del select 1;
	_mirror_rtt_del = _mirror_del select 2;
	_index = -1;
	{
		if (_x == _mirror_tex_del) exitwith {_index = _foreachindex;};
	} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");		
	_camera cameraEffect ["terminate","back",_mirror_rtt_del];
	camdestroy _camera;
	_plane setObjectTextureGlobal [_index, ""];
};
