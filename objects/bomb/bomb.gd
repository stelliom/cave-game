extends Node2D


signal exploded(coords)

func _on_timer_timeout():
    exploded.emit(global_position)
    print("BOOM")
    queue_free()
