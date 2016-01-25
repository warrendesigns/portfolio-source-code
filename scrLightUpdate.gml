///scrLightUpdate();

/*
SINCE OUR DRAW TARGET FOR THIS CODE IS ACTUALLY THE LIGHT SURFACE AND NOT THE VIEW SURFACE OR THE ROOM, 
WE NEED TO DRAW ITS POSITION RELATIVE TO THE TOP LEFT CORNER OF THE SURFACE!!!

things to note:
- pr_trianglestrip: use this type of primative so that each point connects with every other point.
- rad is the radius of the circle being drawn onto surfaceLight; since our surface is initialised with size (rad * 2, rad * 2), the coordinates (rad, rad)
  are essentially the centre of the surface, which is where the player is
*/

if(surface_exists(surfaceLight))
{
    //setup draw
    surface_set_target(surfaceLight);
    draw_clear(c_black);
    draw_set_color(c_black);
    draw_set_alpha(1);
    
    //draw 'light circle'
    draw_circle_colour(rad, rad, rad, col, c_black, false);
    
    //draw primitives (shadows)
    var zone, zoneID, light;
    zone = objControl.zone;
    ID = objPlayer.ID;
    light = id;
    
    for(var i = 0; i < zone[ID].casterCount; i ++)
    {
        var xx, yy, nx, ny, dist, dir;
        xx = (zone[ID].casterX[i] - view_xview[1]) - ((light.x - view_xview[1]) - rad);
        yy = (zone[ID].casterY[i] - view_yview[1]) - ((light.y - view_yview[1]) - rad);
        dist = point_distance(rad, rad, xx, yy);
        
        if(dist <= rad * 2)
        {
            draw_primitive_begin(pr_trianglestrip);
            for(var j = 0; j < 5; j ++)
            {
                switch(j)
                {
                    case 0:
                        nx = xx;
                        ny = yy;
                        break;
                    case 1:
                        nx = xx + Tile.Width;
                        ny = yy;
                        break;
                    case 2:
                        nx = xx + Tile.Width;
                        ny = yy + Tile.Height;
                        break;
                    case 3:
                        nx = xx;
                        ny = yy + Tile.Height;
                        break;
                    case 4:
                        nx = xx;
                        ny = yy;
                        break;
                }
                if(dist = point_distance(rad, rad, nx, ny) > rad * 2)
                {
                    continue;
                }
                else
                {
                    dir = point_direction(rad, rad, nx, ny);
                    draw_vertex(nx, ny);
                    draw_vertex(nx + lengthdir_x(dist * 5, dir), ny + lengthdir_y(dist * 5, dir));
                }
            }
            draw_primitive_end();
        }
    }
    
    //reset draw
    draw_set_alpha(1);
    draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
/*
else
{
    show_debug_message("NoSurfaceException[surfaceLight]: generating new surface.");
    surfaceLight = surface_create(view_wview[1], view_hview[1]);
    surface_set_target(surfaceLight);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
}


