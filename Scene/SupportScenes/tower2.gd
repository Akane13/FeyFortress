extends StaticBody2D

@onready var container=$BulletContainer
var bullet= preload("res://Scene/SupportScenes/bullet.tscn")
var bulletDamage= 3
var update_limit = 2
var update_gold = 5
var pathName
var currTargets = []
var curr

var reload=0
var range= 200
@onready var timer = get_node("Upgrade/ProgressBar/Timer")
var startShooting = false

func _physics_process(_delta: float) -> void:
	get_node("Upgrade/ProgressBar").global_position = self.position + Vector2(-48,56)
	if is_instance_valid(curr):
		if timer.is_stopped():
			shoot()
			timer.start()
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()
			
	upgrade_level()
	
func _on_tower_2_body_entered(body):
	if "enemy1" in body.name:
		var tempArray= []
		currTargets = get_node("Tower2").get_overlapping_bodies()
		
		for i in currTargets:
			if "enemy1" in i.name:
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
		

func _on_tower_2_body_exited(_body):
	currTargets = get_node("Tower2").get_overlapping_bodies()

func shoot():
	var tempBullet= bullet.instantiate()
	tempBullet.pathName=pathName
	tempBullet.bulletDamage = bulletDamage
	$BulletContainer.call_deferred("add_child",tempBullet)
	tempBullet.global_position =$Aim.global_position

func upgrade_level():
	pass

func _on_timer_timeout():
	shoot()


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node("Map1/Towers")
		for i in towerPath.get_child_count():
			if towerPath.get_child(i).name != self.name:
				towerPath.get_child(i).get_node("Upgrade/Upgrade").hide()
		get_node("Upgrade/Upgrade").visible = !get_node("Upgrade/Upgrade").visible
		get_node("Upgrade/Upgrade").global_position = self.position + Vector2(-30,-120)

func _on_upgrade_pressed():
	if update_limit >0:
		if Global.Gold >= update_gold:
			update_limit-=1
			if update_limit==1:
				bulletDamage+=1
				range+=15
				reload-=0.2
				timer.wait_time = 3 - reload
				
				Global.Gold-= update_gold
				update_gold += 5
				$"Tower2(phrase_2)".show()
				$"Tower2(phrase_1)".hide()
			elif update_limit==0:
				bulletDamage+=2
				range+=15
				reload-=0.4
				timer.wait_time = 3 - reload
				
				Global.Gold-= update_gold
				$"Tower2(phrase_3)".show()
				$"Tower2(phrase_2)".hide()

func _on_upgrade_mouse_entered():
	$Tower2/CollisionShape2D.show()

func _on_upgrade_mouse_exited():
	$Tower2/CollisionShape2D.hide()

func _on_delete_pressed():
	queue_free()
