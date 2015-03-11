/*
     //SETUP FIND LEVEL
     The following code is executed in the create event of obj_find, which is functionally 
     the same as the Start function of a standard C# script.
*/

obj_control.text_alpha = 1;

//CO-ORDINATES OF APPLE TREES
//TOP SCREEN
top_left_x = 125;
top_left_y = 135;
top_left_apple = instance_create(top_left_x, top_left_y, obj_apple1);

top_mid_x = 471;
top_mid_y = 150;
top_mid_apple = instance_create(top_mid_x, top_mid_y, obj_apple3);

top_right_x = 853;
top_right_y = 139;
top_right_apple = instance_create(top_right_x, top_right_y, obj_apple4);

//MID SCREEN
mid_left_x = 270;
mid_left_y = 334;
mid_left_apple = instance_create(mid_left_x, mid_left_y, obj_apple2);

mid_right_x = room_width - 311;
mid_right_y = 325;
mid_right_apple = instance_create(mid_right_x, mid_right_y, obj_apple3);

//BOTTOM SCREEN
bot_left_x = 104;
bot_left_y = 563;
bot_left_apple = instance_create(bot_left_x, bot_left_y, obj_apple1);

bot_mid_x = 491;
bot_mid_y = 568;
bot_mid_apple = instance_create(bot_mid_x, bot_mid_y, obj_apple4);

bot_right_x = 832;
bot_right_y = 563;
bot_right_apple = instance_create(bot_right_x, bot_right_y, obj_apple2);

//these will be true if a pet occupies that spot.
top_left = true;
top_mid = true;
top_right = true;

mid_left = false;
mid_right = false;

bot_left = false;
bot_mid = false;
bot_right = true;

timer_active = false;
allow_click = true;

jail1_pop = false;
jail2_pop = false;
jail3_pop = false;

//level outcome
find_won = false;
find_lost = false;

//win anim delay
won_hang_time = 75; 

//loss anim delay
lost_hang_time = 60;

//counters
apples_stolen1 = 0;
apples_stolen2 = 0;
apples_stolen3 = 0;

notif_timer = 60;
pet_speed = 0;
wait_time = 0;

//instance holders
caught1 = 0;
caught2 = 0;
caught3 = 0;
jail1 = 0;
jail2 = 0;
jail3 = 0;

//initialise level, spawn instances.
layout = instance_create(room_width/2, room_height/2, obj_layout);

anim_pet_rock = instance_create(top_left_x, top_left_y, anim_rockpet);
anim_pet_fire = instance_create(top_mid_x, top_mid_y, anim_firepet);
anim_pet_water = instance_create(top_right_x, top_right_y, anim_waterpet);
anim_pet_bird = instance_create(bot_right_x, bot_right_y, anim_birdpet);

apple_thief1 = 0;
apple_thief2 = 0;
apple_thief3 = 0;

randomize();

//difficulty specific settings.
//higher the difficulty, more thieves, faster movement.
if(obj_control.difficulty == 0){
    pet_speed = 7;
    anim_rockpet.myspeed = pet_speed;
    anim_firepet.myspeed = pet_speed;
    anim_waterpet.myspeed = pet_speed;
    anim_birdpet.myspeed = pet_speed;
    
    wait_time = 20;
    apple_thief1 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    
    jail1 = instance_create(41, room_height/2 - 75, obj_jail_bg);
    
    jail1_pop = false;
    jail2_pop = true;
    jail3_pop = true;
}

if(obj_control.difficulty == 1){
    pet_speed = 7;
    anim_rockpet.myspeed = pet_speed;
    anim_firepet.myspeed = pet_speed;
    anim_waterpet.myspeed = pet_speed;
    anim_birdpet.myspeed = pet_speed;
    
    wait_time = 20;
    apple_thief1 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    
    do{
        apple_thief2 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    }
    until(apple_thief2 != apple_thief1);
    
    jail1 = instance_create(41, room_height/2 - 75, obj_jail_bg);
    jail2 = instance_create(41, room_height/2 + 15, obj_jail_bg);
    
    jail1_pop = false;
    jail2_pop = false;
    jail3_pop = true;
}

if(obj_control.difficulty == 2){
    pet_speed = 8;
    anim_rockpet.myspeed = pet_speed;
    anim_firepet.myspeed = pet_speed;
    anim_waterpet.myspeed = pet_speed;
    anim_birdpet.myspeed = pet_speed;
    
    wait_time = 20;
    apple_thief1 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    
    do{
        apple_thief2 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    }
    until(apple_thief2 != apple_thief1);
    
    jail1 = instance_create(41, room_height/2 - 75, obj_jail_bg);
    jail2 = instance_create(41, room_height/2 + 15, obj_jail_bg);
    
    jail1_pop = false;
    jail2_pop = false;
    jail3_pop = true;
}

if(obj_control.difficulty == 3){
    pet_speed = 8;
    anim_rockpet.myspeed = pet_speed;
    anim_firepet.myspeed = pet_speed;
    anim_waterpet.myspeed = pet_speed;
    anim_birdpet.myspeed = pet_speed;
    
    wait_time = 20;
    apple_thief1 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    
    do{
        apple_thief2 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    }
    until(apple_thief2 != apple_thief1);
    
    do{
        apple_thief3 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    }
    until(apple_thief3 != apple_thief1 && apple_thief3 != apple_thief2);
    
    jail1 = instance_create(41, room_height/2 - 75, obj_jail_bg);
    jail2 = instance_create(41, room_height/2 + 15, obj_jail_bg);
    jail3 = instance_create(41, room_height/2 + 105, obj_jail_bg);
    
    jail1_pop = false;
    jail2_pop = false;
    jail3_pop = false;
}

if(obj_control.difficulty >= 4){
    pet_speed = 9;
    anim_rockpet.myspeed = pet_speed;
    anim_firepet.myspeed = pet_speed;
    anim_waterpet.myspeed = pet_speed;
    anim_birdpet.myspeed = pet_speed;
    
    wait_time = 20;
    apple_thief1 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    
    do{
        apple_thief2 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    }
    until(apple_thief2 != apple_thief1);
    
    do{
        apple_thief3 = choose(anim_pet_rock, anim_pet_fire, anim_pet_water, anim_pet_bird);
    }
    until(apple_thief3 != apple_thief1 && apple_thief3 != apple_thief2);
    
    jail1 = instance_create(41, room_height/2 - 75, obj_jail_bg);
    jail2 = instance_create(41, room_height/2 + 15, obj_jail_bg);
    jail3 = instance_create(41, room_height/2 + 105, obj_jail_bg);
    
    jail1_pop = false;
    jail2_pop = false;
    jail3_pop = false;
}

----------------------------------------------------------------------------------------
/*
     //UPDATE FINDLEVEL
     The following code is ran in the Step event of obj_find, which is functionally the same
     as the Update function of a standard C# script.
*/

//if the player clicks on a pet...
if(mouse_check_button_released(mb_left) && !timer_active && allow_click && !position_meeting(mouse_x, mouse_y, obj_layout)){
    if(position_meeting(mouse_x, mouse_y, anim_pet_rock) ||
       position_meeting(mouse_x, mouse_y, anim_pet_fire) ||
       position_meeting(mouse_x, mouse_y, anim_pet_water) ||
       position_meeting(mouse_x, mouse_y, anim_pet_bird)){
    
	//store the pet in variable 'inst'
        inst = instance_position(mouse_x, mouse_y, all);
        
	//stop pets movement, and set/activate notif_timer, when timer is 0, player will know if they caught a theif or not
        //clicked thief1
        if(inst = apple_thief1){
            audio_play_sound(snd_rope_debris2, 10, 0);
            notif_timer = 1;
            timer_active = true;
            apple_thief1.move_pet = false;
            apple_thief1.speed = 0;
            apple_thief1.image_speed = 0;
        }
        
        //clicked thief2
        if(inst = apple_thief2){
            audio_play_sound(snd_rope_debris2, 10, 0);
            notif_timer = 1;
            timer_active = true;
            apple_thief2.move_pet = false;
            apple_thief2.speed = 0;
            apple_thief2.image_speed = 0;
        }
    
        //clicked thief3
        if(inst = apple_thief3){
            audio_play_sound(snd_rope_debris2, 10, 0);
            notif_timer = 1;
            timer_active = true;
            apple_thief3.move_pet = false;
            apple_thief3.speed = 0;
            apple_thief3.image_speed = 0;
        }
        
        //didnt click a thief
        if(inst != apple_thief1 && inst != apple_thief2 && inst != apple_thief3){
            notif_timer = 1;  
            timer_active = true;
            inst.move_pet = false;
            inst.speed = 0;
            inst.image_speed = 0;
        }
    }
}

//countdown notif_timer.
if(notif_timer > 0 && timer_active){
    notif_timer --;
}

//notify player whether they caught a thief or not.
//if they did, imprison them, if not, they lose the level.
if(notif_timer <= 0){
    timer_active = false;
    
    //THIEF 1
    if(inst == apple_thief1){
        caught1 = instance_create(apple_thief1.x, apple_thief1.y - 60, obj_caught);
        instance_create(apple_thief1.x, apple_thief1.y, obj_jail_top);
        
        if(inst == anim_pet_rock){
            if(!jail1_pop && !instance_exists(obj_rockpet_jail)){
                instance_create(jail1.x, jail1.y, obj_rockpet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_rockpet_jail)){
                instance_create(jail2.x, jail2.y, obj_rockpet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_rockpet_jail)){
                instance_create(jail3.x, jail3.y, obj_rockpet_jail);
                jail3_pop = true;
            }
        }
        if(inst == anim_pet_fire){
            if(!jail1_pop && !instance_exists(obj_firepet_jail)){
                instance_create(jail1.x, jail1.y, obj_firepet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_firepet_jail)){
                instance_create(jail2.x, jail2.y, obj_firepet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_firepet_jail)){
                instance_create(jail3.x, jail3.y, obj_firepet_jail);
                jail3_pop = true;
            }
        }
        if(inst == anim_pet_water){
            if(!jail1_pop && !instance_exists(obj_waterpet_jail)){
                instance_create(jail1.x, jail1.y, obj_waterpet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_waterpet_jail)){
                instance_create(jail2.x, jail2.y, obj_waterpet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_waterpet_jail)){
                instance_create(jail3.x, jail3.y, obj_waterpet_jail);
                jail3_pop = true;
            }
        }
        if(inst == anim_pet_bird){
            if(!jail1_pop && !instance_exists(obj_birdpet_jail)){
                instance_create(jail1.x, jail1.y, obj_birdpet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_birdpet_jail)){
                instance_create(jail2.x, jail2.y, obj_birdpet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_birdpet_jail)){
                instance_create(jail3.x, jail3.y, obj_birdpet_jail);
                jail3_pop = true;
            }
        }
    }
    
    //THIEF 2
    if(inst == apple_thief2){
        caught2 = instance_create(apple_thief2.x, apple_thief2.y - 60, obj_caught);
        instance_create(apple_thief2.x, apple_thief2.y, obj_jail_top);
        
        if(inst == anim_pet_rock){
            if(!jail1_pop && !instance_exists(obj_rockpet_jail)){
                instance_create(jail1.x, jail1.y, obj_rockpet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_rockpet_jail)){
                instance_create(jail2.x, jail2.y, obj_rockpet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_rockpet_jail)){
                instance_create(jail3.x, jail3.y, obj_rockpet_jail);
                jail3_pop = true;
            }
        }
        if(inst == anim_pet_fire){
            if(!jail1_pop && !instance_exists(obj_firepet_jail)){
                instance_create(jail1.x, jail1.y, obj_firepet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_firepet_jail)){
                instance_create(jail2.x, jail2.y, obj_firepet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_firepet_jail)){
                instance_create(jail3.x, jail3.y, obj_firepet_jail);
                jail3_pop = true;
            }
        }
        if(inst == anim_pet_water){
            if(!jail1_pop && !instance_exists(obj_waterpet_jail)){
                instance_create(jail1.x, jail1.y, obj_waterpet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_waterpet_jail)){
                instance_create(jail2.x, jail2.y, obj_waterpet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_waterpet_jail)){
                instance_create(jail3.x, jail3.y, obj_waterpet_jail);
                jail3_pop = true;
            }
        }
        if(inst == anim_pet_bird){
            if(!jail1_pop && !instance_exists(obj_birdpet_jail)){
                instance_create(jail1.x, jail1.y, obj_birdpet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_birdpet_jail)){
                instance_create(jail2.x, jail2.y, obj_birdpet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_birdpet_jail)){
                instance_create(jail3.x, jail3.y, obj_birdpet_jail);
                jail3_pop = true;
            }
        }
    }
    
    //THIEF 3
    if(inst == apple_thief3){
        caught3 = instance_create(apple_thief3.x, apple_thief3.y - 60, obj_caught);
        instance_create(apple_thief3.x, apple_thief3.y, obj_jail_top);
        
        if(inst == anim_pet_rock){
            if(!jail1_pop && !instance_exists(obj_rockpet_jail)){
                instance_create(jail1.x, jail1.y, obj_rockpet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_rockpet_jail)){
                instance_create(jail2.x, jail2.y, obj_rockpet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_rockpet_jail)){
                instance_create(jail3.x, jail3.y, obj_rockpet_jail);
                jail3_pop = true;
            }
        }
        if(inst == anim_pet_fire){
            if(!jail1_pop && !instance_exists(obj_firepet_jail)){
                instance_create(jail1.x, jail1.y, obj_firepet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_firepet_jail)){
                instance_create(jail2.x, jail2.y, obj_firepet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_firepet_jail)){
                instance_create(jail3.x, jail3.y, obj_firepet_jail);
                jail3_pop = true;
            }
        }
        if(inst == anim_pet_water){
            if(!jail1_pop && !instance_exists(obj_waterpet_jail)){
                instance_create(jail1.x, jail1.y, obj_waterpet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_waterpet_jail)){
                instance_create(jail2.x, jail2.y, obj_waterpet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_waterpet_jail)){
                instance_create(jail3.x, jail3.y, obj_waterpet_jail);
                jail3_pop = true;
            }
        }
        if(inst == anim_pet_bird){
            if(!jail1_pop && !instance_exists(obj_birdpet_jail)){
                instance_create(jail1.x, jail1.y, obj_birdpet_jail);
                jail1_pop = true;
            }
            if(!jail2_pop && !instance_exists(obj_birdpet_jail)){
                instance_create(jail2.x, jail2.y, obj_birdpet_jail);
                jail2_pop = true;
            }
            if(!jail3_pop && !instance_exists(obj_birdpet_jail)){
                instance_create(jail3.x, jail3.y, obj_birdpet_jail);
                jail3_pop = true;
            }
        }
    }
    if(inst != apple_thief1 && inst != apple_thief2 && inst != apple_thief3){
        instance_create(inst.x, inst.y - 60, obj_innocent);
        find_lost = true;
    }
}

//win conditions relative to difficulty
if(obj_control.difficulty == 0){
    if(caught1 != 0){
        obj_control.time_stopped = true;
        allow_click = false;
        find_won = true;
    }
}

if(obj_control.difficulty == 1 || obj_control.difficulty == 2){
    if(caught1 != 0 &amp;&amp; caught2 != 0){
        obj_control.time_stopped = true;
        allow_click = false;
        find_won = true;
    }
}

if(obj_control.difficulty &gt;= 3){
    if(caught1 != 0 &amp;&amp; caught2 != 0 &amp;&amp; caught3 != 0){
        obj_control.time_stopped = true;
        allow_click = false;
        find_won = true;
    }
}

//MOVE ROCK PET BETWEEN APPLE TREES, EAT APPLES IF THIEF.
with(anim_pet_rock){
    ///Pet Movement
    if(wait_timer > 0 && timer_on){
        wait_timer --;
    }
    
    if(wait_timer <= 0 && timer_on){
        timer_on = false;
        choose_point = true;
    }
    
    if(choose_point){
        
        point = choose(0, 1, 2, 3, 4, 5, 6, 7);
    
        //top
        if(point == 0 && !other.top_left){
            next_point = 0;
            goto_x = other.top_left_x;
            goto_y = other.top_left_y;
            other.top_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 1 && !other.top_mid){
            next_point = 1;
            goto_x = other.top_mid_x;
            goto_y = other.top_mid_y;
            other.top_mid = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 2 && !other.top_right){
            next_point = 2;
            goto_x = other.top_right_x;
            goto_y = other.top_right_y;
            other.top_right = true;
            move_pet = true;
            choose_point = false;
        }
        
        //mid
        if(point == 3 && !other.mid_left){
            next_point = 3;
            goto_x = other.mid_left_x;
            goto_y = other.mid_left_y;
            other.mid_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 4 && !other.mid_right){
            next_point = 4;
            goto_x = other.mid_right_x;
            goto_y = other.mid_right_y;
            other.mid_right = true;
            move_pet = true;
            choose_point = false;
        }
        
        //bot
        if(point == 5 && !other.bot_left){
            next_point = 5;
            goto_x = other.bot_left_x;
            goto_y = other.bot_left_y;
            other.bot_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 6 && !other.bot_mid){
            next_point = 6;
            goto_x = other.bot_mid_x;
            goto_y = other.bot_mid_y;
            other.bot_mid = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 7 && !other.bot_right){
            next_point = 7;
            goto_x = other.bot_right_x;
            goto_y = other.bot_right_y;
            other.bot_right = true;
            move_pet = true;
            choose_point = false;
        }
    }
    
    if(move_pet){
        if(point_distance(x, y, goto_x, goto_y) > 8){
            image_speed = 2;
            move_towards_point(goto_x, goto_y, myspeed);
            image_angle = direction - 90;
            reset_prev_point = true;
        }
        else{
            speed = 0;
            image_speed = 0;
            prev_point = next_point;
            wait_timer = other.wait_time;
            timer_on = true;
            
            //steal apples if they are a thief
            if(other.anim_pet_rock == other.apple_thief1 || other.anim_pet_rock == other.apple_thief2 || other.anim_pet_rock == other.apple_thief3){
            //top
                if(prev_point == 0){   
                    with(other.top_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_rock == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 1){
                    with(other.top_mid_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_rock == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 2){
                    with(other.top_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_rock == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                
                //mid
                if(prev_point == 3){
                    with(other.mid_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_rock == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 4){
                    with(other.mid_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_rock == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                
                //bot
                if(prev_point == 5){
                    with(other.bot_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_rock == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 6){
                    with(other.bot_mid_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_rock == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 7){
                    with(other.bot_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_rock == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_rock == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
            }
            move_pet = false;
        } 
    }
    
    if(reset_prev_point){
        //top
        if(prev_point == 0){
            other.top_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 1){
            other.top_mid = false;
            reset_prev_point = false;
        }
        if(prev_point == 2){
            other.top_right = false;
            reset_prev_point = false;
        }
        
        //mid
        if(prev_point == 3){
            other.mid_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 4){
            other.mid_right = false;
            reset_prev_point = false;
        }
        
        //bot
        if(prev_point == 5){
            other.bot_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 6){
            other.bot_mid = false;
            reset_prev_point = false;
        }
        if(prev_point == 7){
            other.bot_right = false;
            reset_prev_point = false;
        } 
    }
}

with(anim_pet_fire){
    ///Pet Movement
    if(wait_timer < 0 && timer_on){
        wait_timer --;
    }
    
    if(wait_timer >= 0 && timer_on){
        timer_on = false;
        choose_point = true;
    }
    
    if(choose_point){
        
        point = choose(0, 1, 2, 3, 4, 5, 6, 7);
    
        //top
        if(point == 0 && !other.top_left){
            next_point = 0;
            goto_x = other.top_left_x;
            goto_y = other.top_left_y;
            other.top_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 1 && !other.top_mid){
            next_point = 1;
            goto_x = other.top_mid_x;
            goto_y = other.top_mid_y;
            other.top_mid = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 2 && !other.top_right){
            next_point = 2;
            goto_x = other.top_right_x;
            goto_y = other.top_right_y;
            other.top_right = true;
            move_pet = true;
            choose_point = false;
        }
        
        //mid
        if(point == 3 && !other.mid_left){
            next_point = 3;
            goto_x = other.mid_left_x;
            goto_y = other.mid_left_y;
            other.mid_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 4 && !other.mid_right){
            next_point = 4;
            goto_x = other.mid_right_x;
            goto_y = other.mid_right_y;
            other.mid_right = true;
            move_pet = true;
            choose_point = false;
        }
        
        //bot
        if(point == 5 && !other.bot_left){
            next_point = 5;
            goto_x = other.bot_left_x;
            goto_y = other.bot_left_y;
            other.bot_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 6 && !other.bot_mid){
            next_point = 6;
            goto_x = other.bot_mid_x;
            goto_y = other.bot_mid_y;
            other.bot_mid = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 7 && !other.bot_right){
            next_point = 7;
            goto_x = other.bot_right_x;
            goto_y = other.bot_right_y;
            other.bot_right = true;
            move_pet = true;
            choose_point = false;
        }
    }
    
    if(move_pet){
        if(point_distance(x, y, goto_x, goto_y) &gt; 8){
            image_speed = 2;
            move_towards_point(goto_x, goto_y, myspeed);
            image_angle = direction - 90;
            reset_prev_point = true;
        }
        else{
            speed = 0;
            image_speed = 0;
            prev_point = next_point;
            wait_timer = other.wait_time;
            timer_on = true;
            
            //steal apples if they are a thief
            if(other.anim_pet_fire == other.apple_thief1 || other.anim_pet_fire == other.apple_thief2 || other.anim_pet_fire == other.apple_thief3){
            //top
                if(prev_point == 0){   
                    with(other.top_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_fire == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 1){
                    with(other.top_mid_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_fire == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 2){
                    with(other.top_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_fire == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                
                //mid
                if(prev_point == 3){
                    with(other.mid_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_fire == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 4){
                    with(other.mid_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_fire == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                
                //bot
                if(prev_point == 5){
                    with(other.bot_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_fire == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 6){
                    with(other.bot_mid_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_fire == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 7){
                    with(other.bot_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_fire == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_fire == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
            }
            move_pet = false;
        } 
    }
    
    if(reset_prev_point){
        //top
        if(prev_point == 0){
            other.top_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 1){
            other.top_mid = false;
            reset_prev_point = false;
        }
        if(prev_point == 2){
            other.top_right = false;
            reset_prev_point = false;
        }
        
        //mid
        if(prev_point == 3){
            other.mid_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 4){
            other.mid_right = false;
            reset_prev_point = false;
        }
        
        //bot
        if(prev_point == 5){
            other.bot_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 6){
            other.bot_mid = false;
            reset_prev_point = false;
        }
        if(prev_point == 7){
            other.bot_right = false;
            reset_prev_point = false;
        } 
    }
}

with(anim_pet_water){
    ///Pet Movement
    if(wait_timer > 0 && timer_on){
        wait_timer --;
    }
    
    if(wait_timer <= 0 && timer_on){
        timer_on = false;
        choose_point = true;
    }
    
    if(choose_point){
        
        point = choose(0, 1, 2, 3, 4, 5, 6, 7);
    
        //top
        if(point == 0 && !other.top_left){
            next_point = 0;
            goto_x = other.top_left_x;
            goto_y = other.top_left_y;
            other.top_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 1 && !other.top_mid){
            next_point = 1;
            goto_x = other.top_mid_x;
            goto_y = other.top_mid_y;
            other.top_mid = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 2 && !other.top_right){
            next_point = 2;
            goto_x = other.top_right_x;
            goto_y = other.top_right_y;
            other.top_right = true;
            move_pet = true;
            choose_point = false;
        }
        
        //mid
        if(point == 3 && !other.mid_left){
            next_point = 3;
            goto_x = other.mid_left_x;
            goto_y = other.mid_left_y;
            other.mid_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 4 && !other.mid_right){
            next_point = 4;
            goto_x = other.mid_right_x;
            goto_y = other.mid_right_y;
            other.mid_right = true;
            move_pet = true;
            choose_point = false;
        }
        
        //bot
        if(point == 5 && !other.bot_left){
            next_point = 5;
            goto_x = other.bot_left_x;
            goto_y = other.bot_left_y;
            other.bot_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 6 && !other.bot_mid){
            next_point = 6;
            goto_x = other.bot_mid_x;
            goto_y = other.bot_mid_y;
            other.bot_mid = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 7 && !other.bot_right){
            next_point = 7;
            goto_x = other.bot_right_x;
            goto_y = other.bot_right_y;
            other.bot_right = true;
            move_pet = true;
            choose_point = false;
        }
    }
    
    if(move_pet){
        if(point_distance(x, y, goto_x, goto_y) &gt; 8){
            image_speed = 2;
            move_towards_point(goto_x, goto_y, myspeed);
            image_angle = direction - 90;
            reset_prev_point = true;
        }
        else{
            speed = 0;
            image_speed = 0;
            prev_point = next_point;
            wait_timer = other.wait_time;
            timer_on = true;
            
            //steal apples if they are a thief
            if(other.anim_pet_water == other.apple_thief1 || other.anim_pet_water == other.apple_thief2 || other.anim_pet_water == other.apple_thief3){
            //top
                if(prev_point == 0){   
                    with(other.top_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_water == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 1){
                    with(other.top_mid_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_water == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 2){
                    with(other.top_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_water == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                
                //mid
                if(prev_point == 3){
                    with(other.mid_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_water == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 4){
                    with(other.mid_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_water == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                
                //bot
                if(prev_point == 5){
                    with(other.bot_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_water == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 6){
                    with(other.bot_mid_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_water == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 7){
                    with(other.bot_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_water == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_water == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
            }
            move_pet = false;
        } 
    }
    
    if(reset_prev_point){
        //top
        if(prev_point == 0){
            other.top_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 1){
            other.top_mid = false;
            reset_prev_point = false;
        }
        if(prev_point == 2){
            other.top_right = false;
            reset_prev_point = false;
        }
        
        //mid
        if(prev_point == 3){
            other.mid_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 4){
            other.mid_right = false;
            reset_prev_point = false;
        }
        
        //bot
        if(prev_point == 5){
            other.bot_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 6){
            other.bot_mid = false;
            reset_prev_point = false;
        }
        if(prev_point == 7){
            other.bot_right = false;
            reset_prev_point = false;
        } 
    }
}

with(anim_pet_bird){
    ///Pet Movement
    if(wait_timer > 0 < timer_on){
        wait_timer --;
    }
    
    if(wait_timer <= 0 < timer_on){
        timer_on = false;
        choose_point = true;
    }
    
    if(choose_point){
        
        point = choose(0, 1, 2, 3, 4, 5, 6, 7);
    
        //top
        if(point == 0 && !other.top_left){
            next_point = 0;
            goto_x = other.top_left_x;
            goto_y = other.top_left_y;
            other.top_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 1 && !other.top_mid){
            next_point = 1;
            goto_x = other.top_mid_x;
            goto_y = other.top_mid_y;
            other.top_mid = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 2 && !other.top_right){
            next_point = 2;
            goto_x = other.top_right_x;
            goto_y = other.top_right_y;
            other.top_right = true;
            move_pet = true;
            choose_point = false;
        }
        
        //mid
        if(point == 3 && !other.mid_left){
            next_point = 3;
            goto_x = other.mid_left_x;
            goto_y = other.mid_left_y;
            other.mid_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 4 && !other.mid_right){
            next_point = 4;
            goto_x = other.mid_right_x;
            goto_y = other.mid_right_y;
            other.mid_right = true;
            move_pet = true;
            choose_point = false;
        }
        
        //bot
        if(point == 5 && !other.bot_left){
            next_point = 5;
            goto_x = other.bot_left_x;
            goto_y = other.bot_left_y;
            other.bot_left = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 6 && !other.bot_mid){
            next_point = 6;
            goto_x = other.bot_mid_x;
            goto_y = other.bot_mid_y;
            other.bot_mid = true;
            move_pet = true;
            choose_point = false;
        }
        if(point == 7 && !other.bot_right){
            next_point = 7;
            goto_x = other.bot_right_x;
            goto_y = other.bot_right_y;
            other.bot_right = true;
            move_pet = true;
            choose_point = false;
        }
    }
    
    if(move_pet){
        if(point_distance(x, y, goto_x, goto_y) &gt; 8){
            image_speed = 2;
            move_towards_point(goto_x, goto_y, myspeed);
            image_angle = direction - 90;
            reset_prev_point = true;
        }
        else{
            speed = 0;
            image_speed = 0;
            prev_point = next_point;
            wait_timer = other.wait_time;
            timer_on = true;
            
            //steal apples if they are a thief
            if(other.anim_pet_bird == other.apple_thief1 || other.anim_pet_bird == other.apple_thief2 || other.anim_pet_bird == other.apple_thief3){
            //top
                if(prev_point == 0){   
                    with(other.top_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_bird == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 1){
                    with(other.top_mid_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_bird == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 2){
                    with(other.top_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_bird == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                
                //mid
                if(prev_point == 3){
                    with(other.mid_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_bird == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 4){
                    with(other.mid_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_bird == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                
                //bot
                if(prev_point == 5){
                    with(other.bot_left_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_bird == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 6){
                    with(other.bot_mid_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_bird == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
                if(prev_point == 7){
                    with(other.bot_right_apple){
                        if(image_index < image_number - 1){
                            image_index ++;
                            if(obj_find.anim_pet_bird == obj_find.apple_thief1){
                                obj_find.apples_stolen1 ++;
                                audio_play_sound(snd_find_stolen1, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief2){
                                obj_find.apples_stolen2 ++;
                                audio_play_sound(snd_find_stolen2, 10, 0);
                            }
                            if(obj_find.anim_pet_bird == obj_find.apple_thief3){
                                obj_find.apples_stolen3 ++;
                                audio_play_sound(snd_find_stolen3, 10, 0);
                            }
                        }
                    }
                }
            }
            move_pet = false;
        } 
    }
    
    if(reset_prev_point){
        //top
        if(prev_point == 0){
            other.top_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 1){
            other.top_mid = false;
            reset_prev_point = false;
        }
        if(prev_point == 2){
            other.top_right = false;
            reset_prev_point = false;
        }
        
        //mid
        if(prev_point == 3){
            other.mid_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 4){
            other.mid_right = false;
            reset_prev_point = false;
        }
        
        //bot
        if(prev_point == 5){
            other.bot_left = false;
            reset_prev_point = false;
        }
        if(prev_point == 6){
            other.bot_mid = false;
            reset_prev_point = false;
        }
        if(prev_point == 7){
            other.bot_right = false;
            reset_prev_point = false;
        } 
    }
}

//PLAYER WON LEVEL, PLAY WIN ANIMS. PLACE THE CAUGHT THIEVES IN JAIL
if(find_won){
    if(!instance_exists(obj_find_won_bg)){
        instance_create(room_width/2, room_height/2, obj_find_won_bg);
    }
    if(!instance_exists(anim_find_won_jail)){
        jail1 = instance_create(160, room_height/2, anim_find_won_jail);
        jail2 = instance_create(480, room_height/2, anim_find_won_jail);
        jail3 = instance_create(800, room_height/2, anim_find_won_jail);
        
        if(apple_thief2 == 0){
            jail2.image_index = 19;
        }
        if(apple_thief3 == 0){
            jail3.image_index = 19;
        }
    }
    if(!instance_exists(anim_rockpet_no)){
        if(anim_pet_rock == apple_thief1){
            instance_create(160, room_height/2, anim_rockpet_no);
        }
        if(anim_pet_rock == apple_thief2){
            instance_create(480, room_height/2, anim_rockpet_no);
        }
        if(anim_pet_rock == apple_thief3){
            instance_create(800, room_height/2, anim_rockpet_no);
        }
    }
    if(!instance_exists(anim_firepet_no)){
        if(anim_pet_fire == apple_thief1){
            instance_create(160, room_height/2, anim_firepet_no);
        }
        if(anim_pet_fire == apple_thief2){
            instance_create(480, room_height/2, anim_firepet_no);
        }
        if(anim_pet_fire == apple_thief3){
            instance_create(800, room_height/2, anim_firepet_no);
        }
    }
    if(!instance_exists(anim_waterpet_no)){
        if(anim_pet_water == apple_thief1){
            instance_create(160, room_height/2, anim_waterpet_no);
        }
        if(anim_pet_water == apple_thief2){
            instance_create(480, room_height/2, anim_waterpet_no);
        }
        if(anim_pet_water == apple_thief3){
            instance_create(800, room_height/2, anim_waterpet_no);
        }
    }
    if(!instance_exists(anim_birdpet_no)){
        if(anim_pet_bird == apple_thief1){
            instance_create(160, room_height/2, anim_birdpet_no);
        }
        if(anim_pet_bird == apple_thief2){
            instance_create(480, room_height/2, anim_birdpet_no);
        }
        if(anim_pet_bird == apple_thief3){
            instance_create(800, room_height/2, anim_birdpet_no);
        }
    }
    won_hang_time --;
    
    //start/stop anims based on hang time.
    if(instance_exists(anim_find_won_jail)){
        with(anim_find_won_jail){
            if(other.won_hang_time == 50){
                if(anim_find_won_jail.image_index == 0){
                    anim_find_won_jail.image_speed = 0.5;
                    if(!audio_is_playing(snd_find_won)){
                        audio_play_sound(snd_find_won, 10, 0);
                    }
                }
            }
            if(image_speed > 0){
                if(image_index >= image_number - 1){
                    image_index = image_number - 1;
                    image_speed = 0;
                }
            }
        }
    }
    
    //rock
    if(instance_exists(anim_rockpet_no)){
        with(anim_rockpet_no){
            if(other.won_hang_time == 30){
                image_speed = 0.8;
            }
            if(image_index >= image_number - 1){
                image_index = image_number - 1
                image_speed = 0;
            }
        }
    }
    
    //fire
    if(instance_exists(anim_firepet_no)){
        with(anim_firepet_no){
            if(other.won_hang_time == 45){
                image_speed = 0.5;
            }
            if(image_index >= image_number - 1){
                image_index = image_number - 1
                image_speed = 0;
            }
        }
    }
    
    //water
    if(instance_exists(anim_waterpet_no)){
        with(anim_waterpet_no){
            if(other.won_hang_time == 50){
                image_speed = 0.8;
            }
            if(image_index >= image_number - 1){
                image_index = image_number - 1
                image_speed = 0;
            }
        }
    }
    
    //bird
    if(instance_exists(anim_birdpet_no)){
        with(anim_birdpet_no){
            if(other.won_hang_time == 70){
                image_speed = 0.5;
            }
            if(image_index >= image_number - 1){
                image_index = image_number - 1
                image_speed = 0;
            }
        }
    }
    if(won_hang_time <= 0){ 
        //show_debug_message("YOU CAUGHT ALL THE THIEVES. YAY!"); 
        obj_control.time_stopped = false;
        obj_control.time_left_won = obj_control.time_left;
        obj_control.prev_room2 = obj_control.prev_room;
        obj_control.prev_room = 4;
        obj_control.player_lost = false;
        obj_control.player_won = true;
    }
}

//PLAYER LOST LEVEL, PLAY LOST ANIM, THIEVES ALL EATING APPLES.
if(find_lost){
    if(!instance_exists(obj_find_lost_bg)){
        obj_control.time_stopped = true;
        lost_bg = instance_create(room_width/2, room_height/2, obj_find_lost_bg);
        lost_bg.depth = -100;
    }
    //asset from module3>pie_eating level
    if(!instance_exists(anim_rockpet_eating_bg)){
        if(anim_pet_rock == apple_thief1 || anim_pet_rock == apple_thief2 || anim_pet_rock == apple_thief3){
            rock_eat = instance_create(100, room_height - 120, anim_rockpet_eating_bg);
            rock_eat.depth = -110;
        }
    }
    if(!instance_exists(anim_firepet_eating)){
        if(anim_pet_fire == apple_thief1 || anim_pet_fire == apple_thief2 || anim_pet_fire == apple_thief3){
            fire_eat = instance_create(250, room_height - 140, anim_firepet_eating);
            fire_eat.depth = -110;
        }
    }
    //asset from module3>pie_eating level
    if(!instance_exists(anim_waterpet_eating_bg)){
        if(anim_pet_water == apple_thief1 || anim_pet_water == apple_thief2 || anim_pet_water == apple_thief3){
            water_eat = instance_create(room_width/2 + 150, room_height - 150, anim_waterpet_eating_bg);
            water_eat.depth = -110;
        }
    }
    if(!instance_exists(anim_birdpet_eating)){
        if(anim_pet_bird == apple_thief1 || anim_pet_bird == apple_thief2 || anim_pet_bird == apple_thief3){
            bird_eat = instance_create(room_width  - 150, room_height - 220, anim_birdpet_eating);
            bird_eat.depth = -110;
        }
    }
    lost_hang_time --;
    if(lost_hang_time <= 0){
        //show_debug_message("YOU WRONGLY ACCUSED A PET"); 
        obj_control.time_stopped = false;
        obj_control.time_left_lost = obj_control.time_left;
        obj_control.prev_room2 = obj_control.prev_room;
        obj_control.prev_room = 4;
        obj_control.player_lost = true;
        obj_control.player_won = false;
    }
}
