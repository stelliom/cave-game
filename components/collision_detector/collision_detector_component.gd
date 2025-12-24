class_name CollisionDetectorComponent
extends RayCast2D


const _TILE_SIZE = 16.0  # TODO: Put this in a global autoload for constants

func would_collide(direction):
    target_position = direction * _TILE_SIZE
    force_raycast_update()

    return is_colliding()
