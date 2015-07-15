----------------------------------------------------------------
///UPDATE BUILD - CALLED EVERY FRAME
----------------------------------------------------------------

//object checking
if(instance_exists(obj_control)){
    with(obj_head){
        if(checking && !obj_control.game_paused){
            if (mouse_check_button_released(mb_left) && place_meeting(x, y, obj_outline)){
                other.head_set = true;
                checking = false;
            }
        }
    }
    with(obj_torso){
        if(checking && !obj_control.game_paused){
            if (mouse_check_button_released(mb_left) && place_meeting(x, y, obj_outline)){
                other.torso_set = true;
                checking = false;
            }
        }
    }
    with(obj_arm_right){
        if(checking && !obj_control.game_paused){
            if (mouse_check_button_released(mb_left) && place_meeting(x, y, obj_outline)){
                other.arm_right_set = true;
                checking = false;
            }
        }
    }
    with(obj_arm_left){
        if(checking && !obj_control.game_paused){
            if (mouse_check_button_released(mb_left) && place_meeting(x, y, obj_outline)){
                other.arm_left_set = true;
                checking = false;
            }
        }
    }
    with(obj_leg_right){
        if(checking && !obj_control.game_paused){
            if (mouse_check_button_released(mb_left) && place_meeting(x, y, obj_outline)){
                other.leg_right_set = true;
                checking = false;
            }
        }
    }
    with(obj_leg_left){
        if(checking && !obj_control.game_paused){
            if (mouse_check_button_released(mb_left) && place_meeting(x, y, obj_outline)){
                other.leg_left_set = true;
                checking = false;
            }
        }
    }
}


//if the player clicks, and no animations are playing
if(mouse_check_button_released(mb_left) && !play_animations){

    //store what they clicked on in 'inst'
    var inst = instance_position(mouse_x, mouse_y, all);
    if(inst != noone){
        if(inst.depth < deepest){
            deepest = inst.depth;
        }
    }
    
    //compares depth of 'inst' against depth of grass objects to determine which one was clicked on.
    //required since if grass overlapped in previous builds and the player clicked the intersection, they would both react.
    //now, only the 'deepest' piece of grass will react (i.e. the one in front/ closest to the screen.) 
    if (deepest == grass1.depth && inst.x == grass1.x){
        audio_play_sound(snd_build_flatten_grass, 10, 0);
        grass1.image_index = 1;
    }
    
    if (deepest == grass2.depth && inst.x == grass2.x){
        audio_play_sound(snd_build_flatten_grass, 10, 0);
        grass2.image_index = 1;
    }
    
    if (deepest == grass3.depth && inst.x == grass3.x){
        audio_play_sound(snd_build_flatten_grass, 10, 0);
        grass3.image_index = 1;
    }
    
    if (deepest == grass4.depth && inst.x == grass4.x){
        audio_play_sound(snd_build_flatten_grass, 10, 0);
        grass4.image_index = 1;
    }
    
    if (deepest == grass5.depth && inst.x == grass5.x){
        audio_play_sound(snd_build_flatten_grass, 10, 0);
        grass5.image_index = 1;
    }
    
    if (deepest == grass6.depth && inst.x == grass6.x){
        audio_play_sound(snd_build_flatten_grass, 10, 0);
        grass6.image_index = 1;
    }
    deepest = 0;
}

//if mouse button is pressed on a piece, drag it.
if (mouse_check_button_pressed(mb_left) && !cant_drag_head && position_meeting(mouse_x, mouse_y, head) || 
    mouse_check_button_pressed(mb_left) && !cant_drag_torso && position_meeting(mouse_x, mouse_y, torso) ||
    mouse_check_button_pressed(mb_left) && !cant_drag_arm_right && position_meeting(mouse_x, mouse_y, arm_right) || 
    mouse_check_button_pressed(mb_left) && !cant_drag_arm_left && position_meeting(mouse_x, mouse_y, arm_left) || 
    mouse_check_button_pressed(mb_left) && !cant_drag_leg_right && position_meeting(mouse_x, mouse_y, leg_right) || 
    mouse_check_button_pressed(mb_left) && !cant_drag_leg_left && position_meeting(mouse_x, mouse_y, leg_left)){
    
    audio_play_sound(snd_build_pickup, 10, 0);
    dragged_object = instance_position(mouse_x, mouse_y, all);
    dragged = true;
}

if(dragged && dragged_object == head){
    head.x = mouse_x;
    head.y = mouse_y;
    head.depth = -6;
}

if(dragged && dragged_object == torso){
    torso.x = mouse_x;
    torso.y = mouse_y;
    torso.depth = -6;
}

if(dragged && dragged_object == arm_right){
    arm_right.x = mouse_x;
    arm_right.y = mouse_y;
    arm_right.depth = -6;
}

if(dragged && dragged_object == arm_left){
    arm_left.x = mouse_x;
    arm_left.y = mouse_y;
    arm_left.depth = -6;
}

if(dragged && dragged_object == leg_right){
    leg_right.x = mouse_x;
    leg_right.y = mouse_y;
    leg_right.depth = -6;
}

if(dragged && dragged_object == leg_left){
    leg_left.x = mouse_x;
    leg_left.y = mouse_y;
    leg_left.depth = -6;
} 
  
//if lmb is released, stop dragging
if (mouse_check_button_released(mb_left)){
    dragged = false;
} 

//if a piece collides with obj_Outline; disable drag functionality, and snap piece to final position.
if(head_set){
    cant_drag_head = true;
    with(head){
        head_final_x = 480;
        head_final_y = 191;
        if(point_distance(x, y, head_final_x, head_final_y) > 10){
            move_towards_point(head_final_x, head_final_y, 10);
        }
        if(point_distance(x, y, head_final_x, head_final_y) < 10){
            move_towards_point(head_final_x, head_final_y, 1);
        }
        if(point_distance(x, y, head_final_x, head_final_y) < 3){
            speed = 0;
            other.head_stop = true;
            other.head_set = false;
        }
    }
}

if(torso_set){
    cant_drag_torso = true;
    with(torso){
        torso_final_x = 480;
        torso_final_y = 286;
        if(point_distance(x, y, torso_final_x, torso_final_y) > 10){
            move_towards_point(torso_final_x, torso_final_y, 10);
        }
        if(point_distance(x, y, torso_final_x, torso_final_y) < 10){
            move_towards_point(torso_final_x, torso_final_y, 1);
        }
        if(point_distance(x, y, torso_final_x, torso_final_y) < 3){
            speed = 0;
            other.torso_stop = true;
            other.torso_set = false;
        }
    }
}

if(arm_right_set){
    cant_drag_arm_right = true;
    with(arm_right){
        arm_right_final_x = 400;
        arm_right_final_y = 305;
        if(point_distance(x, y, arm_right_final_x, arm_right_final_y) > 10){
            move_towards_point(arm_right_final_x, arm_right_final_y, 10);
        }
        if(point_distance(x, y, arm_right_final_x, arm_right_final_y) < 10){
            move_towards_point(arm_right_final_x, arm_right_final_y, 1);
        }
        if(point_distance(x, y, arm_right_final_x, arm_right_final_y) < 3){
            speed = 0;
            other.arm_right_stop = true;
            other.arm_right_set = false;
        }
    }
}

if(arm_left_set){
    cant_drag_arm_left = true;
    with(arm_left){
        arm_left_final_x = 563;
        arm_left_final_y = 290;
        if(point_distance(x, y, arm_left_final_x, arm_left_final_y) > 10){
            move_towards_point(arm_left_final_x, arm_left_final_y, 10);
        }
        if(point_distance(x, y, arm_left_final_x, arm_left_final_y) < 10){
            move_towards_point(arm_left_final_x, arm_left_final_y, 1);
        }
        if(point_distance(x, y, arm_left_final_x, arm_left_final_y) < 3){
            speed = 0;
            other.arm_left_stop = true;
            other.arm_left_set = false;
        }
    }
}

if(leg_right_set){
    cant_drag_leg_right = true;
    with(leg_right){
        leg_right_final_x = 452;
        leg_right_final_y = 420;
        if(point_distance(x, y, leg_right_final_x, leg_right_final_y) > 10){
            move_towards_point(leg_right_final_x, leg_right_final_y, 10);
        }
        if(point_distance(x, y, leg_right_final_x, leg_right_final_y) < 10){
            move_towards_point(leg_right_final_x, leg_right_final_y, 1);
        }
        if(point_distance(x, y, leg_right_final_x, leg_right_final_y) < 3){
            speed = 0;
            other.leg_right_stop = true;
            other.leg_right_set = false;
        }
    }
}

if(leg_left_set){
    cant_drag_leg_left = true;
    with(leg_left){
        leg_left_final_x = 519;
        leg_left_final_y = 419;
        if(point_distance(x, y, leg_left_final_x, leg_left_final_y) > 10){
            move_towards_point(leg_left_final_x, leg_left_final_y, 10);
        }
        if(point_distance(x, y, leg_left_final_x, leg_left_final_y) < 10){
            move_towards_point(leg_left_final_x, leg_left_final_y, 1);
        }
        if(point_distance(x, y, leg_left_final_x, leg_left_final_y) < 3){
            speed = 0;
            other.leg_left_stop = true;
            other.leg_left_set = false; 
        }
    }
}

if(cant_drag_head && cant_drag_torso && cant_drag_arm_right && cant_drag_arm_left && cant_drag_leg_right && cant_drag_leg_left){
    obj_control.time_stopped = true;
}

//if all pieces are finished moving... player wins.
if(head_stop && torso_stop && arm_right_stop && arm_left_stop && leg_right_stop && leg_left_stop){
    head_set = false; 
    torso_set = false;
    arm_right_set = false;
    arm_left_set = false;
    leg_right_set = false;
    leg_left_set = false;
    cant_drag_head = false;
    cant_drag_torso = false;
    cant_drag_arm_right = false;
    cant_drag_arm_left = false;
    cant_drag_leg_right = false;
    cant_drag_leg_left = false;
    head_stop = false;
    torso_stop = false;
    arm_right_stop = false;
    arm_left_stop = false;
    leg_right_stop = false;
    leg_left_stop = false;
    obj_control.time_left_won = obj_control.time_left;

    //Begin Playing animations
    play_animations = true;
}

if(play_animations){

    if(!instance_exists(anim_rock_fall) && !stop_fall){
        anim_fall = instance_create(room_width/2, room_height/2, anim_rock_fall);
        anim_fall.depth = -8;
        anim_fall.image_speed = 1;
    }
    
    if(instance_exists(anim_rock_fall) && !anim_break){
        with(anim_fall){
            if(image_index >= image_number - 1){
                image_speed = 0;
                if(audio_is_playing(snd_build_rock_fall)){
                    audio_stop_sound(snd_build_rock_fall);
                }
                audio_play_sound(snd_build_rock_land, 10, 0);
                other.anim_break = true;
            }
        }
    }
    
    if(anim_break){
        timer --;
        if(timer == 10){
            if(!audio_is_playing(snd_build_won)){
                audio_play_sound(snd_build_won, 10, 0);
                audio_sound_gain(snd_build_won, obj_control.sfx_vol, 0);
            }
        }
    }
    
    if(anim_break && timer <= 0){
        timer = 0;
        //won level
        if(obj_control.time_left > 0){
            background_visible[0] = false;
            background_visible[1] = true;
            with(head){instance_destroy();}
            with(torso){instance_destroy();}
            with(arm_right){instance_destroy();}
            with(arm_left){instance_destroy();}
            with(leg_right){instance_destroy();}
            with(leg_left){instance_destroy();}
            with(grass1){instance_destroy();}
            with(grass2){instance_destroy();}
            with(grass3){instance_destroy();}
            with(grass4){instance_destroy();}
            with(grass5){instance_destroy();}
            with(grass6){instance_destroy();}
            with(obj_outline){instance_destroy();}
            with(obj_shadow){instance_destroy();}
            with(anim_fall){instance_destroy();}
            stop_fall = true;
            build_won = true;
        }
        //lost level
        if(obj_control.time_left <= 0){
            anim_fall.image_speed = 0;
            build_lost = true;
        }
        anim_break = false;
    }
    
    if(build_won){
        if(!instance_exists(anim_rock_explode) && !stop_explosion){
            anim_explosion = instance_create(room_width/2, room_height/2, anim_rock_explode);
            anim_explosion.depth = -2;
        }
        
        if(!instance_exists(anim_rockpet_pose)){
            anim_pose = instance_create(room_width/2, 485, anim_rockpet_pose);
            anim_pose.depth = -1;
        }

        if(instance_exists(anim_rock_explode)){
            with(anim_explosion){
                image_speed = 1;
                if(image_index >= image_number/2){
                    other.play_anim_pose = true;
                }
                if(image_index >= image_number - 1){
                    instance_destroy();
                    other.stop_explosion = true;
                }
            }
        }
        
        if(instance_exists(anim_rockpet_pose) && play_anim_pose){
            with(anim_pose){
                image_speed = 1;
                if(image_index >= image_number - 1){
                    image_speed = 0; 
                    other.grow_shadow = 0;
                    obj_control.time_stopped = false;
                    obj_control.prev_room2 = obj_control.prev_room;
                    obj_control.prev_room = 2;
                    obj_control.player_lost = false;
                    obj_control.player_won = true;
                    obj_control.play_animations = false;
                    other.play_anim_pose = false;
                }
            }
        }
    }
}

if(build_lost){
    obj_control.time_left_lost = obj_control.time_left;
    obj_control.prev_room2 = obj_control.prev_room;
    obj_control.prev_room = 2;
    obj_control.player_lost = true;
    obj_control.player_won = false;
    obj_control.time_stopped = false;
    grow_shadow = 0;
    build_lost = false;
}

//Increase shadows scale
if(instance_exists(obj_shadow)){
    if(!audio_is_playing(snd_build_rock_fall)){
        if(!fall_played){
            audio_play_sound(snd_build_rock_fall, 5, 0);
            fall_played = true;
        }
    }
    with(shadow){
        if(!other.play_animations){
            other.grow_shadow += 1;
            shadow_size = other.grow_shadow/obj_control.time_max;
        
            if(obj_control.time_left > 0){
                image_xscale = shadow_size;
            }
            if(obj_control.time_left > 0){
                image_yscale = shadow_size;
            }
        }
    }
}