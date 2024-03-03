extends Node2D

var menu = load("res://Scene/UIScenes/mainmenu.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	Global.Health=10
	Global.Gold=90
	Global.score=0

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


func _on_option_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().paused=false
	var a = get_tree().change_scene_to_packed(menu)
	if a!=OK:
		push_error("Error while changing scene: %s" % str(a))
