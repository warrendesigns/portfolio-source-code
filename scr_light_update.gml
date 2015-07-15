///scr_light_update();

/*
SINCE OUR DRAW TARGET FOR THIS CODE IS ACTUALLY THE LIGHT SURFACE AND NOT THE VIEW SURFACE OR THE ROOM, 
WE NEED TO DRAW ITS POSITION RELATIVE TO THE TOP LEFT CORNER OF THE LIGHT SURFACE!!!

things to note:
* pr_trianglestrip: use this type of primative so that each point connects with every other point.
* rad is the radius of the circle being drawn onto surf_light; since our surface is initialised with size (rad * 2, rad * 2), the coordinates (rad, rad)
  are essentially the centre of the surface, which is where the player is
*/

surface_set_target(surf_light);
draw_clear(c_black);
draw_set_alpha(alpha);
draw_set_colour(c_black);
draw_circle_colour(rad,rad,rad,col,c_black,false);

var zone, zone_id, light;
zone = obj_control.zone;
zone_id = obj_player.cur_zone;
light = id;

for(var i = 0; i < zone[zone_id].cast_count; i ++){
    var xx, yy, nx, ny, dist, dir;
    xx = (zone[zone_id].cast_x[i] - view_xview[1]) - ((light.x - view_xview[1]) - rad);
    yy = (zone[zone_id].cast_y[i] - view_yview[1]) - ((light.y - view_yview[1]) - rad);
    dist = point_distance(rad, rad, xx, yy);
    
    if(dist <= rad * 2){
        draw_primitive_begin(pr_trianglestrip);
        for(var j = 0; j < 5; j ++){
            switch(j){
                case 0:
                    nx = xx;
                    ny = yy;
                    break;
                case 1:
                    nx = xx + zone[zone_id].tile_width;
                    ny = yy;
                    break;
                case 2:
                    nx = xx + zone[zone_id].tile_width;
                    ny = yy + zone[zone_id].tile_height;
                    break;
                case 3:
                    nx = xx;
                    ny = yy + zone[zone_id].tile_height;
                    break;
                case 4:
                    nx = xx;
                    ny = yy;
                    break;
            }
            if(dist = point_distance(rad, rad, nx, ny) > rad * 2){
                continue;
            }
            else{
                dir = point_direction(rad, rad, nx, ny);
                draw_vertex(nx, ny);
                draw_vertex(nx + lengthdir_x(dist * 3, dir), ny + lengthdir_y(dist * 3, dir));
            }
        }
        draw_primitive_end();
    }
}
surface_reset_target();