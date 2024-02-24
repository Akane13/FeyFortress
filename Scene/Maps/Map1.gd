extends Node2D


# Called when the node enters the scene tree for the first time.
func pause():
	get_tree().paused=true
	$pause_menu.show()
	$Pause.hide()
	$UI.hide()
	$Towers.hide()

func unpause():
	$pause_menu.hide()
	get_tree().paused=false
	$Pause.show()
	$UI.show()
	$Towers.show()
