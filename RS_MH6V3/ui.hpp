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

class RS_MH6V3_LiveryMenu
{
	idd = 86060;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "uiNamespace setVariable ['RS_MH6V3_liveryDisplay', _this # 0]; [] call RS_MH6V3_fnc_populateLiveryMenu";
	onUnload = "uiNamespace setVariable ['RS_MH6V3_liveryDisplay', displayNull]";

	class controlsBackground
	{
		class Background: RS_MH6V3_RscText
		{
			idc = 86061;
			x = 0.34 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.32 * safezoneW;
			h = 0.24 * safezoneH;
			colorBackground[] = {0.04,0.045,0.04,0.94};
		};
		class Header: RS_MH6V3_RscText
		{
			idc = 86062;
			text = "Little Bird Livery";
			x = 0.34 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.32 * safezoneW;
			h = 0.045 * safezoneH;
			sizeEx = 0.04;
			colorBackground[] = {0.14,0.19,0.15,1};
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
		};
		class LiveryCombo: RS_MH6V3_RscCombo
		{
			idc = 86064;
			x = 0.36 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.28 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class ApplyButton: RS_MH6V3_RscButton
		{
			idc = 86065;
			text = "Apply";
			x = 0.47 * safezoneW + safezoneX;
			y = 0.50 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.04 * safezoneH;
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
			action = "closeDialog 0";
		};
	};
};

class RscTitles
{
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
				text = "HYDRA QUICK FIRE:";
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
