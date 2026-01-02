extends Node2D


signal exploded(bomb)

func _on_timer_timeout():
    exploded.emit(self)
