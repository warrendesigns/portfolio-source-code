/*
    GENERAL INFO ------------------------------------------------------
    AUTHOR:   Steven A. Warren
    DATE:     17/02/2015
    
    This object is responsible for procedurally generating a playable level,
    using a grid based tile map system.

    GRID/SCALE INFO! --------------------------------------------------
    
    1 Tile  = 80x80
    1 Zone  = 2880x1920 (36x24 tiles)
    1 Level = 3 Zones. 

    TILE INFO! --------------------------------------------------------

    Index - Colours ------- Represents
      0     Black:          Unknown
      1     White:          Floor
      2     Light Blue:     n/a
      3     Dark Blue:      Wall Tile
      4     Light Green:    Instance Start
      5     Red:            Instance End
      6     Yellow:         Donut/Loot
*/

//scale
tile_width_res  = 80;
tile_height_res  = 80;
zone_width_res = 2880;
zone_height_res = 1920;
zone_width_cells  = zone_width_res/tile_width_res;
zone_height_cells = zone_height_res/tile_height_res;

//tile values
tile_black = 0;
tile_white = 80;
tile_blue_lt = 160;
tile_blue_dk = 240;
tile_green_lt = 320;
tile_red = 400;
tile_yellow = 480;

//-----initialise mp_grids, 1 per zone-----

//ZONE 1 ID: 0
zone1 = mp_grid_create(0, 0, zone_width_cells, zone_height_cells, tile_width_res, tile_height_res);
mp_grid_add_rectangle(zone1, 0, 0, zone_width_res, zone_height_res);
zone1_rooms = ds_list_create();
instance_create(x, y, obj_zone1);

//ZONE 2 ID: 1
zone2 = mp_grid_create(zone_width_res, 0, zone_width_cells, zone_height_cells, tile_width_res, tile_height_res);
mp_grid_add_rectangle(zone2, zone_width_res, 0, zone_width_res * 2, zone_height_res);
zone2_rooms = ds_list_create();
instance_create(x, y, obj_zone2);

//ZONE 3 ID: 2
zone3 = mp_grid_create(zone_width_res * 2, 0, zone_width_cells, zone_height_cells, tile_width_res, tile_height_res);
mp_grid_add_rectangle(zone3, zone_width_res * 2, 0, zone_width_res * 3, zone_height_res);
zone3_rooms = ds_list_create();
instance_create(x, y, obj_zone3);

//add background tiles, very cheap to draw when using a tileset
for(var i = 0; i <; 3; i ++){
    for(var h = 0; h < zone_height_cells; h ++){
        for(var w = 0; w &lt; zone_width_cells; w ++){
            tile_add(bg_tileset_basic, 0, 0, tile_width_res, tile_height_res, (zone_width_res * i) + (tile_width_res * w), tile_height_res * h, 10);
        }
    }
}

//generates random rooms
for(var i = 0; i < 3; i ++){
    for(var a = 0; a < 30; a ++){
        //random values
        var room_w = irandom_range(4, 6);
        var room_h = irandom_range(4, 5);
        var left = irandom_range(0, zone_width_cells - room_w);
        var top = irandom_range(0, zone_height_cells - room_h);

        //stores room values in obj_room
        var r = instance_create(x, y, obj_room);
        r.left = left;
        r.top = top;
        r.width = room_w;
        r.height = room_h;
        r.right = r.left + r.width - 1;
        r.bottom = r.top + r.height - 1;
        r.center_x = floor(r.left + r.width/2);
        r.center_y = floor(r.top + r.height/2);

	//does room 'r' overlap with any other room?
        test_overlap = scr_room_test_overlap(r, i);
    
        //if no...
        if(!test_overlap){
            //add it to the list
            if(i == 0){
                ds_list_add(zone1_rooms, r);
            }
            if(i == 1){
                ds_list_add(zone2_rooms, r);
            }
            if(i == 2){
                ds_list_add(zone3_rooms, r);
            }

	    //create the room
            scr_room_create(r, i);
        }
        else{
            //if yes, discard
            with(r){instance_destroy();}
        }
    }
}

//connect rooms with corridors
for(var i = 0; i < 3; i ++){
    if(i == 0){
        var cc_list = zone1_rooms;
    }
    if(i == 1){
        var cc_list = zone2_rooms;
    }
    if(i == 2){
        var cc_list = zone3_rooms;
    }
    for(var j = 0; j < ds_list_size(cc_list); j ++){
        do{
            var k = (j + irandom_range(1, ds_list_size(cc_list) - 1)) mod ds_list_size(cc_list);
        }
        until(j != k);

        //picks 2 different rooms in the list, joins them with a corridor.
        scr_corridor_create(cc_list[| j], cc_list[| k], i);
    }
}

//checks each tile in each zone...
for(var i = 0; i < 3; i ++){
    for(var h = 0; h < zone_height_cells; h ++){
        for(var w = 0; w < zone_width_cells; w ++){
            var tt = tile_layer_find(10, (zone_width_res * i) + (w * tile_width_res), h * tile_height_res);
            var tt_l = tile_get_left(tt);
            var tt_x = tile_get_x(tt);
            var tt_y = tile_get_y(tt);

	    //if the tile is unknown (black), and has floor next to it, change that tile to a wall tile
            if(tt_l == 0 && scr_floor_check_adjacent(tt_x, tt_y, i)){
                tile_set_region(tt, tile_blue_dk, 0, tile_width_res, tile_height_res);
            }
        }
    }
}

//for each of the 3 zones, adds an entrance, exit, and pickups (currently donuts)
for(var i = 0; i < 3; i ++){ 
    scr_generate_features(i);    
}