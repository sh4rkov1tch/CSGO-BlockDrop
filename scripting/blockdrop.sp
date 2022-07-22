#include <cstrike> 
#include <sourcemod>
#include <sdkhooks>
#include <keyvalues>

bool GetPrettyWeaponName(const char[] rawName, char[] prettyName, int maxLength){
    KeyValues kv = new KeyValues("Weapons");
    kv.ImportFromFile("addons/sourcemod/data/Text/weapons.txt");
    
    if(!kv.JumpToKey("Weapons")){
        delete kv;
        return false;
    }
    
    kv.GetString(rawName, prettyName, maxLength);
    delete kv;

    return true;
}

public Action CS_OnCSWeaponDrop(int client, int weaponIndex, bool donated)
{
    char strWeaponRaw[32] = "";
    char strWeaponPretty[32] = "";

    GetClientWeapon(client, strWeaponRaw, 32);
    GetPrettyWeaponName(strWeaponRaw, strWeaponPretty, 32);
    PrintCenterText(client, "You cannot drop your %s !", strWeaponPretty);
    return Plugin_Handled;
}  
