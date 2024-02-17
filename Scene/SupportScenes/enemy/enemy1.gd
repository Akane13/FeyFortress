extends CharacterBody2D

@export var speed = 100

func _physics_process(delta):
	get_parent().progress += speed * delta
	
	if get_parent().get_progress_ratio() ==1:
		queue_free()
