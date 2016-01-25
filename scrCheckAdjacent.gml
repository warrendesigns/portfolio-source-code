///scrCheckAdjacent(tileX, tileY, checkLeft, checkMode);
//CALL STACK: |objControl > objZone  
//FUNCTION:   |checkMode:
//            |0 - check all adjacent tiles for a specific type of tile 
//            |1 - checks if the given tile is in a 1 tile wide corridor 
//RETURNS:    |Boolean.

var tileX, tileY, checkLeft, returnType;
tileX = argument0;
tileY = argument1;
checkLeft = argument2;
checkMode = argument3;

//handle exceptions
if(tileX < 0 || tileY < 0 || checkLeft < 0)
{
    show_debug_message("scrCheckAdjacent(tileX, tileY, checkLeft, checkMode): LessThanZeroException: expected values above 0...");
    show_debug_message("[tileX: " + string(tileX) + "]");
    show_debug_message("[tileY: " + string(tileY) + "]");
    show_debug_message("[checkLeft: " + string(checkLeft) + "]");
    return 0;
    //game_end();
}
if(checkMode != 0 && checkMode != 1)
{
    show_debug_message("scrCheckAdjacent(tileX, tileY, checkLeft, checkMode): InvalidReturnTypeException: expected a returnType of 0 or 1...");
    show_debug_message("[checkMode: " + string(checkMode) + "]");
    return 0;
    //game_end();
}

var checkX, checkY, checkTile, checkTileLeft;
for(var i = 0; i < 8; i++)
{
    if(checkMode == 1)
    {
        if(i != 1 && i != 3)
        {
            continue;
        }
    }

    checkX = -1;
    checkY = -1;
    
    //cycles clockwise through all adjacent tiles:
    //  0 1 2
    //  7   3
    //  6 5 4
    
    switch(i)
    {
        //top left
        case 0:
            checkX = tileX - Tile.Width;
            checkY = tileY - Tile.Height;
            break;
        //top center
        case 1:
            checkX = tileX;
            checkY = tileY - Tile.Height;
            break;
        //top right
        case 2:
            checkX = tileX + Tile.Width;
            checkY = tileY - Tile.Height;
            break;
        //right
        case 3:
            checkX = tileX + Tile.Width;
            checkY = tileY;
            break;
        //bottom right
        case 4:
            checkX = tileX + Tile.Width;
            checkY = tileY + Tile.Height;
            break;
        //bottom center
        case 5:
            checkX = tileX;
            checkY = tileY + Tile.Height;
            break;
        //bottom left
        case 6:
            checkX = tileX - Tile.Width;
            checkY = tileY + Tile.Height;
            break;
        //left
        case 7:
            checkX = tileX - Tile.Width;
            checkY = tileY;
            break;
    }
    
    checkTile = tile_layer_find(Tile.Depth, checkX, checkY);
    if(checkTile == -1)
    {
        continue;
    }
    else
    {
        checkTileLeft = tile_get_left(checkTile);
        if(checkTileLeft == checkLeft)
        {
            if(checkMode == 0)
            {
                return true;
            }
            else
            {
                switch(i)
                {
                    //code from 5
                    case 1:
                        checkX = tileX;
                        checkY = tileY + Tile.Height;
                        break;
                    //code from 7
                    case 3:
                        checkX = tileX - Tile.Width;
                        checkY = tileY;
                        break;
                }
                
                checkTile = tile_layer_find(Tile.Depth, checkX, checkY); 
                if(checkTile == -1)
                {
                    continue;
                }
                else
                {
                    checkTileLeft = tile_get_left(checkTile);
                    if(checkTileLeft == checkLeft)
                    {
                        return i;
                    }
                }
            }
        }
    }
}
