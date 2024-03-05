extends Node2D

var menu = load("res://Scene/UIScenes/mainmenu.tscn")
# Called when the node enters the scene tree for the first time.
var database : SQLite

func _ready():
	Global.Health=10
	Global.Gold=90
	Global.score=0
	
	database = SQLite.new()
	database.path = "res://Fey_Fortress.db"
	database.open_db()

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
	$pause_menu/Option_settings.show()

func _physics_process(_delta):
	if Global.Health==0:
		get_tree().paused=true
		$UILayer/Game_Over.show()
		var success = database.update_rows("Users","id= '" + str(Global.user_id) +"'", {"game_score" : int(Global.score)})
		if !success:
			print("Error: Database query failed!")

func _on_quit_pressed():
	get_tree().paused=false
	var a = get_tree().change_scene_to_packed(menu)
	if a!=OK:
		push_error("Error while changing scene: %s" % str(a))


func _on_back_pressed():
	$pause_menu/Option_settings.hide()
