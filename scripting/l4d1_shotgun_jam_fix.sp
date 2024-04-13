#include <sourcemod>
#include <sdktools_functions>


public Plugin myinfo =
{
	name = "L4D1 Shotgun Jam Fix",
	author = "Skeletor, 3ipKa*",
	description = "Fixes the player not being able to shoot or reload shotguns if one tried to revive a teammate during the weapon reload cycle",
	version = "1.0"
}

public OnPluginStart()
{
	HookEvent("revive_begin", Event_ReviveBegin);
}

void Event_ReviveBegin(Event event, const char[] eventName, bool dontBroadcast)
{
	int reviver = GetClientOfUserId(event.GetInt("userid"));
	if (!IsValidClient(reviver))
	{
		return;
	}
	
	int shotgun = GetPlayerWeaponSlot(reviver, 0);
	if (!IsShotgunAndReloading(shotgun))
	{
		return;
	}
	
	float gameTime = GetGameTime();
	SetEntPropFloat(reviver, Prop_Send, "m_flNextAttack", gameTime);
	SetEntPropFloat(shotgun, Prop_Send, "m_flNextPrimaryAttack", gameTime);
}

bool IsValidClient(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client);
}

bool IsShotgunAndReloading(int entity)
{
	if (!IsValidEntity(entity) || entity == -1)
	{
		return false;
	}
	
	char classname[64];
	GetEdictClassname(entity, classname, sizeof(classname));
	
	if (!(StrEqual(classname, "weapon_autoshotgun", false) || StrEqual(classname, "weapon_pumpshotgun", false)))
	{
		return false;
	}
	
	return GetEntProp(entity, Prop_Send, "m_bInReload") > 0;
}