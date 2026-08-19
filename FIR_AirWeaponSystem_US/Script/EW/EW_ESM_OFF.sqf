/*

AWS EW "Electronic Support Measure - ESM"  
provide the ECM for friendly aircrafts in jamming range.


by Firewill
*/
private ["_jammerpos","_pylon","_pylon_c","_range","_component","_componame","_compopick","_getunits","_frnds","_frnds_count","_ecmhandle_ary"];

_plane = vehicle player;
_pilot = driver _plane;
_planetype = typeof _plane;

_active = _plane getVariable "AWS_ESM_STATUS";

_plane setVariable ["AWS_ESM_STATUS","no",true];
