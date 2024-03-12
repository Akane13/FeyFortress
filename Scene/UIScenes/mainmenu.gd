extends Control

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _ready():
	print(Global.user_id) # can check in console whether the useer id match with the database
#New game button pressed
func _on_new_game_pressed():
	var a = get_tree().change_scene_to_file("res://Scene/Maps/Map1.tscn")
	
	#Checking error
	if a!=OK:
		push_error("Error while changing scene: %s" % str(a))

#quit button pressed
func _on_quit_pressed():
	get_tree().quit()

#Option button press
func _on_option_pressed():
	$Option.show()

func _on_back_pressed():
	$Option.hide()

func _on_audio_stream_player_2d_finished():
	audio_stream_player_2d.play()
