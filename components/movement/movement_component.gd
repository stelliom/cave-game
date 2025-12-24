class_name MovementComponent
extends Node

# TODO: Add a state manager for different movement states (idle, walk, run, turn, on_stairs, ...)
# TODO: Add RayCast component for collisions and connect it to this

const _TILE_SIZE = 16.0  # TODO: Put this in a global autoload for constants

@export var _actor: Node2D
@export var _animated_sprite: AnimatedSprite2D
@export var _collision_detector_component: CollisionDetectorComponent
@export var _walk_speed = 4.0 * _TILE_SIZE

var _is_idle = true
var _current_direction = Vector2.ZERO
var _previous_direction = Vector2.ZERO
var _pixels_towards_next_tile = 0.0

var _previous_position


func _physics_process(delta):
    if _is_idle:
        # TODO: Should this be pulled out to an input component, so that we can
        #       use this component also for enemies that don't use keyboard inputs?
        _update_direction()
        
        if _current_direction != Vector2.ZERO:
            _previous_position = _actor.position

            _is_idle = false
            if is_instance_valid(_collision_detector_component):
                _is_idle = _collision_detector_component.would_collide(_current_direction)

    if !_is_idle:
        _move(delta)

func _process(_delta):
    if is_instance_valid(_animated_sprite):
        _animate()

func _update_direction():
    var tmp = _current_direction

    if _current_direction.y == 0:
        _current_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

    if _current_direction.x == 0:
        _current_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

    if _current_direction != tmp:
        _previous_direction = tmp

func _move(delta):
    _pixels_towards_next_tile += _walk_speed * delta
    if _pixels_towards_next_tile >= _TILE_SIZE or is_equal_approx(_pixels_towards_next_tile, _TILE_SIZE):
        _actor.position = _previous_position + _TILE_SIZE * _current_direction
        _pixels_towards_next_tile = 0.0
        _is_idle = true
    else:
        _actor.position = _previous_position + _pixels_towards_next_tile * _current_direction

func _animate():
    var animation_name
    if _current_direction == Vector2.ZERO:
        animation_name = "idle_" + direction_to_string(_previous_direction)
    else:
        animation_name = "walk_" + direction_to_string(_current_direction)

    if _animated_sprite.animation != animation_name:
        _animated_sprite.play(animation_name)

func direction_to_string(direction):
    if direction == Vector2.DOWN:
        return "down"
    elif direction == Vector2.UP:
        return "up"
    elif direction == Vector2.LEFT:
        return "left"
    elif direction == Vector2.RIGHT:
        return "right"
    else:
        return "down"
