/*
     //SETUP MEMORY LEVEL
     The following code is executed in the create event of obj_memory, which is functionally 
     the same as the Start function of a standard C# script.
*/

//init
game_cur_note = 0;
player_cur_note = 0;
light_count = 0;

//start timer
level_start_timer = 30;
timer_on = true;

//booleans
play_tune_start = false;
note_played = false;

game_play_red = false;
game_play_blue = false;
game_play_green = false;
game_play_white = false;

player_play_red = false;
player_play_blue = false;
player_play_green = false;
player_play_white = false;

memory_won = false;
won_sound_played = false;
lights_on = false;
memory_lost = false;
lost_ran = false;
pets_fall = false;

//array
player_tune[0] = 0;

//--SPAWN OBJECTS--
//setting
lights = instance_create(room_width/2, room_height/2, obj_lights);
holes = instance_create(room_width/2, room_height, obj_btnholes);
overlay = instance_create(room_width/2, room_height/2, obj_bg_overlay);
lights.depth = -1;
holes.depth = -1;
overlay.depth = 0;

//traps
traps_over = instance_create(room_width/2, room_height, obj_overlay_traps);
instance_create(119, 490, anim_trapdoor);                 //red
instance_create(360, 490, anim_trapdoor);                 //blue
instance_create(room_width/2 + 121, 490, anim_trapdoor);  //green
instance_create(room_width - 120, 490, anim_trapdoor);    //white
traps_over.depth = 3;
anim_trapdoor.depth = 3;

//pets
rock_idle = instance_create(room_width/2 + 121, 490, anim_rockpet_idle);
rock_idle.depth = 2;

fire_idle = instance_create(119, 490, anim_firepet_idle);
fire_idle.depth = 2;

water_idle = instance_create(360, 490, anim_waterpet_idle);
water_idle.depth = 2;

bird_idle = instance_create(room_width - 120, 490, anim_birdpet_idle);
bird_idle.depth = 2;


//buttons
btn_red = instance_create(119, 590, obj_btn_red);
btn_red.depth = -2;

btn_blue = instance_create(360, 590, obj_btn_blue);
btn_blue.depth = -2;

btn_green = instance_create(room_width/2 + 121, 590, obj_btn_green);
btn_green.depth = -2;

btn_white = instance_create(room_width - 120, 590, obj_btn_white);
btn_white.depth = -2;

//red light
light_red = instance_create(119, 472, anim_lights_bg_red);
bulb_red = instance_create(119, room_height/2, anim_lights_bulb_red);
red_overlay = instance_create(119, 472, obj_overlay_lights_bg);
light_red.depth = 4;
bulb_red.depth = -2;
red_overlay.depth = 5;

//blue light
light_blue = instance_create(360, 472, anim_lights_bg_blue);
bulb_blue = instance_create(360, room_height/2, anim_lights_bulb_blue);
blue_overlay = instance_create(360, 472, obj_overlay_lights_bg);
light_blue.depth = 4;
bulb_blue.depth = -2;
blue_overlay.depth = 5;

//green light
light_green = instance_create(room_width/2 + 121, 472, anim_lights_bg_green);
bulb_green = instance_create(room_width/2 + 121, room_height/2, anim_lights_bulb_green);
green_overlay = instance_create(room_width/2 + 121, 472, obj_overlay_lights_bg);
light_green.depth = 4;
bulb_green.depth = -2;
green_overlay.depth = 5;

//white light
light_white = instance_create(room_width - 120, 472, anim_lights_bg_white);
bulb_white = instance_create(room_width - 120, room_height/2, anim_lights_bulb_white);
white_overlay = instance_create(room_width - 120, 472, obj_overlay_lights_bg);
light_white.depth = 4;
bulb_white.depth = -2;
white_overlay.depth = 5;

//difficulty specific settings
//as difficulty goes up, tune gets longer.
if(obj_control.difficulty == 0){
    //length of the array
    note_count = 4;

    show_debug_message("initialising array(game)...");
    for(i = 3; i &gt; -1; i -= 1){
        game_tune[i] = 0;
        show_debug_message(string(i));
    }
    
    show_debug_message("populating array...");
    for(i = 0; i &lt; 4; i += 1){
        game_tune[i] = choose("r", "b", "g", "w");
        show_debug_message("game_tune[" + string(i) + "] = " + string(game_tune[i]));
    }
}
if(obj_control.difficulty == 1){
    //length of the array
    note_count = 5;

    show_debug_message("initialising array(game)...");
    for(i = 4; i &gt; -1; i -= 1){
        game_tune[i] = 0;
        show_debug_message(string(i));
    }
    
    show_debug_message("populating array...");
    for(i = 0; i &lt; 5; i += 1){
        game_tune[i] = choose("r", "b", "g", "w");
        show_debug_message("tune[" + string(i) + "] = " + string(game_tune[i]));
    }
}
if(obj_control.difficulty == 2){
    //length of the array
    note_count = 6;

    show_debug_message("initialising array(game)...");
    for(i = 5; i &gt; -1; i -= 1){
        game_tune[i] = 0;
        show_debug_message(string(i));
    }
    
    show_debug_message("populating array...");
    for(i = 0; i &lt; 6; i += 1){
        game_tune[i] = choose("r", "b", "g", "w");
        show_debug_message("tune[" + string(i) + "] = " + string(game_tune[i]));
    }
}
if(obj_control.difficulty == 3){
    //length of the array
    note_count = 7;

    show_debug_message("initialising array(game)...");
    for(i = 6; i &gt; -1; i -= 1){
        game_tune[i] = 0;
        show_debug_message(string(i));
    }
    
    show_debug_message("populating array...");
    for(i = 0; i &lt; 7; i += 1){
        game_tune[i] = choose("r", "b", "g", "w");
        show_debug_message("tune[" + string(i) + "] = " + string(game_tune[i]));
    }
}
if(obj_control.difficulty >= 4){
    //length of the array
    note_count = 8;

    show_debug_message("initialising array(game)...");
    for(i = 7; i &gt; -1; i -= 1){
        game_tune[i] = 0;
        show_debug_message(string(i));
    }
    
    show_debug_message("populating array...");
    for(i = 0; i &lt; 8; i += 1){
        game_tune[i] = choose("r", "b", "g", "w");
        show_debug_message("tune[" + string(i) + "] = " + string(game_tune[i]));
    }
}

----------------------------------------------------------------------------------------
/*
     //UPDATE MEMORY LEVEL
     The following code is ran in the Step event of obj_memory, which is functionally the same
     as the Update function of a standard C# script.
*/


//timer before level begins
if(level_start_timer > 0 && timer_on){
    level_start_timer --;
}
if(level_start_timer <= 0 && timer_on){
    level_start_timer = 0;
    play_tune_start = true;
    timer_on = false;
}

//when the level starts; plays the tune which the player must remember.
if(play_tune_start){
    if(!note_played && game_cur_note < note_count){

	//reads the value from the current element of the array 'game_tune', in order, and plays the note.
        if(game_tune[game_cur_note] = "r"){
            game_play_red = true;
        }
        if(game_tune[game_cur_note] = "b"){
            game_play_blue = true; 
        }
        if(game_tune[game_cur_note] = "g"){
            game_play_green = true;
        }
        if(game_tune[game_cur_note] = "w"){
            game_play_white = true;
        }
    } 
}

//once the tune is played, stop playing notes.
if(game_cur_note >= note_count){
    play_tune_start = false;
}

//Play red note
if(game_play_red && !note_played){
    //lights
    light_red.image_speed = 1;
    light_red.visible = true;
    bulb_red.image_speed = 1;
    bulb_red.visible = true;
    //sound
    audio_play_sound(snd_memory_note_red, 1, 0);
    note_played = true;
}

//Play blue note
if(game_play_blue && !note_played){
    //lights
    light_blue.image_speed = 1;
    light_blue.visible = true;
    bulb_blue.image_speed = 1;
    bulb_blue.visible = true;
    //sound
    audio_play_sound(snd_memory_note_blue, 1, 0);
    note_played = true;
}


//Play green note
if(game_play_green && !note_played){
    //lights
    light_green.image_speed = 1;
    light_green.visible = true;
    bulb_green.image_speed = 1;
    bulb_green.visible = true;
    //sound
    audio_play_sound(snd_memory_note_green, 1, 0);
    note_played = true;
}

//Play white note
if(game_play_white && !note_played){
    //lights
    light_white.image_speed = 1;
    light_white.visible = true;
    bulb_white.image_speed = 1;
    bulb_white.visible = true;
    //sound
    audio_play_sound(snd_memory_note_white, 1, 0);
    note_played = true;
}


//if the player clicks, and the level is in playable condition (the tune has played, and the level is not already won or lost)
if(mouse_check_button_released(mb_left) && !play_tune_start && !timer_on && !pets_fall && !won_sound_played){
    
    //if they clicked on an object instance
    if(position_meeting(mouse_x, mouse_y, all)){
	//store the instance in the variable 'inst' and do something based on what it is.
        inst = instance_position(mouse_x, mouse_y, all);
        
	//play red note.
        if(inst == btn_red){
            player_play_red = true;
            //button
            btn_red.image_speed = 0.8;
            btn_red_allow_press = false;
            
            //lights
            light_red.image_speed = 1;
            light_red.image_index = 0;
            light_red.visible = true;
            bulb_red.image_speed = 1;
            bulb_red.image_index = 0;
            bulb_red.visible = true;
            
            //sound
            audio_play_sound(snd_memory_note_red, 1, 0); 

            note_played = true;
            
            //store note played
            player_tune[player_cur_note] = "r";
            show_debug_message("player_tune[" + string(player_cur_note) + "] = " + string(player_tune[player_cur_note]));
            
            //compare arrays
            if(player_tune[player_cur_note] != game_tune[player_cur_note]){
                memory_lost = true;
            }
            else{
                player_cur_note ++;
            }
        }

	//play blue note.
        if(inst == btn_blue){
            player_play_blue = true;
            //button
            btn_blue.image_speed = 0.8;
            btn_blue_allow_press = false;
            
            //lights
            light_blue.image_speed = 1;
            light_blue.image_index = 0;
            light_blue.visible = true;
            bulb_blue.image_speed = 1;
            bulb_blue.image_index = 0;
            bulb_blue.visible = true;
            
            //sound

            audio_play_sound(snd_memory_note_blue, 1, 0);
            note_played = true;
            
            //store note played
            player_tune[player_cur_note] = "b";
            show_debug_message("player_tune[" + string(player_cur_note) + "] = " + string(player_tune[player_cur_note]));
            
            //compare arrays
            if(player_tune[player_cur_note] != game_tune[player_cur_note]){
                memory_lost = true;
            }
            else{
                player_cur_note ++;
            }
        }

	//play green note.
        if(inst == btn_green){
            player_play_green = true;
            //button
            btn_green.image_speed = 0.8;
            btn_green_allow_press = false;
            
            //lights
            light_green.image_speed = 1;
            light_green.image_index = 0;
            light_green.visible = true;
            bulb_green.image_speed = 1;
            bulb_green.image_index = 0;
            bulb_green.visible = true;
                        
            //sound
            audio_play_sound(snd_memory_note_green, 1, 0); 
            note_played = true;
            
            //store note played
            player_tune[player_cur_note] = "g";
            show_debug_message("player_tune[" + string(player_cur_note) + "] = " + string(player_tune[player_cur_note]));
            
            //compare arrays
            if(player_tune[player_cur_note] != game_tune[player_cur_note]){
                memory_lost = true;
            }
            else{
                player_cur_note ++;
            }
        }

	//play white note.
        if(inst == btn_white){
            player_play_white = true;
            //button
            btn_white.image_speed = 0.8;
            btn_white_allow_press = false;
            
            //lights
            light_white.image_speed = 1;
            light_white.image_index = 0;
            light_white.visible = true;
            bulb_white.image_speed = 1;
            bulb_white.image_index = 0;
            bulb_white.visible = true;
            
            //sound
            audio_play_sound(snd_memory_note_white, 1, 0);
            note_played = true;
                   
            //store note played
            player_tune[player_cur_note] = "w";
            show_debug_message("player_tune[" + string(player_cur_note) + "] = " + string(player_tune[player_cur_note]));
            
            //compare arrays
            if(player_tune[player_cur_note] != game_tune[player_cur_note]){
                memory_lost = true;
            }
            else{
                player_cur_note ++;
            }
        }
        inst = 0;
    }
}

//if the arrays are the same length and they havent played a wrong note, they played the correct tune.
if(!memory_won && array_length_1d(player_tune) == array_length_1d(game_tune)){
    memory_won = true;
}

if(memory_won && !won_sound_played){
    obj_control.time_stopped = true;
    show_debug_message("Memory Level Won");
    audio_play_sound(snd_memory_won, 10, 0);
    won_sound_played = true;
    lights_on = true;
    memory_won = false;
}

//all the lights run, aesthetic celebration when the player wins the level.
if(lights_on){
    light_red.image_speed = 1;
    light_red.visible = true;
    bulb_red.image_speed = 1;
    bulb_red.visible = true;
    
    light_blue.image_speed = 1;
    light_blue.visible = true;
    bulb_blue.image_speed = 1;
    bulb_blue.visible = true;
    
    light_green.image_speed = 1;
    light_green.visible = true;
    bulb_green.image_speed = 1;
    bulb_green.visible = true;
   
    light_white.image_speed = 1;
    light_white.visible = true;
    bulb_white.image_speed = 1;
    bulb_white.visible = true;
}

//onces the lights have cycled 3 times, end the level, player won.
if(light_count >= 3){
    obj_control.time_stopped = false;
    obj_control.time_left_won = obj_control.time_left;
    obj_control.prev_room2 = obj_control.prev_room;
    obj_control.prev_room = 6;
    obj_control.player_lost = false;
    obj_control.player_won = true;

    //delete arrays, avoid memory leak.
    player_tune = -1;
    game_tune = -1;
}

//play lost sound, open trap doors, and pets fall.
if(memory_lost && !lost_ran){
    obj_control.time_stopped = true;
    show_debug_message("Memory Level Lost...");
    audio_play_sound(snd_memory_lost, 10, 0);
    anim_trapdoor.image_speed = 0.5;
    pets_fall = true;
    memory_lost = false;
    lost_ran = true;
}

if(pets_fall){
    //pets falling
    rock_idle.y += 20;
    rock_idle.depth = 2;
    fire_idle.y += 16;
    fire_idle.depth = 2;
    water_idle.y += 12;
    water_idle.depth = 2;
    bird_idle.y += 10;
    bird_idle.depth = 2;
    
    //when they have fallen out of view, end the level, player lost.
    if(rock_idle.y > room_height + 100){
        show_debug_message("checking rock y...");
        obj_control.time_stopped = false;
        obj_control.time_left_lost = obj_control.time_left;
        obj_control.prev_room2 = obj_control.prev_room;
        obj_control.prev_room = 6;
        obj_control.player_lost = true;
        obj_control.player_won = false;

        //delete arrays
        player_tune = -1;
        game_tune = -1;
    }
}

