// Destroys sheet instances.
for (var i = ds_list_size(list_sheets) - 1; i >= 0; --i) {
    instance_activate_object(list_sheets[| i]);
    with (list_sheets[| i]) instance_destroy();
}

// Deletes buffers.
while (ds_map_size(map_curved_to_flat_surfaces) > 0) {
    t = ds_map_find_first(map_curved_to_flat_surfaces);
    buffer_delete(map_curved_to_flat_surfaces[? t]);
    ds_map_delete(map_curved_to_flat_surfaces, t);
}

// Destroys data structures.
ds_list_destroy(list_sheets);
ds_list_destroy(list_sheets_with_special_visibility_type);
ds_map_destroy(map_sheet_alpha);
ds_priority_destroy(priority_depth_sort);
ds_map_destroy(map_curved_to_flat_surfaces);

// Deletes vertex buffers.
vertex_delete_buffer(vb_front);
vertex_delete_buffer(vb_back);
vertex_delete_buffer(vb_edge);

// Frees surface.
surface_free(sf_3d);

