///scr_check_floor_adjacent(xx, yy, check_left, z, zone_id, return_bool);

/*
xx:             |the x coordinate of the tile.
yy:             |the y coordinate of the tile.
check_left:     |the left coordinate of the tile you are checking for.
z:              |the zone object.
zone_id:        |the id of the zone.
return_bool:    |whether you want the script to return a boolean or not.
*/

var xx, yy, check_left, z, zone_id, return_bool, check_x, check_y, check_tile, check_tile_left;

xx = argument0;
yy = argument1;
check_left = argument2;
z = argument3;
zone_id = argument4 + 1;
return_bool = argument5;

//use a switch to determine which adjacent tile we are checking.
//starts from the top left, cycles clockwise through all adjacent tiles.
for(i = 0; i < 8; i++){
    switch(i){
        //top left
        case 0:
            check_x = xx - z.tile_width;
            check_y = yy - z.tile_height;
            break;
        //top center
        case 1:
            check_x = xx;
            check_y = yy - z.tile_height;
            break;
        //top right
        case 2:
            check_x = xx + z.tile_width;
            check_y = yy - z.tile_height;
            break;
        //right
        case 3:
            check_x = xx + z.tile_width;
            check_y = yy;
            break;
        //bottom right
        case 4:
            check_x = xx + z.tile_width;
            check_y = yy + z.tile_height;
            break;
        //bottom center
        case 5:
            check_x = xx;
            check_y = yy + z.tile_height;
            break;
        //bottom left
        case 6:
            check_x = xx - z.tile_width;
            check_y = yy + z.tile_height;
            break;
        //left
        case 7:
            check_x = xx - z.tile_width;
            check_y = yy;
            break;
    }
    
    check_tile = tile_layer_find(10, check_x, check_y);
    if(check_tile == -1){
        continue;
    }
    else{
        check_tile_left = tile_get_left(check_tile);
        if(check_tile_left == check_left){
            if(return_bool){
                return true;
            }
            else{
                //to be implemented
            }
        }
        else{
            continue;
        }
    }
}