extends Control

var database : SQLite
@onready var message = $Message

# Called when the node enters the scene tree for the first time.
func _ready():
	database = SQLite.new()
	database.path = "res://Fey_Fortress.db"
	database.open_db()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_sign_up_pressed():
	var success = database.query("Select Count(*) from Users where username='"+$Sign_Up/VBoxContainer/username/username.text+"'")
	if success:
		var count = database.query_result[0]
		#Attempt conversion to integer
		if int(count["Count(*)"]) > 0:
			$Timer.start()
			message.text = "Already exist that username"
			message.show()
		else:
			if $Sign_Up/VBoxContainer/Confirm_Password/Confirm_Password.text != $Sign_Up/VBoxContainer/Password/Password.text:
				$Timer.start()
				message.text = "Confirm password is not same as password"
				message.show()
			else:
				var data = {
					"username":$Sign_Up/VBoxContainer/username/username.text,
					"password":$Sign_Up/VBoxContainer/Password/Password.text 
				}
				
				database.insert_row("Users",data)
				$Timer.start()
				message.text = "Success"
				message.show()
				
	else:
		print("Error: Database query failed!")

func _on_timer_timeout():
	message.hide()
	message.text = "Success"


func _on_login_pressed():
	var success = database.query("SELECT id, username, password FROM Users WHERE username ='"+ $Login/VBoxContainer/Username/username.text + "' AND password ='" + $Login/VBoxContainer/Password/Password.text + "'")
	if success:
		var check=database.query_result
		if len(check)<=0 :
			$Timer.start()
			message.text = "Incorrect Username or password"
			message.show()
		else:
			Global.user_id = check[0]["id"]
			print(Global.user_id)
			var a = get_tree().change_scene_to_file("res://Scene/UIScenes/mainmenu.tscn")
			#Checking error
			if a!=OK:
				push_error("Error while changing scene: %s" % str(a))
				
	else:
		print("Error: Database query failed!")
