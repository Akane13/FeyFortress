extends Node2D

@onready var path= preload("res://Scene/Maps/path_map1.tscn")

func _on_timer_timeout():
	var tempPath = path.instantiate()
	add_child(tempPath)
