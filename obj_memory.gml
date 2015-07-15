///SETUP MEMORY LEVEL - CALLED ONCE WHEN OBJECT IS INITIALISED.

//init variables
game_cur_note = 0;
player_cur_note = 0;
light_count = 0;

level_start_timer = 30;
timer_on = true;

play_tune_start = false;
note_played = false;

play_note_red = false;
play_note_blue = false;
play_note_green = false;
play_note_white = false;
player_played = false;

memory_won = false;
won_sound_played = false;
lights_on = false;
memory_lost = false;
lost_ran = false;
pets_fall = false;

player_tune[0] = 0;

/*
setup objects...
*/

//difficulty: number of notes in the tune.
if(instance_number(obj_control) > 0){
    if(obj_control.difficulty == 0){
        note_count = 4;
    }
    if(obj_control.difficulty == 1){
        note_count = 5;
    }
    if(obj_control.difficulty == 2){
        note_count = 6;
    }
    if(obj_control.difficulty == 3){
        note_count = 7;
    }
    if(obj_control.difficulty >= 4){
        note_count = 8;
    }
}
else{
    note_count = 4;
}

for(i = note_count - 1; i > -1; i--){
    game_tune[i] = 0;
}
for(i = 0; i < note_count; i++){
    game_tune[i] = choose("r", "b", "g", "w");
}

----------------------------------------------------------------------
///UPDATE MEMORY - CALLED EVERY FRAME.
----------------------------------------------------------------------

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
        if(game_tune[game_cur_note] = "r"){
            play_note_red = true;
        }
        if(game_tune[game_cur_note] = "b"){
            play_note_blue = true; 
        }
        if(game_tune[game_cur_note] = "g"){
            play_note_green = true;
        }
        if(game_tune[game_cur_note] = "w"){
            play_note_white = true;
        }
    } 
}

if(game_cur_note >= note_count){
    play_tune_start = false;
}

//when the player clicks a button, play the corresponding note.
if(mouse_check_button_released(mb_left) && !play_tune_start && !timer_on && !pets_fall && !won_sound_played){
    if(position_meeting(mouse_x, mouse_y, all)){
        inst = instance_position(mouse_x, mouse_y, all);
        
        if(inst == btn_red){
            play_note_red = true;
            player_played = true;
        }
        if(inst == btn_blue){
            play_note_blue = true;
            player_played = true;
        }
        if(inst == btn_green){
            play_note_green = true;
            player_played = true;
        }
        if(inst == btn_white){
            play_note_white = true;
            player_played = true;
        }
        inst = 0;
    }
}

//notes
if(play_note_red && !note_played){
    light_red.visible = true;
    bulb_red.image_speed = 1;
    bulb_red.visible = true;
    audio_play_sound(snd_memory_note_red, 1, 0);
    note_played = true;
    
    if(player_played){
        player_tune[player_cur_note] = "r";
        
        if(player_tune[player_cur_note] != game_tune[player_cur_note]){
            memory_lost = true;
        }
        else{
            player_cur_note ++;
        }
        player_played = false;
    }
}
if(play_note_blue && !note_played){
    light_blue.image_speed = 1;
    light_blue.visible = true;
    bulb_blue.image_speed = 1;
    bulb_blue.visible = true;
    audio_play_sound(snd_memory_note_blue, 1, 0);
    note_played = true;
    
    if(player_played){
        player_tune[player_cur_note] = "b";
        
        if(player_tune[player_cur_note] != game_tune[player_cur_note]){
            memory_lost = true;
        }
        else{
            player_cur_note ++;
        }
        player_played = false;
    }
}
if(play_note_green && !note_played){
    light_green.image_speed = 1;
    light_green.visible = true;
    bulb_green.image_speed = 1;
    bulb_green.visible = true;
    audio_play_sound(snd_memory_note_green, 1, 0);
    note_played = true;
    
    if(player_played){
        player_tune[player_cur_note] = "g";
        
        if(player_tune[player_cur_note] != game_tune[player_cur_note]){
            memory_lost = true;
        }
        else{
            player_cur_note ++;
        }
        player_played = false;
    }
}
if(play_note_white && !note_played){
    light_white.image_speed = 1;
    light_white.visible = true;
    bulb_white.image_speed = 1;
    bulb_white.visible = true;
    audio_play_sound(snd_memory_note_white, 1, 0);
    note_played = true;
    
    if(player_played){
        player_tune[player_cur_note] = "w";
        
        if(player_tune[player_cur_note] != game_tune[player_cur_note]){
            memory_lost = true;
        }
        else{
            player_cur_note ++;
        }
        player_played = false;
    }
}

//if the arrays are the same length and the player hasnt lost; they win.
if(!memory_won && array_length_1d(player_tune) == array_length_1d(game_tune)){
    memory_won = true;
}

//level won
if(memory_won && !won_sound_played){
    obj_control.time_stopped = true;
    audio_play_sound(snd_memory_won, 10, 0);
    won_sound_played = true;
    lights_on = true;
    memory_won = false;
}

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

if(light_count >= 3){
    with(obj_control){
        time_stopped = false;
        time_left_won = time_left;
        prev_room2 = prev_room;
        prev_room = 6;
        player_lost = false;
        player_won = true;
    }
    //clean up
    player_tune = -1;
    game_tune = -1;
}

//level lost
if(memory_lost && !lost_ran){
    obj_control.time_stopped = true;
    //show_debug_message("Memory Level Lost...");
    audio_play_sound(snd_memory_lost, 10, 0);
    anim_trapdoor.image_speed = 0.5;
    pets_fall = true;
    memory_lost = false;
    lost_ran = true;
}

if(pets_fall){
    //show_debug_message("pets falling");
    rock_idle.y += 20;
    rock_idle.depth = 2;
    fire_idle.y += 16;
    fire_idle.depth = 2;
    water_idle.y += 12;
    water_idle.depth = 2;
    bird_idle.y += 10;
    bird_idle.depth = 2;
    
    if(rock_idle.y > room_height + 100){
        //show_debug_message("checking rock y...");
        with(obj_control){
            time_stopped = false;
            time_left_lost = time_left;
            prev_room2 = prev_room;
            prev_room = 6;
            player_lost = true;
            player_won = false;
        }
        //clean up
        player_tune = -1;
        game_tune = -1;
    }
}