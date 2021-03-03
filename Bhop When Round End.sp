#pragma semicolon 1

#define DEBUG

#include <sourcemod>
#include <sdktools>
#include <multicolors>
#include <autoexecconfig>

#pragma newdecls required

ConVar gConVar_TurnOn;
ConVar gConVar_TurnOff;

public Plugin myinfo = 
{
	name = "Bhop When Round End", 
	author = "LanteJoula", 
	description = "Bhop When Round End", 
	version = "1.0", 
	url = "https://steamcommunity.com/id/lantejoula/"
};

public void OnPluginStart()
{
	HookEvent("round_start", OnRoundStart);
	HookEvent("round_end", OnRoundEnd);
	
	LoadTranslations("bhoproundend.phrases");
	
	AutoExecConfig_SetFile("plugin.bhopwhenroundend");
	
	gConVar_TurnOn = AutoExecConfig_CreateConVar("sm_turnon_message", "1", "Enable/Disable the Message when Round Start (1 - Enable | 0 - Disable)", 0, true, 0.0, true, 1.0);
	gConVar_TurnOff = AutoExecConfig_CreateConVar("sm_turnoff_message", "1", "Enable/Disable the Message when Round Finish (1 - Enable | 0 - Disable)", 0, true, 0.0, true, 1.0);
	
	AutoExecConfig_ExecuteFile();
	AutoExecConfig_CleanFile();
}

public Action OnRoundEnd(Event event, const char[] name, bool dontBroadcast)
{
	{
		ServerCommand("sv_cheats 1");
		ServerCommand("sv_autobunnyhopping 1");
		ServerCommand("sv_enablebunnyhopping 1");
		ServerCommand("sv_cheats 0");
		if (!gConVar_TurnOn.BoolValue)
		{
			return;
		}
		else
		{
			CPrintToChatAll("%t %t", "Prefix", "Turn On");
		}
	}
}

public Action OnRoundStart(Event event, const char[] name, bool dontBroadcast)
{
	{
		ServerCommand("sv_cheats 1");
		ServerCommand("sv_autobunnyhopping 0");
		ServerCommand("sv_enablebunnyhopping 0");
		ServerCommand("sv_cheats 0");
		if (!gConVar_TurnOff.BoolValue)
		{
			return;
		}
		else
		{
			CPrintToChatAll("%t %t", "Prefix", "Turn Off");
		}
	}
} 