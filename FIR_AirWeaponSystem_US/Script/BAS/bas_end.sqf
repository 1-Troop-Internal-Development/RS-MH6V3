_computer = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_arg = _this select 3;

private _screen = _computer getVariable "AWS_BAS_SELECTED_SCREEN";

_computer setVariable ["AWS_BAS_CURRENT",0,true];
_computer setVariable ["AWS_BAS_STATUS","off"];

[""] remoteExec ["BIS_fnc_playVideo",([0,-2] select isDedicated),true];
[""] remoteExec ["playMusic",([0,-2] select isDedicated),true];
_screen setObjectTextureGlobal [0,"#(rgb,8,8,3)color(1,1,1,1)"];
