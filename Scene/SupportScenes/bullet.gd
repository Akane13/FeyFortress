extends CharacterBody2D

var target
var Speed = 1000
var pathName = ""
var bulletDamage
@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	var pathSpawnerNode= get_tree().get_root().get_node("Map1/PathSpawner")
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position
			
	velocity=global_position.direction_to(target) *Speed
	
	look_at(target)
	move_and_slide()
	

func _on_area_2d_body_entered(body):
	if "enemy1" in body.name:
		body.Health -=bulletDamage
		animated_sprite_2d.animation="explosion"
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.animation="bullet"
		queue_free()
