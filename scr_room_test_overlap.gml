#define scr_room_test_overlap
///scr_room_test_overlap(room, zone_index)

var cur_room, zone, rooms;

cur_room = argument0;
zone_index = argument1;

if(instance_exists(obj_architect)){
    if(zone_index == 0){
        rooms = obj_architect.zone1_rooms;
    }
    if(zone_index == 1){
        rooms = obj_architect.zone2_rooms;
    }
    if(zone_index == 2){
        rooms = obj_architect.zone3_rooms;
    }
}

//checks this room against every other room in the zone/list
for(var i = 0; i < ds_list_size(rooms); i ++){
    var other_r = ds_list_find_value(rooms, i);
    var overlap = true;
    
    //check each side of the room for overlap
    if(cur_room.left > other_r.right){
        overlap = false;
    }
    if(cur_room.top > other_r.bottom){
        overlap = false;
    }
    if(cur_room.right < other_r.left){
        overlap = false;
    }
    if(cur_room.bottom < other_r.top){
        overlap = false;
    }
    //if overlap is still true, return; discard room.
    if(overlap){
        show_debug_message("overlap - " + string(overlap));
        return overlap;
    }
}

#define scr_room_create
///scr_room_create(room, zone_index)

var room_info, zone_index;

room_info = argument0;
zone_index = argument1;

//generates the room
for(var w = 0; w < room_info.width; w ++){
    for(var h = 0; h < room_info.height; h ++){

	//if the current tile being placed is the outer rim of the room, make it a wall tile
        if(w == 0 || w == room_info.width - 1 || h == 0 || h == room_info.height - 1){
            //show_debug_message("assigning room chunk: WALL");
            if(instance_number(obj_architect) > 0){
                var tile = tile_layer_find(10, (obj_architect.zone_width_res * zone_index) + ((room_info.left + w) * obj_architect.tile_width_res), (room_info.top + h) * obj_architect.tile_height_res);
                tile_set_region(tile, obj_architect.tile_blue_dk, 0, obj_architect.tile_width_res, obj_architect.tile_height_res);
            }
        }

	//otherwise, make it a floor tile.
        else{
            //show_debug_message("assigning room chunk: FLOOR");
            if(instance_number(obj_architect) > 0){
                var tile = tile_layer_find(10, (obj_architect.zone_width_res * zone_index) + ((room_info.left + w) * obj_architect.tile_width_res), ((room_info.top + h) * obj_architect.tile_height_res));
                tile_set_region(tile, obj_architect.tile_white, 0, obj_architect.tile_width_res, obj_architect.tile_height_res);
                
		//this code 'clears' the current tiles cell, enabling player movement only on floor tiles.
		if(zone_index == 0){
                    mp_grid_clear_cell(zone1, room_info.left + w, room_info.top + h);
                }
                if(zone_index == 1){
                    mp_grid_clear_cell(zone2, room_info.left + w, room_info.top + h);
                }
                if(zone_index == 2){
                    mp_grid_clear_cell(zone3, room_info.left + w, room_info.top + h);
                }
            }
        }
    }
}