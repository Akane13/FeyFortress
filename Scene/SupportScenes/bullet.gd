extends CharacterBody2D

var target
var Speed = 1000
var pathName = ""
var bulletDamage

@onready var bullet = $Bullet
@onready var explosion = $explosion


func _physics_process(_delta: float) -> void:
	var pathSpawnerNode= get_tree().get_root().get_node("Map1/PathSpawner")
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position
			
	if target:
		velocity = global_position.direction_to(target) * Speed
		look_at(target)
		move_and_slide()
	else:
		queue_free()

func _on_area_2d_body_entered(body):
	if "enemy1" in body.name:
		body.Health -=bulletDamage
		bullet.hide()
		explosion.show()
		explosion.play("explosion")


func _on_explosion_animation_finished():
	queue_free()
