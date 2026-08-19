/*
Set Rank/Nametag System - Britania Phase by Firewill

how to use :
[this,"Name","Rank","fonttype","name back","rank back","seater"] call FIR_fnc_AWS_SetRankName;
this : aircraft what use this function
name : pilot/front name
rank : pilot/front rank
fonttype : fonttype. use AWS font classname.
name back : wso/rear name
rank back : wso/rear rank
seater : single = single seater aircraft / dual = dual seater aircraft

Name is support max 10 characters and Alphabet and numbers supported.

Support Ranklist
2LT / 2lt
CAPT / capt
MAJ / maj
COL / col
LTJG / ltjg
LCDR / lcdr
Rank Default is NO RANK

four fonts provided for basic. can be configurable.

Model must have name_1~10 and rank_tag selection.
*/

private ["_plane","_planetype","_name","_rank","_name_u","_namearray","_name_result","_pickname","_result","_result_rank","_name_c","_endp","_seater"];

_plane = [_this,0,objnull] call BIS_fnc_param;
_planetype = typeof _plane;
_name = [_this,1,""] call BIS_fnc_param;
_rank = [_this,2,""] call BIS_fnc_param;
_fonttype = [_this,3,"white"] call BIS_fnc_param;
_name_b = [_this,4,""] call BIS_fnc_param;
_rank_b = [_this,5,""] call BIS_fnc_param;
_seater = [_this,6,"single"] call BIS_fnc_param;

switch (_seater) do
{
	case "single":
	{
		[_plane,_fonttype,_name,_rank,"name_1","name_10","rank_tag"] call FIR_fnc_AWS_SetName;
	};
	case "dual":
	{
		[_plane,_fonttype,_name,_rank,"name_1","name_10","rank_tag"] call FIR_fnc_AWS_SetName;
		[_plane,_fonttype,_name_b,_rank_b,"name_b_1","name_b_10","rank_b_tag"]  call FIR_fnc_AWS_SetName;					
	};
	default
	{
		[_plane,_fonttype,_name,_rank,"name_1","name_10","rank_tag"] call FIR_fnc_AWS_SetName;				
	};

};
