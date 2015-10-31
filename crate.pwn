#include <a_samp>
#include <ZCMD>
#include <streamer>

// DEFINES //

// COLOR DEFINES //
#define COLOR_RED 0xFF0000FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_BLUE 0x008CBAFF

// CRATE OBJECT ID DEFINE //
#define CRATE_MODEL_ID ( 2358 ) // The crate object ID.

// TIME DEFINE //
#define TIME 180000 // Time it takes for the crate to spawn (in milliseconds). Change to your liking. Current set at 180000 (3 minutes)

// DIALOG DEFINES //
#define DIALOG_CRATE 1 // Crate dialog once opened.
#define DIALOG_CRATE_HELP 2 // Crate dialog help.

new CrateObject; // The crate variable
new Text3D:dynamiccrate3DText; // The 3D Text label variable.

// FORWARDS //
forward message(playerid); // Forwarding the message function.

// CRATE SPAWNS //
// Add all your locations below for where you'd like the crate to spawn.
new Float: g_CrateSpawns[][3] =
{   // X          Y        Z
    {792.2041,-1866.0940,5.5202} // Santa Maria Beach (LOS SANTOS)
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
    SetTimer("message", TIME, false); // Setting the timer for the crate spawn.
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
				GivePlayerWeapon(playerid, 27, 32);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}Combat Shotgun{FFFFFF}.");
			}
			if(listitem == 1) // MP5.
			{
				GivePlayerWeapon(playerid, 29, 32);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}MP5{FFFFFF}.");
			}
			if(listitem == 2) // Rifle.
			{
				GivePlayerWeapon(playerid, 33, 32);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}Rifle{FFFFFF}.");
			}
			if(listitem == 3) // Desert Eagle.
			{
				GivePlayerWeapon(playerid, 24, 32);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}Desert Eagle{FFFFFF}.");
			}
			if(listitem == 4) // AK-47.
			{
				GivePlayerWeapon(playerid, 30, 32);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped an {FFA500}AK-47{FFFFFF}.");
			}
			if(listitem == 5) // M4.
			{
				GivePlayerWeapon(playerid, 31, 32);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped an {FFA500}M4{FFFFFF}.");
			}
			if(listitem == 6) // SPAS-12.
			{
				GivePlayerWeapon(playerid, 27, 32);
				SendClientMessage(playerid, COLOR_WHITE,"You have equiped a {FFA500}SPAS-12{FFFFFF}.");
			}
			if(listitem == 7) // Sniper Rifle.
			{
				GivePlayerWeapon(playerid, 34, 32);
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
				RemovePlayerMapIcon(playerid, 1); // Removing the Map Icon
				SendClientMessageToAll(COLOR_RED, "Crate: The crate has been destroyed! Another will respawn soon.");
				
				SetTimer("message", TIME, false); // Resetting the timer for respawn.
			}
        }
        if(!response) // If they clicked 'Canel'.
        {
            DestroyDynamicObject(CrateObject); // Destroying the Crate Object.
			CrateObject = 0;
			DestroyDynamic3DTextLabel( Text3D:dynamiccrate3DText ); // Destroying the Crate 3D Text Label.
			RemovePlayerMapIcon(playerid, 1); // Removing the Map Icon
			SendClientMessageToAll(COLOR_RED, "Crate: The crate has been destroyed! Another will respawn soon.");

			SetTimer("message", TIME, false); // Resetting the timer for respawn.
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
			
			format(string,sizeof(string),"{33AA33}CRATE: {FFFFFF}%s has found the crate. A new one will spawn soon!", name);
			SendClientMessageToAll(COLOR_WHITE, string); // Sending the message to all players.
				
		    SendClientMessage(playerid, COLOR_RED, "THE CRATE WILL BE DESTROYED ONCE YOU CLOSE THIS DIALOG!!");
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

public message(playerid)
{
    new rand = random(sizeof(g_CrateSpawns));

    if(CrateObject == 0)
	{
    	CrateObject = CreateDynamicObject(CRATE_MODEL_ID, g_CrateSpawns[rand][0], g_CrateSpawns[rand][1], g_CrateSpawns[rand][2]-0.4, -1, -1, -1); // Spawning the crate.

    	dynamiccrate3DText = CreateDynamic3DTextLabel("Open The Crate By Using\n/opencrate or /oc", COLOR_RED, g_CrateSpawns[rand][0], g_CrateSpawns[rand][1], g_CrateSpawns[rand][2]+0.0, 8.0); // Creating the 3D Text Label.
    
    	SetPlayerMapIcon(playerid, 1, g_CrateSpawns[rand][0], g_CrateSpawns[rand][1], g_CrateSpawns[rand][2], 6, 0, MAPICON_GLOBAL); // Creating the Map Icon.
    
    	SendClientMessageToAll(COLOR_WHITE, "{33AA33}CRATE: {FFFFFF}A crate has been spawned! Find it, and you'll be rewarded.");// Sending the message to all players.
    	SendClientMessageToAll(COLOR_WHITE, "{33AA33}TIP: {FFFFFF}Check your minimap to see where the crate is!");// Sending the message to all players.
    	
    	// DESTROYING IF NOT FOUND BY 24:00
    	
    	new hour, minutes;
		GetPlayerTime(playerid, hour, minutes);
		
		if(hour == 24 && minutes == 00) // Destroying if the Crate isn't found by certain game time.
		{
    		SendClientMessageToAll(COLOR_WHITE, "The Weapon Crate has NOT been found. It was eaten by a deer! A new one will respawn soon!");// Sending the message to all players.
    		
    		DestroyDynamicObject(CrateObject); // Destroying the Crate Object.
			CrateObject = 0;
			DestroyDynamic3DTextLabel(Text3D:dynamiccrate3DText); // Destroying the Crate 3D Text Label.
			RemovePlayerMapIcon(playerid, 1);
				
    		SetTimer("message", TIME, false); // Resetting the timer for respawn.
		}
    }
}
