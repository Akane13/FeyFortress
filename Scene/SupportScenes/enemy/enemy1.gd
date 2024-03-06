extends CharacterBody2D

@export var speed = 100
var Health = 10
@onready var Path= get_parent()

func _physics_process(delta):
	Path.progress += speed * delta
	
	if Path.get_progress_ratio() ==1:
		Global.Health -= 1
		death()
	
	if Health<=0:
		Global.Gold += 1
		Global.score+=25
		death()
		

func death():
	Path.get_parent().queue_free()
