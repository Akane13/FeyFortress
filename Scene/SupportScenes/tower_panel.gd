extends Panel

@onready var tower=preload("res://Scene/SupportScenes/tower1.tscn")
var  currTile

func _on_gui_input(event):
	var tempTower = tower.instantiate()
	
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(tempTower)
		tempTower.global_position = event.global_position
		tempTower.process_mode=Node.PROCESS_MODE_DISABLED
		
		tempTower.scale=Vector2(0.9,0.9)
	elif event is InputEventMouseMotion and event.button_mask ==1:
		#Left click down and drag
		if get_child_count()>1:
			get_child(1).global_position=event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0:
		var drop_pos = get_child(1).global_position # were we want the tower
		
		if event.global_position.y <=64:
			get_child(1).queue_free()
		else:
			if get_child_count() >1:
				get_child(1).queue_free()
			var path = get_tree().get_root().get_node("Map1/Towers")
			path.add_child(tempTower)
			# temp_tower.global_position = event.global_position
			tempTower.global_position = drop_pos
			tempTower.get_node("area").hide()
	else:
		if get_child_count()>1:
			get_child(1).queue_free()
