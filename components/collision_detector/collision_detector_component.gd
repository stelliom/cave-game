class_name CollisionDetectorComponent
extends RayCast2D


const _TILE_SIZE = 16.0  # TODO: Put this in a global autoload for constants

func would_collide(direction):
    target_position = direction * _TILE_SIZE
    force_raycast_update()

    return is_colliding()

func destroy_terrain():
    var collider = get_collider()
    if collider is TileMapLayer:
        #var collision_point = get_collision_point()
        var local_pos = collider.to_local(global_position + target_position)
        var cell = collider.local_to_map(local_pos)
        collider.erase_cell(cell)
