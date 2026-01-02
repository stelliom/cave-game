class_name BombSpawnerComponent
extends Node


const _TILE_SIZE = 16.0  # TODO: Put this in a global autoload for constants

@export var _actor: Node2D

var bomb_scene = preload("res://objects/bomb/bomb.tscn")

var _half_tile_size = 0.5 * _TILE_SIZE
var _half_tile_size_vector = Vector2(_half_tile_size, _half_tile_size)

func _input(event):
    if event.is_action_pressed("ui_accept"):
        var bomb = bomb_scene.instantiate()
        bomb.position = (_actor.position - _half_tile_size_vector).snappedf(_TILE_SIZE) + _half_tile_size_vector

        var parent = _actor.get_parent()
        #var walls = parent.get_node("WallsLayer")
        #bomb.exploded.connect(walls.on_bomb_exploded)
        parent.add_child(bomb)
