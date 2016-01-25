///scrLightmapUpdate();
/*
-- This script is responsible for updating the games lightmap. to do this we:
- clear the surface
- update/draw each light surface onto this surface
*/

//surfaces are volatile, make sure they exist.
if(surface_exists(surfaceView))
{
    with(objLight)
    {
        scrLightUpdate();
    }
    //setup draw
    surface_set_target(surfaceView);
    draw_set_blend_mode(bm_normal);
    draw_clear_alpha(c_black, 1);
    draw_set_alpha(0.15);
    draw_set_colour(c_white)
    draw_rectangle(0, 0, surface_get_width(surfaceView), surface_get_height(surfaceView), false);
    //draw
    draw_set_alpha(1);
    draw_set_blend_mode(bm_add);
    with(objLight)
    {
        scrLightDraw();
    }
    //reset draw
    draw_set_alpha(1);
    draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
else
{
    show_debug_message("NoSurfaceException[surfaceView]: generating new surface.");
    surfaceView = surface_create(view_wview[1], view_hview[1]);
    surface_set_target(surfaceView);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
}

