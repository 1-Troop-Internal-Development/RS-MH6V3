class RS_MH6V3_RscText
{
	type = 0;
	idc = -1;
	style = 0;
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.05;
	font = "RobotoCondensed";
	sizeEx = 0.035;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	text = "";
};

class RS_MH6V3_RscPicture
{
	type = 0;
	idc = -1;
	style = 48;
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "RobotoCondensed";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
};

class RS_MH6V3_RscButton
{
	type = 1;
	idc = -1;
	style = 2;
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.05;
	font = "RobotoCondensed";
	sizeEx = 0.034;
	colorText[] = {1,1,1,1};
	colorDisabled[] = {0.5,0.5,0.5,1};
	colorBackground[] = {0.12,0.14,0.13,1};
	colorBackgroundDisabled[] = {0.08,0.08,0.08,1};
	colorBackgroundActive[] = {0.24,0.32,0.24,1};
	colorFocused[] = {0.24,0.32,0.24,1};
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
	text = "";
};

class RS_MH6V3_RscCombo
{
	type = 4;
	idc = -1;
	style = 16;
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.05;
	font = "RobotoCondensed";
	sizeEx = 0.034;
	rowHeight = 0.04;
	wholeHeight = 0.32;
	colorText[] = {1,1,1,1};
	colorSelect[] = {1,1,1,1};
	colorDisabled[] = {0.5,0.5,0.5,1};
	colorBackground[] = {0.08,0.09,0.085,1};
	colorSelectBackground[] = {0.24,0.32,0.24,1};
	colorScrollbar[] = {1,1,1,1};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};
	soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
	soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};
	maxHistoryDelay = 1;
	class ComboScrollBar
	{
		color[] = {1,1,1,1};
	};
};

class RS_MH6V3_RscListBox
{
	type = 5;
	idc = -1;
	style = 16;
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.1;
	font = "RobotoCondensed";
	sizeEx = 0.026;
	rowHeight = 0.032;
	colorText[] = {1,1,1,1};
	colorDisabled[] = {0.5,0.5,0.5,1};
	colorScrollbar[] = {1,1,1,1};
	colorSelect[] = {1,1,1,1};
	colorSelect2[] = {1,1,1,1};
	colorSelectBackground[] = {0.24,0.32,0.24,1};
	colorSelectBackground2[] = {0.24,0.32,0.24,1};
	colorBackground[] = {0.035,0.04,0.038,1};
	period = 1.2;
	maxHistoryDelay = 1;
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	class ListScrollBar
	{
		color[] = {1,1,1,1};
	};
};

class RS_MH6V3_RscEdit
{
	type = 2;
	idc = -1;
	style = 0;
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.04;
	font = "RobotoCondensed";
	sizeEx = 0.032;
	text = "";
	autocomplete = "";
	colorBackground[] = {0.035,0.04,0.038,1};
	colorText[] = {1,1,1,1};
	colorSelection[] = {0.24,0.32,0.24,1};
	canModify = 1;
};

class RS_MH6V3_RscStructuredText
{
	type = 13;
	idc = -1;
	style = 0;
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.05;
	text = "";
	size = 0.026;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#ffffff";
		align = "left";
		valign = "middle";
		shadow = 0;
	};
};

class RS_MH6V3_ACRERadioProgrammer
{
	idd = 86300;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "uiNamespace setVariable ['RS_MH6V3_acreProgrammerDisplay', _this # 0]; [true] call RS_MH6V3_fnc_populateACRERadioProgrammer";
	onUnload = "uiNamespace setVariable ['RS_MH6V3_acreProgrammerDisplay', displayNull]";

	class controlsBackground
	{
		class Border: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.17 * safezoneW + safezoneX;
			y = 0.105 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.75 * safezoneH;
			colorBackground[] = {0.18,0.18,0.18,1};
		};
		class Background: RS_MH6V3_RscText
		{
			idc = 86301;
			x = 0.172 * safezoneW + safezoneX;
			y = 0.107 * safezoneH + safezoneY;
			w = 0.656 * safezoneW;
			h = 0.746 * safezoneH;
			colorBackground[] = {0.015,0.015,0.015,0.98};
		};
		class Header: RS_MH6V3_RscText
		{
			idc = 86302;
			text = "ACRE Radio Management";
			x = 0.172 * safezoneW + safezoneX;
			y = 0.107 * safezoneH + safezoneY;
			w = 0.656 * safezoneW;
			h = 0.055 * safezoneH;
			style = 0;
			sizeEx = 0.037;
			colorBackground[] = {0.025,0.025,0.025,1};
		};
		class HeaderAccent: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.172 * safezoneW + safezoneX;
			y = 0.162 * safezoneH + safezoneY;
			w = 0.656 * safezoneW;
			h = 0.002 * safezoneH;
			colorBackground[] = {0.82,0.43,0.04,1};
		};
		class MyRadiosFrame: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.195 * safezoneW + safezoneX;
			y = 0.235 * safezoneH + safezoneY;
			w = 0.285 * safezoneW;
			h = 0.17 * safezoneH;
			colorBackground[] = {0.28,0.28,0.28,1};
		};
		class OtherRadiosFrame: MyRadiosFrame
		{
			x = 0.52 * safezoneW + safezoneX;
		};
		class MyRacksFrame: MyRadiosFrame
		{
			y = 0.47 * safezoneH + safezoneY;
			h = 0.135 * safezoneH;
		};
		class OtherRacksFrame: MyRacksFrame
		{
			x = 0.52 * safezoneW + safezoneX;
		};
		class TunePanel: RS_MH6V3_RscText
		{
			idc = 86307;
			x = 0.195 * safezoneW + safezoneX;
			y = 0.65 * safezoneH + safezoneY;
			w = 0.61 * safezoneW;
			h = 0.105 * safezoneH;
			colorBackground[] = {0.035,0.035,0.035,1};
		};
	};

	class controls
	{
		class MyHeader: RS_MH6V3_RscText
		{
			idc = 86303;
			text = "Your Inventory Radios";
			x = 0.195 * safezoneW + safezoneX;
			y = 0.195 * safezoneH + safezoneY;
			w = 0.285 * safezoneW;
			h = 0.03 * safezoneH;
			sizeEx = 0.028;
			colorText[] = {0.92,0.92,0.92,1};
		};
		class OtherHeader: MyHeader
		{
			idc = 86304;
			text = "Other Seat Inventory Radios";
			x = 0.52 * safezoneW + safezoneX;
			w = 0.17 * safezoneW;
		};
		class OtherSearch: RS_MH6V3_RscEdit
		{
			idc = 86328;
			text = "";
			x = 0.692 * safezoneW + safezoneX;
			y = 0.195 * safezoneH + safezoneY;
			w = 0.113 * safezoneW;
			h = 0.03 * safezoneH;
			sizeEx = 0.026;
			colorBackground[] = {0.04,0.04,0.04,1};
			colorSelection[] = {0.36,0.22,0.08,1};
			tooltip = "Filter other seat radios";
			onKeyUp = "[false] call RS_MH6V3_fnc_populateACRERadioProgrammer";
		};
		class MyRadiosList: RS_MH6V3_RscListBox
		{
			idc = 86310;
			x = 0.196 * safezoneW + safezoneX;
			y = 0.237 * safezoneH + safezoneY;
			w = 0.283 * safezoneW;
			h = 0.166 * safezoneH;
			colorBackground[] = {0.01,0.01,0.01,1};
			colorSelectBackground[] = {0.36,0.22,0.08,1};
			colorSelectBackground2[] = {0.36,0.22,0.08,1};
		};
		class OtherRadiosList: MyRadiosList
		{
			idc = 86311;
			onLBSelChanged = "uiNamespace setVariable ['RS_MH6V3_acreOtherRadioSource', ctrlIDC (_this # 0)]";
			x = 0.521 * safezoneW + safezoneX;
		};
		class MyRackHeader: MyHeader
		{
			idc = 86305;
			text = "Your Racks";
			y = 0.43 * safezoneH + safezoneY;
		};
		class OtherRackHeader: MyRackHeader
		{
			idc = 86306;
			text = "Other Seat Racks";
			x = 0.52 * safezoneW + safezoneX;
		};
		class MyRackList: RS_MH6V3_RscListBox
		{
			idc = 86312;
			x = 0.196 * safezoneW + safezoneX;
			y = 0.472 * safezoneH + safezoneY;
			w = 0.283 * safezoneW;
			h = 0.131 * safezoneH;
			colorBackground[] = {0.01,0.01,0.01,1};
			colorSelectBackground[] = {0.36,0.22,0.08,1};
			colorSelectBackground2[] = {0.36,0.22,0.08,1};
		};
		class OtherRackList: MyRackList
		{
			idc = 86313;
			onLBSelChanged = "uiNamespace setVariable ['RS_MH6V3_acreOtherRadioSource', ctrlIDC (_this # 0)]";
			x = 0.521 * safezoneW + safezoneX;
		};
		class CopyOtherChannelButton: RS_MH6V3_RscButton
		{
			idc = 86329;
			text = "Copy Channel";
			x = 0.675 * safezoneW + safezoneX;
			y = 0.612 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.032 * safezoneH;
			sizeEx = 0.028;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			tooltip = "Tune the selected target radio to the selected other seat radio channel";
			action = "[] call RS_MH6V3_fnc_tuneACRERadioFromOther";
		};
		class TuneHeader: MyHeader
		{
			idc = 86320;
			text = "Program Selected Radio";
			x = 0.21 * safezoneW + safezoneX;
			y = 0.66 * safezoneH + safezoneY;
			w = 0.56 * safezoneW;
		};
		class TargetLabel: MyHeader
		{
			idc = 86326;
			text = "Radio";
			x = 0.21 * safezoneW + safezoneX;
			y = 0.695 * safezoneH + safezoneY;
			w = 0.04 * safezoneW;
		};
		class ChannelLabel: TargetLabel
		{
			idc = 86327;
			text = "Channel";
			x = 0.65 * safezoneW + safezoneX;
			w = 0.07 * safezoneW;
		};
		class RadioCombo: RS_MH6V3_RscCombo
		{
			idc = 86321;
			onLBSelChanged = "if (((_this # 0) lbValue (_this # 1)) isEqualTo 0) then {missionNamespace setVariable ['RS_MH6V3_acreSelectedRadioId', (_this # 0) lbData (_this # 1)]; missionNamespace setVariable ['RS_MH6V3_acreForceStatus', true]; missionNamespace setVariable ['RS_MH6V3_acreSelectionNonce', (missionNamespace getVariable ['RS_MH6V3_acreSelectionNonce', 0]) + 1]}";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.692 * safezoneH + safezoneY;
			w = 0.385 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0.04,0.04,0.04,1};
			colorSelectBackground[] = {0.36,0.22,0.08,1};
		};
		class ChannelEdit: RS_MH6V3_RscEdit
		{
			idc = 86322;
			text = "1";
			x = 0.7 * safezoneW + safezoneX;
			y = 0.692 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0.04,0.04,0.04,1};
			colorSelection[] = {0.36,0.22,0.08,1};
		};
		class TuneButton: RS_MH6V3_RscButton
		{
			idc = 86323;
			text = "Tune";
			x = 0.75 * safezoneW + safezoneX;
			y = 0.692 * safezoneH + safezoneY;
			w = 0.055 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "[] call RS_MH6V3_fnc_tuneACRERadio";
		};
		class RefreshButton: RS_MH6V3_RscButton
		{
			idc = 86324;
			text = "Refresh";
			x = 0.195 * safezoneW + safezoneX;
			y = 0.785 * safezoneH + safezoneY;
			w = 0.285 * safezoneW;
			h = 0.045 * safezoneH;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "[true] call RS_MH6V3_fnc_populateACRERadioProgrammer";
		};
		class CloseButton: RS_MH6V3_RscButton
		{
			idc = 86325;
			text = "Close";
			x = 0.52 * safezoneW + safezoneX;
			y = 0.785 * safezoneH + safezoneY;
			w = 0.285 * safezoneW;
			h = 0.045 * safezoneH;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "closeDialog 0";
		};
	};
};

class RS_MH6V3_LiveryMenu
{
	idd = 86060;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "uiNamespace setVariable ['RS_MH6V3_liveryDisplay', _this # 0]; [] call RS_MH6V3_fnc_populateLiveryMenu";
	onUnload = "uiNamespace setVariable ['RS_MH6V3_liveryDisplay', displayNull]";

	class controlsBackground
	{
		class Border: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.338 * safezoneW + safezoneX;
			y = 0.318 * safezoneH + safezoneY;
			w = 0.324 * safezoneW;
			h = 0.244 * safezoneH;
			colorBackground[] = {0.18,0.18,0.18,1};
		};
		class Background: RS_MH6V3_RscText
		{
			idc = 86061;
			x = 0.34 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.32 * safezoneW;
			h = 0.24 * safezoneH;
			colorBackground[] = {0.015,0.015,0.015,0.98};
		};
		class Header: RS_MH6V3_RscText
		{
			idc = 86062;
			text = "Livery Change";
			x = 0.34 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.32 * safezoneW;
			h = 0.045 * safezoneH;
			sizeEx = 0.037;
			colorBackground[] = {0.025,0.025,0.025,1};
		};
		class HeaderAccent: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.34 * safezoneW + safezoneX;
			y = 0.365 * safezoneH + safezoneY;
			w = 0.32 * safezoneW;
			h = 0.002 * safezoneH;
			colorBackground[] = {0.82,0.43,0.04,1};
		};
		class LiveryPanel: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.355 * safezoneW + safezoneX;
			y = 0.382 * safezoneH + safezoneY;
			w = 0.29 * safezoneW;
			h = 0.1 * safezoneH;
			colorBackground[] = {0.035,0.035,0.035,1};
		};
	};

	class controls
	{
		class LiveryLabel: RS_MH6V3_RscText
		{
			idc = 86063;
			text = "Available livery";
			x = 0.36 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.28 * safezoneW;
			h = 0.035 * safezoneH;
			sizeEx = 0.028;
			colorText[] = {0.92,0.92,0.92,1};
		};
		class LiveryCombo: RS_MH6V3_RscCombo
		{
			idc = 86064;
			x = 0.36 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.28 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0.04,0.04,0.04,1};
			colorSelectBackground[] = {0.36,0.22,0.08,1};
		};
		class ApplyButton: RS_MH6V3_RscButton
		{
			idc = 86065;
			text = "Apply";
			x = 0.47 * safezoneW + safezoneX;
			y = 0.50 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "[] call RS_MH6V3_fnc_applySelectedLivery";
		};
		class CloseButton: RS_MH6V3_RscButton
		{
			idc = 86066;
			text = "Close";
			x = 0.56 * safezoneW + safezoneX;
			y = 0.50 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "closeDialog 0";
		};
	};
};

class RS_MH6V3_LogisticsManagement
{
	idd = 86500;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "uiNamespace setVariable ['RS_MH6V3_logisticsDisplay', _this # 0]; [] call RS_MH6V3_fnc_populateLogisticsManagement";
	onUnload = "uiNamespace setVariable ['RS_MH6V3_logisticsDisplay', displayNull]; uiNamespace setVariable ['RS_MH6V3_logisticsVehicle', objNull]";

	class controlsBackground
	{
		class Border: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.31 * safezoneW + safezoneX;
			y = 0.185 * safezoneH + safezoneY;
			w = 0.38 * safezoneW;
			h = 0.63 * safezoneH;
			colorBackground[] = {0.18,0.18,0.18,1};
		};
		class Background: RS_MH6V3_RscText
		{
			idc = 86501;
			x = 0.312 * safezoneW + safezoneX;
			y = 0.187 * safezoneH + safezoneY;
			w = 0.376 * safezoneW;
			h = 0.626 * safezoneH;
			colorBackground[] = {0.015,0.015,0.015,0.98};
		};
		class Header: RS_MH6V3_RscText
		{
			idc = 86502;
			text = "MH-6 Logistics Management";
			x = 0.312 * safezoneW + safezoneX;
			y = 0.187 * safezoneH + safezoneY;
			w = 0.335 * safezoneW;
			h = 0.045 * safezoneH;
			sizeEx = 0.033;
			colorBackground[] = {0.025,0.025,0.025,1};
		};
		class HeaderAccent: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.312 * safezoneW + safezoneX;
			y = 0.232 * safezoneH + safezoneY;
			w = 0.376 * safezoneW;
			h = 0.002 * safezoneH;
			colorBackground[] = {0.82,0.43,0.04,1};
		};
		class StatusPanel: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.332 * safezoneW + safezoneX;
			y = 0.255 * safezoneH + safezoneY;
			w = 0.336 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0.035,0.035,0.035,1};
		};
		class LeftPanel: StatusPanel
		{
			y = 0.335 * safezoneH + safezoneY;
			w = 0.158 * safezoneW;
			h = 0.36 * safezoneH;
		};
		class RightPanel: LeftPanel
		{
			x = 0.51 * safezoneW + safezoneX;
		};
	};

	class controls
	{
		class CloseButton: RS_MH6V3_RscButton
		{
			idc = -1;
			text = "x";
			x = 0.654 * safezoneW + safezoneX;
			y = 0.191 * safezoneH + safezoneY;
			w = 0.026 * safezoneW;
			h = 0.034 * safezoneH;
			sizeEx = 0.028;
			colorBackground[] = {0.65,0.05,0.04,1};
			colorBackgroundActive[] = {0.85,0.08,0.06,1};
			colorFocused[] = {0.65,0.05,0.04,1};
			action = "closeDialog 0";
		};
		class Status: RS_MH6V3_RscText
		{
			idc = 86510;
			text = "";
			x = 0.342 * safezoneW + safezoneX;
			y = 0.268 * safezoneH + safezoneY;
			w = 0.316 * safezoneW;
			h = 0.028 * safezoneH;
			sizeEx = 0.027;
			colorText[] = {0.92,0.92,0.92,1};
		};
		class ServiceLabel: RS_MH6V3_RscText
		{
			idc = -1;
			text = "Service";
			x = 0.342 * safezoneW + safezoneX;
			y = 0.35 * safezoneH + safezoneY;
			w = 0.138 * safezoneW;
			h = 0.026 * safezoneH;
			sizeEx = 0.027;
			colorText[] = {0.9,0.9,0.9,1};
		};
		class PackageLabel: ServiceLabel
		{
			text = "Packages";
			x = 0.52 * safezoneW + safezoneX;
		};
		class Drain25Button: RS_MH6V3_RscButton
		{
			idc = 86520;
			text = "Drain Fuel to 25%";
			x = 0.342 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.138 * safezoneW;
			h = 0.038 * safezoneH;
			sizeEx = 0.027;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "['drain25'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class DrainEmptyButton: Drain25Button
		{
			idc = 86521;
			text = "Drain Fuel Empty";
			y = 0.436 * safezoneH + safezoneY;
			action = "['drainempty'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class StopDrainButton: Drain25Button
		{
			idc = 86522;
			text = "Stop Fuel Drain";
			y = 0.482 * safezoneH + safezoneY;
			action = "['stopdrain'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class LiveryButton: Drain25Button
		{
			idc = 86523;
			text = "Change Livery";
			y = 0.528 * safezoneH + safezoneY;
			action = "['livery'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class CameraButton: Drain25Button
		{
			idc = 86524;
			text = "Reset Cameras";
			y = 0.574 * safezoneH + safezoneY;
			action = "['cameras'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class DisassembleButton: RS_MH6V3_RscButton
		{
			idc = 86526;
			text = "Disassemble Rotors";
			x = 0.52 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.138 * safezoneW;
			h = 0.038 * safezoneH;
			sizeEx = 0.027;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "['disassemble'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class AssembleButton: DisassembleButton
		{
			idc = 86527;
			text = "Assemble Rotors";
			y = 0.436 * safezoneH + safezoneY;
			action = "['assemble'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class InstallMh6Button: DisassembleButton
		{
			idc = 86528;
			text = "Install Assault Package";
			y = 0.482 * safezoneH + safezoneY;
			action = "['installmh6'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class InstallAh6Button: DisassembleButton
		{
			idc = 86529;
			text = "Install Attack Package";
			y = 0.528 * safezoneH + safezoneY;
			action = "['installah6'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class RemoveMh6Button: DisassembleButton
		{
			idc = 86530;
			text = "Remove Benches/FRIES";
			y = 0.574 * safezoneH + safezoneY;
			action = "['removemh6'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class RemoveAh6Button: DisassembleButton
		{
			idc = 86531;
			text = "Remove Pylons/Armaments";
			y = 0.62 * safezoneH + safezoneY;
			action = "['removeah6'] call RS_MH6V3_fnc_runLogisticsManagementAction";
		};
		class RefreshButton: RS_MH6V3_RscButton
		{
			idc = -1;
			text = "Refresh";
			x = 0.342 * safezoneW + safezoneX;
			y = 0.765 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.026;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "[] call RS_MH6V3_fnc_populateLogisticsManagement";
		};
		class CloseBottomButton: RefreshButton
		{
			text = "Close";
			x = 0.508 * safezoneW + safezoneX;
			action = "closeDialog 0";
		};
	};
};

class RS_MH6V3_QuickFirePylonMenu
{
	idd = 86400;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "uiNamespace setVariable ['RS_MH6V3_quickFireMenuDisplay', _this # 0]; [] call RS_MH6V3_fnc_populateQuickFirePylonMenu";
	onUnload = "uiNamespace setVariable ['RS_MH6V3_quickFireMenuDisplay', displayNull]; uiNamespace setVariable ['RS_MH6V3_quickFireMenuVehicle', objNull]; uiNamespace setVariable ['RS_MH6V3_quickFireMenuSequence', nil]";

	class controlsBackground
	{
		class Border: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.245 * safezoneW + safezoneX;
			y = 0.195 * safezoneH + safezoneY;
			w = 0.51 * safezoneW;
			h = 0.61 * safezoneH;
			colorBackground[] = {0.18,0.18,0.18,1};
		};
		class Background: RS_MH6V3_RscText
		{
			idc = 86401;
			x = 0.247 * safezoneW + safezoneX;
			y = 0.197 * safezoneH + safezoneY;
			w = 0.506 * safezoneW;
			h = 0.606 * safezoneH;
			colorBackground[] = {0.015,0.015,0.015,0.98};
		};
		class Header: RS_MH6V3_RscText
		{
			idc = 86402;
			text = "Hydra Rocket Ripple Configuration";
			x = 0.247 * safezoneW + safezoneX;
			y = 0.197 * safezoneH + safezoneY;
			w = 0.43 * safezoneW;
			h = 0.045 * safezoneH;
			style = 0;
			sizeEx = 0.033;
			colorBackground[] = {0.025,0.025,0.025,1};
		};
		class HeaderAccent: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.247 * safezoneW + safezoneX;
			y = 0.242 * safezoneH + safezoneY;
			w = 0.506 * safezoneW;
			h = 0.002 * safezoneH;
			colorBackground[] = {0.82,0.43,0.04,1};
		};
		class AvailableFrame: RS_MH6V3_RscText
		{
			idc = -1;
			x = 0.267 * safezoneW + safezoneX;
			y = 0.305 * safezoneH + safezoneY;
			w = 0.202 * safezoneW;
			h = 0.31 * safezoneH;
			colorBackground[] = {0.28,0.28,0.28,1};
		};
		class SequenceFrame: AvailableFrame
		{
			x = 0.531 * safezoneW + safezoneX;
		};
	};

	class controls
	{
		class CloseButton: RS_MH6V3_RscButton
		{
			idc = -1;
			text = "x";
			x = 0.717 * safezoneW + safezoneX;
			y = 0.201 * safezoneH + safezoneY;
			w = 0.028 * safezoneW;
			h = 0.036 * safezoneH;
			sizeEx = 0.029;
			colorBackground[] = {0.65,0.05,0.04,1};
			colorBackgroundActive[] = {0.85,0.08,0.06,1};
			colorFocused[] = {0.65,0.05,0.04,1};
			action = "closeDialog 0";
		};
		class AvailableLabel: RS_MH6V3_RscText
		{
			idc = 86404;
			text = "Available Hydra Pylons";
			x = 0.267 * safezoneW + safezoneX;
			y = 0.265 * safezoneH + safezoneY;
			w = 0.202 * safezoneW;
			h = 0.03 * safezoneH;
			sizeEx = 0.027;
			colorText[] = {0.9,0.9,0.9,1};
		};
		class SequenceLabel: AvailableLabel
		{
			idc = 86405;
			text = "Firing Steps";
			x = 0.531 * safezoneW + safezoneX;
		};
		class AvailableList: RS_MH6V3_RscListBox
		{
			idc = 86410;
			x = 0.268 * safezoneW + safezoneX;
			y = 0.307 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.306 * safezoneH;
			sizeEx = 0.027;
			rowHeight = 0.038;
			colorBackground[] = {0.01,0.01,0.01,1};
			colorSelectBackground[] = {0.36,0.22,0.08,1};
			colorSelectBackground2[] = {0.36,0.22,0.08,1};
		};
		class SequenceList: AvailableList
		{
			idc = 86411;
			x = 0.532 * safezoneW + safezoneX;
		};
		class AddButton: RS_MH6V3_RscButton
		{
			idc = 86413;
			text = "Add >";
			x = 0.477 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.046 * safezoneW;
			h = 0.038 * safezoneH;
			sizeEx = 0.028;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "['add'] call RS_MH6V3_fnc_updateQuickFirePylonMenu";
		};
		class RemoveButton: AddButton
		{
			idc = 86414;
			text = "< Remove";
			y = 0.383 * safezoneH + safezoneY;
			action = "['remove'] call RS_MH6V3_fnc_updateQuickFirePylonMenu";
		};
		class UpButton: AddButton
		{
			idc = 86415;
			text = "Up";
			y = 0.455 * safezoneH + safezoneY;
			action = "['up'] call RS_MH6V3_fnc_updateQuickFirePylonMenu";
		};
		class DownButton: AddButton
		{
			idc = 86416;
			text = "Down";
			y = 0.503 * safezoneH + safezoneY;
			action = "['down'] call RS_MH6V3_fnc_updateQuickFirePylonMenu";
		};
		class ClearButton: AddButton
		{
			idc = 86417;
			text = "Clear";
			y = 0.575 * safezoneH + safezoneY;
			action = "['clear'] call RS_MH6V3_fnc_updateQuickFirePylonMenu";
		};
		class LoadedButton: RS_MH6V3_RscButton
		{
			idc = 86418;
			text = "Use All Loaded";
			x = 0.267 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.038 * safezoneH;
			sizeEx = 0.028;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "['loaded'] call RS_MH6V3_fnc_updateQuickFirePylonMenu";
		};
		class ModeLabel: RS_MH6V3_RscText
		{
			idc = 86406;
			text = "Mode";
			x = 0.531 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.038 * safezoneH;
			sizeEx = 0.027;
		};
		class ModeCombo: RS_MH6V3_RscCombo
		{
			idc = 86412;
			onLBSelChanged = "uiNamespace setVariable ['RS_MH6V3_quickFireMenuMode', (_this # 0) lbData (_this # 1)]";
			x = 0.579 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.154 * safezoneW;
			h = 0.038 * safezoneH;
			sizeEx = 0.028;
			colorBackground[] = {0.04,0.04,0.04,1};
			colorSelectBackground[] = {0.36,0.22,0.08,1};
		};
		class ApplyButton: RS_MH6V3_RscButton
		{
			idc = 86420;
			text = "Apply";
			x = 0.267 * safezoneW + safezoneX;
			y = 0.725 * safezoneH + safezoneY;
			w = 0.225 * safezoneW;
			h = 0.045 * safezoneH;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "[] call RS_MH6V3_fnc_applyQuickFirePylonMenu";
		};
		class CancelButton: RS_MH6V3_RscButton
		{
			idc = 86421;
			text = "Cancel";
			x = 0.508 * safezoneW + safezoneX;
			y = 0.725 * safezoneH + safezoneY;
			w = 0.225 * safezoneW;
			h = 0.045 * safezoneH;
			colorBackground[] = {0.16,0.16,0.16,1};
			colorBackgroundActive[] = {0.36,0.22,0.08,1};
			colorFocused[] = {0.36,0.22,0.08,1};
			action = "closeDialog 0";
		};
	};
};

class RscTitles
{
	class RS_MH6V3_TrueAFMHitters
	{
		idd = -1;
		duration = 999999;
		fadeIn = 1.25;
		fadeOut = 1.5;
		movingEnable = 0;

		class controls
		{
			class Image: RS_MH6V3_RscPicture
			{
				idc = 86600;
				text = "\DEVGRU\RS_MH6V3\TrueAFMHitters.paa";
				x = safeZoneX + safeZoneW * 0.11;
				y = safeZoneY + safeZoneH * 0.11;
				w = safeZoneW * 0.78;
				h = safeZoneH * 0.78;
			};
		};
	};

	class RS_MH6V3_ACRERadioStatus
	{
		idd = -1;
		duration = 1e+011;
		fadeIn = 0;
		fadeOut = 0.2;
		movingEnable = 0;
		onLoad = "uiNamespace setVariable ['RS_MH6V3_acreRadioStatusDisplay', _this # 0]; uiNamespace setVariable ['RS_MH6V3_acreRadioStatusLayout', '']; uiNamespace setVariable ['RS_MH6V3_acreRadioStatusRows', createHashMap]";
		onUnload = "uiNamespace setVariable ['RS_MH6V3_acreRadioStatusDisplay', displayNull]; uiNamespace setVariable ['RS_MH6V3_acreRadioStatusLayout', '']; uiNamespace setVariable ['RS_MH6V3_acreRadioStatusRows', createHashMap]";

		class controls
		{
			class Background: RS_MH6V3_RscText
			{
				idc = 86200;
				x = 0.034 * safezoneW + safezoneX;
				y = 0.535 * safezoneH + safezoneY;
				w = 0.178 * safezoneW;
				h = 0.18 * safezoneH;
				colorBackground[] = {0,0,0,0.72};
			};
			class Title: RS_MH6V3_RscText
			{
				idc = 86201;
				style = 2;
				text = "ACRE STATUS";
				x = 0.039 * safezoneW + safezoneX;
				y = 0.542 * safezoneH + safezoneY;
				w = 0.168 * safezoneW;
				h = 0.026 * safezoneH;
				sizeEx = 0.029;
				colorText[] = {1,1,1,1};
			};
			class ActiveHeader: RS_MH6V3_RscText
			{
				idc = 86202;
				text = "INVENTORY RADIOS";
				style = 2;
				x = 0.039 * safezoneW + safezoneX;
				y = 0.573 * safezoneH + safezoneY;
				w = 0.168 * safezoneW;
				h = 0.02 * safezoneH;
				sizeEx = 0.024;
				colorText[] = {0.78,0.82,0.78,1};
			};
			class ActiveRow: RS_MH6V3_RscStructuredText
			{
				idc = 86203;
				x = 0.039 * safezoneW + safezoneX;
				y = 0.596 * safezoneH + safezoneY;
				w = 0.168 * safezoneW;
				h = 0.022 * safezoneH;
				size = 0.026;
				class Attributes
				{
					font = "RobotoCondensed";
					color = "#ffffff";
					align = "center";
					valign = "middle";
					shadow = 0;
				};
			};
			class InventoryHeader: ActiveHeader
			{
				idc = 86210;
				text = "";
				y = 0.0;
			};
			class InventoryRow1: ActiveRow { idc = 86211; y = 0.621 * safezoneH + safezoneY; };
			class InventoryRow2: ActiveRow { idc = 86212; y = 0.643 * safezoneH + safezoneY; };
			class InventoryRow3: ActiveRow { idc = 86213; y = 0.665 * safezoneH + safezoneY; };
			class InventoryRow4: ActiveRow { idc = 86214; y = 0.687 * safezoneH + safezoneY; };
			class InventoryRow5: ActiveRow { idc = 86215; y = 0.709 * safezoneH + safezoneY; };
			class InventoryRow6: ActiveRow { idc = 86216; y = 0.731 * safezoneH + safezoneY; };
			class RackHeader: ActiveHeader
			{
				idc = 86230;
				text = "RACK RADIOS";
				y = 0.755 * safezoneH + safezoneY;
			};
			class RackRow1: ActiveRow { idc = 86231; y = 0.775 * safezoneH + safezoneY; };
			class RackRow2: ActiveRow { idc = 86232; y = 0.797 * safezoneH + safezoneY; };
			class RackRow3: ActiveRow { idc = 86233; y = 0.819 * safezoneH + safezoneY; };
		};
	};

	class RS_MH6V3_ExternalWeaponControl
	{
		idd = -1;
		duration = 2;
		fadeIn = 0;
		fadeOut = 0.25;
		movingEnable = 0;
		onLoad = "uiNamespace setVariable ['RS_MH6V3_externalWeaponControlDisplay', _this # 0]";
		onUnload = "uiNamespace setVariable ['RS_MH6V3_externalWeaponControlDisplay', displayNull]";

		class controls
		{
			class Background: RS_MH6V3_RscText
			{
				idc = 86101;
				x = 0.805 * safezoneW + safezoneX;
				y = 0.70 * safezoneH + safezoneY;
				w = 0.17 * safezoneW;
				h = 0.105 * safezoneH;
				colorBackground[] = {0,0,0,0.72};
			};
			class Title: RS_MH6V3_RscText
			{
				idc = 86102;
				style = 2;
				text = "EXTERNAL WEAPON CONTROL";
				x = 0.812 * safezoneW + safezoneX;
				y = 0.706 * safezoneH + safezoneY;
				w = 0.156 * safezoneW;
				h = 0.022 * safezoneH;
				sizeEx = 0.026;
				colorText[] = {1,1,1,1};
			};
			class IZLIDLabel: RS_MH6V3_RscText
			{
				idc = 86103;
				text = "IZLID:";
				x = 0.826 * safezoneW + safezoneX;
				y = 0.733 * safezoneH + safezoneY;
				w = 0.06 * safezoneW;
				h = 0.02 * safezoneH;
				sizeEx = 0.024;
				colorText[] = {1,1,1,1};
			};
			class IZLIDStatus: RS_MH6V3_RscText
			{
				idc = 86104;
				text = "OFF";
				x = 0.882 * safezoneW + safezoneX;
				y = 0.733 * safezoneH + safezoneY;
				w = 0.076 * safezoneW;
				h = 0.02 * safezoneH;
				sizeEx = 0.024;
				colorText[] = {1,0.38,0.32,1};
			};
			class ModeLabel: RS_MH6V3_RscText
			{
				idc = 86107;
				text = "MODE:";
				x = 0.826 * safezoneW + safezoneX;
				y = 0.756 * safezoneH + safezoneY;
				w = 0.06 * safezoneW;
				h = 0.02 * safezoneH;
				sizeEx = 0.024;
				colorText[] = {1,1,1,1};
			};
			class ModeStatus: RS_MH6V3_RscText
			{
				idc = 86108;
				text = "IZLID/ILLUM";
				x = 0.882 * safezoneW + safezoneX;
				y = 0.756 * safezoneH + safezoneY;
				w = 0.076 * safezoneW;
				h = 0.02 * safezoneH;
				sizeEx = 0.024;
				colorText[] = {1,0.78,0.32,1};
			};
			class HydraLabel: RS_MH6V3_RscText
			{
				idc = 86105;
				text = "HYDRA RIPPLE:";
				x = 0.826 * safezoneW + safezoneX;
				y = 0.779 * safezoneH + safezoneY;
				w = 0.06 * safezoneW;
				h = 0.02 * safezoneH;
				sizeEx = 0.024;
				colorText[] = {1,1,1,1};
			};
			class HydraStatus: RS_MH6V3_RscText
			{
				idc = 86106;
				text = "NOT-ARMED";
				x = 0.882 * safezoneW + safezoneX;
				y = 0.779 * safezoneH + safezoneY;
				w = 0.076 * safezoneW;
				h = 0.02 * safezoneH;
				sizeEx = 0.024;
				colorText[] = {1,0.38,0.32,1};
			};
		};
	};
};
