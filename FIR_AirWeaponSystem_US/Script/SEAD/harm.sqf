/* SEAD System by Firewill*/
private ["_plane","_htscount","_ArrayAA","_CountAA"];

_plane = _this select 0;
_plane setVariable ["SEAD_SET","yes",true]; 

If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};

_htscount = {_x == "FIR_HTSPod_1rnd_M"} count magazines _plane;
_htscount2 = {_x == "FIR_SniperXRPod_HTS_1rnd_M"} count magazines _plane;

if (_htscount >= 1 or _htscount2 >= 1) then 
{

	_plane vehiclechat "SYSTEM : HTS Long-Range Scan MOD";
	_ArrayAA = (getpos _plane) nearEntities [["O_APC_Tracked_02_AA_F","pook_30N6E2_Base",
"pook_30N6E_Base",
"pook_5P85D_Base",
"pook_76N6_radar",
"pook_96K6_base",
"pook_96L6E_radar",
"pook_9K317_Base",
"pook_9K317M2_Base",
"pook_9K317M3_Base",
"pook_9K331_Base",
"pook_9K332_base",
"pook_9K37_Base",
"pook_9K37M2_base",
"pook_9S36_Base",
"pook_P12_base",
"pook_PRV11_base",
"pook_PU12_base",
"pook_radome1",
"pook_radome2",
"pook_S60_base",
"pook_SA19_Base",
"pook_SA20_static_base",
"pook_SA2_static",
"pook_SA2_tracked",
"pook_SA3_radar_base",
"pook_SA3_static",
"pook_SA3_tracked",
"pook_SNR75_radar",
"pook_SON50_BASE",
"pook_SON9_base"],11000];
	_CountAA = count _ArrayAA;
}
else
{	
	_plane vehiclechat "SYSTEM : RWR Short-Range Scan MOD";
	_ArrayAA = (getpos _plane) nearEntities [["O_APC_Tracked_02_AA_F","pook_30N6E2_Base",
"pook_30N6E_Base",
"pook_5P85D_Base",
"pook_76N6_radar",
"pook_96K6_base",
"pook_96L6E_radar",
"pook_9K317_Base",
"pook_9K317M2_Base",
"pook_9K317M3_Base",
"pook_9K331_Base",
"pook_9K332_base",
"pook_9K37_Base",
"pook_9K37M2_base",
"pook_9S36_Base",
"pook_P12_base",
"pook_PRV11_base",
"pook_PU12_base",
"pook_radome1",
"pook_radome2",
"pook_S60_base",
"pook_SA19_Base",
"pook_SA20_static_base",
"pook_SA2_static",
"pook_SA2_tracked",
"pook_SA3_radar_base",
"pook_SA3_static",
"pook_SA3_tracked",
"pook_SNR75_radar",
"pook_SON50_BASE",
"pook_SON9_base"],5000];
	_CountAA = count _ArrayAA;
};

private ["_RDRTGT","_ArrayRDR","_CountRDR","_tgt"];
_RDRTGT = "";
_ArrayRDR = [];
_CountRDR = 0;
_tgt = "";

for [{_i=0}, {_i<_CountAA}, {_i=_i+1}] do
{
		_RDRTGT = "FIR_I_TGT_FAKE" createVehicleLocal position (_ArrayAA select _i);	
		sleep 0.5;
		_tgt = _ArrayAA select _i;
		_pos = getpos _tgt;
		_ArrayRDR pushback _RDRTGT;
		_countRDR = count _ArrayRDR;
		_RDRTGT setpos _pos;
		_RDRTGT attachTo [_tgt,[0,3,0]];		
		sleep 1;
};




waitUntil {_plane getvariable "SEAD_SET" == "no"};

for [{_y=0}, {_y<=_CountRDR}, {_y=_y+1}] do
{
	deleteVehicle (_ArrayRDR select _y);
	sleep 0.03;
};