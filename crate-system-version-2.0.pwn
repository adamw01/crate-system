#include <a_samp>
#include <zcmd>
#include <streamer>
#include <a_zones>

// DEFINES //

// COLOR DEFINES //
#define COLOR_RED 0xFF0000FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_BLUE 0x008CBAFF
#define COLOR_YELLOWGREEN 0xADFF2FFF

// CRATE OBJECT ID DEFINE //
#define CRATE_MODEL_ID ( 2358 ) // The crate object ID.

// TIME DEFINE //
#define CRATE_SPAWN_TIME 180000 // Time it takes for the crate to spawn (in milliseconds). Change to your liking. Currently set at 180000 (3 minutes)

// DIALOG DEFINES //
#define DIALOG_CRATE 1 // Crate dialog once opened.
#define DIALOG_CRATE_HELP 2 // Crate dialog help.

new CrateObject; // The crate variable
new Text3D:dynamiccrate3DText; // The 3D Text label variable.

// FORWARDS //
forward CrateMessage(playerid); // Forwarding the message function.

// CRATE SPAWNS //
// Add all your locations below for where you'd like the crate to spawn.
new Float: g_CrateSpawns[][3] =
{   // X          Y        Z
    {821.9344,-1868.2295,6.7148},
    {1281.3082,-2000.0718,58.2978},
    {1800.3622,-2180.2473,13.5547},
    {1647.9771,-2102.3044,13.5547},
    {2018.6150,-2058.0906,13.5469},
    {2233.3159,-2177.2832,13.5469},
    {2764.3826,-2177.3364,11.0968},
    {2756.0122,-2096.0896,12.1435},
    {2898.8792,-1877.8223,2.5593},
    {2740.0654,-1844.7032,10.3125},
    {2530.7998,-1714.7511,13.4838},
    {2420.2715,-1682.8293,13.7668},
    {2329.4768,-1817.1458,13.5469},
    {2155.0942,-1701.1150,15.0859},
    {2209.6052,-1327.2385,23.9844},
    {2209.4834,-1146.2018,27.7969},
    {2290.6980,-1108.1018,37.9766}
};

public OnFilterScriptInit()
{
    print("\n--------------------------------------");
	  print("-- Crate system by FreAkeD loaded! --");
	  print("--------------------------------------\n");
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
	  print("-- Crate system by FreAkeD un-loaded! --");
	  print("--------------------------------------\n");
	
    DestroyDynamicObject(CrateObject); // Destroying the crate object.
	  CrateObject = 0;
	  DestroyDynamic3DTextLabel( Text3D:dynamiccrate3DText ); // Destroying the 3D Text Label.
    return 1;
}

public OnPlayerConnect(playerid)
{
    SetTimer("CrateMessage", CRATE_SPAWN_TIME, false); // Setting the timer for the crate spawn.
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_CRATE)
    {
      if(response) // If they clicked 'Yes' or pressed enter.
      {
        if(listitem == 0) // Combat Shotgun.
			{
				GivePlayerWeapon(playerid, 27, 100);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}Combat Shotgun{FFFFFF}.");
			}
			if(listitem == 1) // MP5.
			{
				GivePlayerWeapon(playerid, 29, 100);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}MP5{FFFFFF}.");
			}
			if(listitem == 2) // Rifle.
			{
				GivePlayerWeapon(playerid, 33, 100);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}Rifle{FFFFFF}.");
			}
			if(listitem == 3) // Desert Eagle.
			{
				GivePlayerWeapon(playerid, 24, 100);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}Desert Eagle{FFFFFF}.");
			}
			if(listitem == 4) // AK-47.
			{
				GivePlayerWeapon(playerid, 30, 100);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped an {FFA500}AK-47{FFFFFF}.");
			}
			if(listitem == 5) // M4.
			{
				GivePlayerWeapon(playerid, 31, 100);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped an {FFA500}M4{FFFFFF}.");
			}
			if(listitem == 6) // SPAS-12.
			{
				GivePlayerWeapon(playerid, 27, 100);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}SPAS-12{FFFFFF}.");
			}
			if(listitem == 7) // Sniper Rifle.
			{
				GivePlayerWeapon(playerid, 34, 100);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}Sniper Rifle{FFFFFF}.");
			}
			if(listitem == 8) // Health.
			{
				SetPlayerHealth(playerid, 100); // Setting players health
				SendClientMessage(playerid, COLOR_BLUE,"You have equiped some Health.");
			}
			if(listitem == 9) // Armour.
			{
				SetPlayerArmour(playerid, 100.0); // Setting players armour
				SendClientMessage(playerid, COLOR_BLUE,"You have equiped some Armour.");
			}
			if(listitem == 10) // Destroy crate.
			{
				DestroyDynamicObject(CrateObject); // Destroying the Crate Object.
				CrateObject = 0;
				DestroyDynamic3DTextLabel( Text3D:dynamiccrate3DText ); // Destroying the Crate 3D Text Label.
				SendClientMessageToAll(COLOR_RED, "[CRATE]: The crate has been destroyed! Another will respawn soon."); // Sending message to all players.
				
				SetTimer("CrateMessage", CRATE_SPAWN_TIME, false); // Resetting the timer for respawn.
			}
      }
        if(!response) // If they clicked 'Canel'.
        {
            DestroyDynamicObject(CrateObject); // Destroying the Crate Object.
			      CrateObject = 0;
			      DestroyDynamic3DTextLabel( Text3D:dynamiccrate3DText ); // Destroying the Crate 3D Text Label.
			      SendClientMessageToAll(COLOR_RED, "[CRATE]: The crate has been destroyed! Another will respawn soon.");// Sending message to all players.

			      SetTimer("CrateMessage", CRATE_SPAWN_TIME, false); // Resetting the timer for respawn.
        }
        return 1; 
    }
	  return 0; // return 0 here!
}

CMD:cratehelp(playerid, params[])// Show information about this system.
{
	ShowPlayerDialog(playerid, DIALOG_CRATE_HELP, DIALOG_STYLE_MSGBOX, "Crate Help",
	"{FFFFFF}/opencrate\t\t{FFA500}Open the crate. (must be near it)\n\
	{FFFFFF}/oc\t\t\t{FFA500}Open the crate. (must be near it)\n\
	{FFFFFF}/cratehelp\t\t{FFA500}Open the crate help dialog\n\n\n\
	{FF0000}NOTE: {FFFFFF}The crate will be destroyed at 24:00 if it has NOT been found. Another will respawn after!",
	"Got It!", ""); // Showing the crate help dialog.
	return 1;
}

CMD:opencrate(playerid, params[])// To open the crate.
{
	if(CrateObject != 0)
	{
	    new rand = random(sizeof(g_CrateSpawns));

		if(IsPlayerInRangeOfPoint(playerid, 5.0, g_CrateSpawns[rand][0], g_CrateSpawns[rand][1], g_CrateSpawns[rand][2])) // Checking the position and range of the player.
		{
		  new name[MAX_PLAYER_NAME], string[128];
			GetPlayerName(playerid, name, MAX_PLAYER_NAME);// Getting players name.
			
			format(string,sizeof(string),"[CRATE]: %s has found the crate. A new one will spawn soon!", name);
			SendClientMessageToAll(COLOR_YELLOWGREEN, string); // Sending the message to all players.
				
		  SendClientMessage(playerid, COLOR_RED, "THE CRATE WILL BE DESTROYED ONCE YOU CLOSE THIS DIALOG!!");// Sending a message to the player.
			ShowPlayerDialog(playerid, DIALOG_CRATE, DIALOG_STYLE_LIST, "Crate Equipment","Shotgun\nMP5\nRifle\nDesert Eagle\nAK-47\nM4\nSPAS-12\nSniper\nHealth\nArmour\nDestroy Crate", "Take", "Destroy"); // Showing the crate dialog.
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "You aren't near the crate!"); // If the player isn't near the crate.
		}
	}
	return 1;
}

CMD:oc(playerid, params[])// Shorter command for /opencrate
{
  return cmd_opencrate(playerid, params);
}

CMD:crate(playerid, params[])// Outputs distance from crate in meters
{
  if(CrateObject != 0)
	{
		new rand = random(sizeof(g_CrateSpawns)),
        Float: CrateDis = GetPlayerDistanceFromPoint(playerid, g_CrateSpawns[rand][0], g_CrateSpawns[rand][1], g_CrateSpawns[rand][2]),
        string[64];

		format(string, sizeof(string), "* You're %.0f meters away from the Lost Crate.", CrateDis);
		SendClientMessage(playerid, COLOR_YELLOWGREEN, string);// Sending message to the player.
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "The crate hasn't been spawned yet. Check again soon.");// Sending message to the player.
	}
	return 1;
}

public CrateMessage(playerid)
{
    new crateloc[30], string[128], rand = random(sizeof(g_CrateSpawns));
    Get2DZone(g_CrateSpawns[rand][0], g_CrateSpawns[rand][1], crateloc, sizeof(crateloc));

    if(CrateObject == 0)
	  {
    	CrateObject = CreateDynamicObject(CRATE_MODEL_ID, g_CrateSpawns[rand][0], g_CrateSpawns[rand][1], g_CrateSpawns[rand][2]-0.4, -1, -1, -1); // Spawning the crate.
    
    	dynamiccrate3DText = CreateDynamic3DTextLabel("Open the Crate by using\n/opencrate or /oc", COLOR_RED, g_CrateSpawns[rand][0], g_CrateSpawns[rand][1], g_CrateSpawns[rand][2]+0.0, 10.0);// Creating a text label

    	format(string,sizeof(string),"[CRATE]: A crate has been spawned at %s. Find it, and you'll be rewarded.", crateloc);
		  SendClientMessage(playerid, COLOR_YELLOWGREEN, string);// Sending message to the player.

    	SendClientMessageToAll(COLOR_YELLOWGREEN, "[CRATE TIP]: Use /crate to see your distance from the crate.");// Sending message to all players.
    	
    	// DESTROYING IF NOT FOUND BY 24:00
    	
    	new hour, minutes;
		  GetPlayerTime(playerid, hour, minutes);
		
		  if(hour == 24 && minutes == 59) // Destroying if the Crate isn't found by certain game time.
		  {
    		SendClientMessageToAll(COLOR_WHITE, "The Weapon Crate has NOT been found. It was eaten by a deer! A new one will respawn soon!");// Sending the message to all players.
    		
    		DestroyDynamicObject(CrateObject); // Destroying the Crate Object.
			  CrateObject = 0;
			  DestroyDynamic3DTextLabel(Text3D:dynamiccrate3DText); // Destroying the Crate 3D Text Label.
				
    		SetTimer("CrateMessage", CRATE_SPAWN_TIME, false); // Resetting the timer for respawn.
		  }
    }
}
