class_name BombSpawnerComponent
extends Node


const _TILE_SIZE = 16.0  # TODO: Put this in a global autoload for constants

signal bomb_exploded(coords)

@export var _actor: Node2D

var bomb_scene = preload("res://objects/bomb/bomb.tscn")

var _half_tile_size = 0.5 * _TILE_SIZE
var _half_tile_size_vector = Vector2(_half_tile_size, _half_tile_size)

var _live_bombs = []

func _input(event):
    if event.is_action_pressed("ui_accept"):
        _spawn_bomb()

func _spawn_bomb():
    var bomb = bomb_scene.instantiate()
    bomb.position = (_actor.position - _half_tile_size_vector).snappedf(_TILE_SIZE) + _half_tile_size_vector
    bomb.exploded.connect(_on_bomb_exploded)
    _live_bombs.append(bomb)

    var current_floor = _actor.get_parent()  # TODO: This should probably be done differently (maybe pass the current floor to player/actor to be sure the parent is actually a floor)
    current_floor.add_child(bomb)

func _on_bomb_exploded(bomb):
    GlobalSignals.bomb_exploded.emit(bomb.global_position)

    _live_bombs.erase(bomb)
    bomb.queue_free()
