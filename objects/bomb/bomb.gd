extends Node2D

@onready var area = $Area2D
@onready var timer = $Timer

signal exploded(coords)


func _on_timer_timeout():
    exploded.emit(global_position)
    queue_free()
