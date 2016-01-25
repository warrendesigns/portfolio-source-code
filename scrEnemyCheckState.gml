#define scrEnemyCheckState
///scrEnemyCheckState()
//CALL STACK:   |objEnemyParent
//FUNCTION:     |determine what actions the enemy should be taking, based on the current game state
//RETURNS:      |N/A

var state = -1;
var dist = distance_to_object(objPlayer)
if(dist <= objPlayer.light.rad && scrEnemyCheckVision(10, dist))
{
    if(isBatteryPowered)
    {
        if(enemyState == 0)
        {
            if(chargeLevel < maxChargeLevel)
            {
                state = 0;
            }
            else
            {
                state = 2;
            }
        }
        else
        {
            if(chargeLevel > 0)
            {
                state = 2;
            }
            else
            {
                state = 0;
            }
        }
    }
    else
    {
        state = 2;
    }
}
else
{
    if(isBatteryPowered)
    {
        state = 0;
    }
    else
    {
        state = 1;
    }
}

if(state != enemyState)
{
    if(enemyState == 2)
    {
        scrEnemyAlert();
        scrEnemyUpdateLighting(state);
        enemyState = state;
        return 0;
    }
    else
    {
        scrEnemyUpdateLighting(state);
        path_end();
        with(light){path_end();}
        moving = false;
        enemyState = state;
    }
}
else
{
    if(moving)
    {
        return 0;
    }
}

switch(enemyState)
{
    case 0:scrEnemyCharge();break;
    case 1:scrEnemyPatrol();break;
    case 2:scrEnemyAlert();break;
}

#define scrEnemyCheckVision
///scrEnemyCheckVision(interval, distance)
//CALL STACK:   |objEnemyParent > scrEnemyCheckState
//FUNCTION:     |determines if the enemy instance /player have vision of each other: smaller intervals == more checks; higher precision at the cost of performance.
//RETURNS:      |Boolean: True or False;

var checkInterval, checkNumber, vision;
checkInterval = argument0;
checkNumber = round(argument1/checkInterval);

for(var i = 1; i <= checkNumber; i ++)
{
    //gets a point on the line between this enemy and the player on a percentage basis
    var point, linePointX, linePointY, tileLeft;
    point = (1/checkNumber) * i;    
    linePointX = x + lengthdir_x(distance_to_object(objPlayer) * point, point_direction(x, y, objPlayer.x, objPlayer.y));
    linePointY = y + lengthdir_y(distance_to_object(objPlayer) * point, point_direction(x, y, objPlayer.x, objPlayer.y));   
    
    //does the tile impede vision?
    if(tile_get_left(tile_layer_find(Tile.Depth, linePointX, linePointY)) == TileLeft.Wall)
    {
        return false;
    }
}
return true;

#define scrEnemyCharge
///scrEnemyCharge()
//CALL STACK:   |objEnemyParent > scrEnemyCheckState
//FUNCTION:     |battery powered enemys become dormant and recharge; until full.
//RETURNS:      |N/A

//recharge
if(chargeLevel < maxChargeLevel)
{
    chargeLevel ++;
    
    if(chargeLevel > maxChargeLevel)
    {
        chargeLevel = maxChargeLevel;
    }
}

#define scrEnemyPatrol
///scrEnemyPatrol()
//CALL STACK:   |objEnemyParent > scrEnemyCheckState
//FUNCTION:     |non battery powered enemys patrol the zone
//RETURNS:      |N/A

//get a new room to partol to.
previousRoom = currentRoom;
currentRoom = nextRoom;

while(nextRoom == currentRoom || nextRoom == previousRoom)
{
    nextRoom = irandom_range(0, ds_list_size(zone[ID].Rooms) - 1);
}

//calculate world coords
var patrolRoom, patrolX, patrolY;
patrolRoom = zone[ID].Rooms[| nextRoom];
patrolX = (Tile.Width * ID) + ((irandom_range(patrolRoom.left, patrolRoom.right) * Tile.Width) div Tile.Width * Tile.Width) + sprite_xoffset;
patrolY = ((irandom_range(patrolRoom.top, patrolRoom.bottom) * Tile.Height) div Tile.Height * Tile.Height) + sprite_yoffset;


if(!mp_grid_path(zone[ID].Grid, path, x, y, patrolX, patrolY, diag))
{
    //show_debug_message("enemy patrol path unacceptable.");
}
else
{
    pathStartX = x;
    pathStartY = y;
    mp_grid_path(zone[ID].Grid, path, x, y, patrolX, patrolY, diag);
    path_start(path, spd, 0, true);
    with(light){path_start(other.path, other.spd, 0, true);}
    moving = true;
}


#define scrEnemyAlert
///scrEnemyAlert()
//CALL STACK:   |objEnemyParent > scrEnemyCheckState
//FUNCTION:     |all enemy types can be alerted; pursue the player until vision is lost.
//RETURNS:      |N/A

playerTileX = (objPlayer.x div Tile.Width * Tile.Width) + objPlayer.sprite_xoffset;
playerTileY = (objPlayer.y div Tile.Height * Tile.Height) + objPlayer.sprite_yoffset;

if(point_distance(x, y, playerTileX, playerTileY) < light.rad * 2)
{
    if(!mp_grid_path(zone[ID].Grid, path, x, y, playerTileX, playerTileY, diag))
    {
        //show_debug_message("enemy cant reach player.");
    }
    else
    {
        pathStartX = x;
        pathStartY = y;
        mp_grid_path(zone[ID].Grid, path, x, y, playerTileX, playerTileY, diag);
        path_start(path, spd, 0, true);
        with(light){path_start(other.path, other.spd, 0, true);}
        moving = true;
    }
}

#define scrEnemyUpdateLighting
///scrEnemyUpdateLighting(state);
//CALL STACK:   |objEnemyParent > scrEnemyCheckState
//FUNCTION:     |updates enemy lighting
//RETURNS:      |N/A

switch(argument0)
{
    case 0: 
        if(instance_exists(light))
        {
            with(light)
            {
                if(surface_exists(surfaceLight))
                {
                    surface_free(surfaceLight);
                }
                instance_destroy();
            }
        }
        break;
    case 1:
        if(instance_exists(light))
        {
            light.rad = 200;
            light.col = c_yellow;
        }
        break;
    case 2:
        if(hasTimeScroll)
        {
            var col = c_blue;
        }
        else
        {
            var col = c_red;
        }
        
        if(instance_exists(light))
        {
            light.rad = 200;
            light.col = col;
        }
        else
        {
            light = instance_create(x, y, objLight);
            with(light)
            {
                rad = 200;
                alpha = 1;
                isFov = true;
                surfaceLight = surface_create(rad * 2, rad * 2);
            }
            light.col = col;
        }
        break;
}