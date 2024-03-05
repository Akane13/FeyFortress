extends Panel

@onready var tower=preload("res://Scene/SupportScenes/tower2.tscn")
var currTile

func _on_gui_input(event):
	#check the gold is enough or not it not then the tower won't be deployed
	if Global.Gold>=20:
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
				
				var mapPath=get_tree().get_root().get_node("Map1/ground")
				var tile=mapPath.local_to_map(get_global_mouse_position())
				currTile=mapPath.get_cell_atlas_coords(0,tile,false)
				var targets=get_child(1).get_node("tower_detector").get_overlapping_bodies()
				
				if (currTile >= Vector2i(0,0) && currTile <= Vector2i(4,0)):
					if (targets.size() > 0):
						get_child(1).get_node("area").modulate= Color(255,255,255,0.3)
					else:
						get_child(1).get_node("area").modulate= Color(0,255,0,0.3)
				else:
					get_child(1).get_node("area").modulate= Color(255,255,255,0.3)
					
		elif event is InputEventMouseButton and event.button_mask == 0:
			var drop_pos = get_child(1).global_position # were we want the tower
			if (event.global_position.x >=1164 || event.global_position.y<=64):
				get_child(1).queue_free()
			else:
				if get_child_count() >1:
					get_child(1).queue_free()
				if (currTile >= Vector2i(0,0) && currTile <= Vector2i(4,0)):
					var path = get_tree().get_root().get_node("Map1/Towers")
					var targets=get_child(1).get_node("tower_detector").get_overlapping_bodies()
					if (targets.size() < 1):
						path.add_child(tempTower)
						tempTower.global_position = drop_pos
						tempTower.get_node("area").hide()
						
						#game gold subtract 
						Global.Gold -=20
		else:
			if get_child_count()>1:
				get_child(1).queue_free()
