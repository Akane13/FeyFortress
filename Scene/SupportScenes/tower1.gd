extends StaticBody2D

@onready var container=$BulletContainer
var bullet= preload("res://Scene/SupportScenes/bullet.tscn")
var bulletDamage= 2
var pathName
var currTargets = []
var curr

var reload=0
var range=560

@onready var timer = get_node("Upgrade/ProgressBar/Timer")
var startShooting = false

func _process(_delta):
	get_node("Upgrade/ProgressBar").global_position = self.position + Vector2(-48,56)
	if is_instance_valid(curr):
		if timer.is_stopped():
			timer.start()
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()
	
	upgrade_powers()

func shoot():
	var tempBullet= bullet.instantiate()
	tempBullet.pathName=pathName
	tempBullet.bulletDamage = bulletDamage
	get_node("BulletContainer").call_deferred("add_child",tempBullet)
	tempBullet.global_position =$Aim.global_position

func _on_tower_body_entered(body):
	if "enemy1" in body.name:
		var tempArray= []
		currTargets = get_node("Tower").get_overlapping_bodies()
		
		for i in currTargets:
			if "enemy" in i.name:
				tempArray.append(i)
				
		var currTarget= null
		
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget= i.get_node("../")
		
		curr=currTarget
		pathName=currTarget.get_parent().name
		
		shoot()

func _on_tower_body_exited(_body):
	currTargets = get_node("Tower").get_overlapping_bodies()


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node("Map1/Towers")
		for i in towerPath.get_child_count():
			if towerPath.get_child(i).name != self.name:
				towerPath.get_child(i).get_node("Upgrade/Upgrade").hide()
		get_node("Upgrade/Upgrade").visible = !get_node("Upgrade/Upgrade").visible
		get_node("Upgrade/Upgrade").global_position = self.position + Vector2(-162,20)


func _on_timer_timeout():
	shoot()


func _on_attack_speed_pressed():
	if reload<=2:
		reload+=0.1
	timer.wait_time = 3 - reload

func _on_power_pressed():
	bulletDamage+=1

func _on_range_pressed():
	range +=30

func upgrade_powers():
	$Upgrade/Upgrade/HBoxContainer/Attack_Speed/Label.text = str(3-reload)
	$Upgrade/Upgrade/HBoxContainer/Power/Label.text = str(bulletDamage)
	$Upgrade/Upgrade/HBoxContainer/Range/Label.text = str(range)
	
	$Tower/CollisionShape2D.shape.radius =range

func _on_range_mouse_entered():
	$Tower/CollisionShape2D.show()


func _on_range_mouse_exited():
	$Tower/CollisionShape2D.hide()
