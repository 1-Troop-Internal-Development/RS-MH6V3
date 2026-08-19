// Ejection effect //
_plane= _this select 0;
_Ejection_Seat = _this select 1;
_Pilot = driver _Ejection_Seat;

private _configPath = configFile >> "CfgVehicles" >> (typeOf _plane) >> "EjectionSystem";
private _ejectionSoundInt = getText (_configPath >>"EjectionSoundInt");
private _ejectionSoundExt = getText (_configPath >>"EjectionSoundExt");

_Ejection_Seat say _ejectionSoundInt;
_Ejection_Seat say3D _ejectionSoundExt;

_FX_light_source = "#lightpoint" createVehicle getpos _Ejection_Seat;
_FX_light_source  setLightBrightness 0.3;
_FX_light_source  setLightAmbient[0.8, 0.6, 0.2];
_FX_light_source  setLightColor[1, 0.5, 0.2];
_FX_light_source  lightAttachObject [_Ejection_Seat, [0,0,0]];

sleep 0.01;

deleteVehicle _FX_light_source;

_FX_smoke_source = "#particlesource" createVehicle (getpos _plane);
_FX_smoke_source setParticleClass "FIR_MissileEffect2";
_FX_smoke_source attachto [_plane,[0,0,0],"actionarea"];

_FX_smoketrail_source = "#particlesource" createVehicle (getpos _Ejection_Seat);
_FX_smoketrail_source setParticleClass "FIR_MissileEffect2";
_FX_smoketrail_source attachto [_Ejection_Seat,[0,0,0],"FX_pos"];

sleep 0.4;
deleteVehicle _FX_smoke_source;
sleep 0.8;
deleteVehicle _FX_smoketrail_source;
Exit;
