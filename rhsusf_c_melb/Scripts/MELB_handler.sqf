/*
UH1Y Flir camera handling script
handles monitor stuff

a: reyhard
*/
disableSerialization;

uiNameSpace setVariable ["MELB_Ctrl",_this select 0];



/*
heli
low refresh rate loop [1 sec]
*/

[] spawn
{
	sleep 0.1;
	disableSerialization;
	private _c = uiNamespace getVariable "MELB_Ctrl";
	private _w = (_c displayCtrl 120);

	private _grid2		= [];
	private _gridaA		= "";
	private _oldZoom	= 0.3;

	private _p	= call RHS_fnc_findPlayer;
	private _v	= vehicle _p;

	/*
		core r2t handling
	*/
	melbFlir=_v;

	melb_cam = "camera" camCreate [0,0,0];
	melb_cam cameraEffect ["Internal", "Back", "rendertarget0"];

	melb_cam attachTo [melbFlir, [0,0,0], "commanderview"];
	melb_cam camSetFov (0.3/_oldZoom);

	"rendertarget0" setPiPEffect [3,1,1,0.8,-0.01,[0,0,0,0],[1,1,1,1],[1,1,1,0]];

	_ehID = addMissionEventHandler ["Draw3D", {
		_dir =
			(melbFlir selectionPosition "laserstart")
				vectorFromTo
			(melbFlir selectionPosition "commanderview");
		melb_cam setVectorDirAndUp [
			_dir,
			_dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]
		];
	}];

	while{not(isNull _w)}do
	{
		/*
			pip camera zoom - as zoom data is synced max at each seconds, there is small transition applied there
		*/
		_n = (_v getVariable ["MELB_zoom",42])/40;
		if(_oldZoom != _n)then
		{
			melb_cam camSetFov (0.3/_n);
			_oldZoom = _n;
		};
		sleep 1;
	};

	uiNameSpace setVariable ["MELB_Ctrl",displayNull];
	removeMissionEventHandler ["draw3d",_ehID];
	melb_cam cameraeffect ["terminate","back"];
	camDestroy melb_cam;
	melb_cam = nil;
	melbFlir = nil;
};



/*
heli
high refresh rate loop [0.06 sec]
*/
[] spawn
{
	sleep 0.1;

	disableSerialization;
	private _c		= uiNamespace getVariable "MELB_Ctrl";
	private _w		= (_c displayCtrl 120);

	private _p		= call RHS_fnc_findPlayer;
	private _v		= vehicle _p;
	private _old	= 0;

	while{not(isNull _w)}do
	{
		/*
			camera mode handler
		*/
		_mode = _v getVariable ["MELB_mode",0];
		if(_mode != _old)then
		{
			melb_cam cameraeffect ["terminate","back", "rendertarget0"];
			melb_cam cameraEffect ["internal", "Back", "rendertarget0"];
			switch(_mode)do
			{
				case 0: { "rendertarget0" setPiPEffect [3,1,1,0.8,-0.01,[0,0,0,0],[1,1,1,1],[1,1,1,0]]; };
				case 1: { "rendertarget0" setPiPEffect [3,1,1,3.5,0,[0,0,0,0],[0.5,1,0.5,0],[1,1,1,0]]; };
				case 2: { "rendertarget0" setPiPEffect [2]; };
			};
			_old = _mode;
		};

		sleep 0.1;
	};

};
