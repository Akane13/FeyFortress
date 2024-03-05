extends Control

var menu = load("res://Scene/UIScenes/mainmenu.tscn")
var database : SQLite

# Called when the node enters the scene tree for the first time.
func _ready():
	database = SQLite.new()
	database.path = "res://Fey_Fortress.db"
	database.open_db()
	pass

func _physics_process(_delta):
	$Score.text = "Score : \n" + str(Global.score)
	
func _on_quit_pressed():
	get_tree().paused=false
	database.close_db()
	var a = get_tree().change_scene_to_packed(menu)
	if a!=OK:
		push_error("Error while changing scene: %s" % str(a))
