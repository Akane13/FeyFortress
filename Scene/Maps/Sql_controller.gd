extends Control

var database : SQLite
@onready var message = $Message_box/Message
@onready var login = $Login
@onready var sign_up = $Sign_Up
@onready var signup_username = $Sign_Up/VBoxContainer/username/username
@onready var signup_password = $Sign_Up/VBoxContainer/Password/Password
@onready var signup_confirm_password = $Sign_Up/VBoxContainer/Confirm_Password/Confirm_Password
@onready var login_username = $Login/VBoxContainer/Username/username
@onready var login_password = $Login/VBoxContainer/Password/Password

# Called when the node enters the scene tree for the first time.
func _ready():
	database = SQLite.new()
	database.path = "res://Fey_Fortress.db"
	database.open_db()
	pass

func _on_sign_up_pressed():
	var success = database.query("Select Count(*) from Users where username='"+signup_username.text+"'")
	if (signup_username.text!="" && signup_password.text!="" && signup_confirm_password.text!="") :
		if success:
			var count = database.query_result[0]
			#Attempt conversion to integer
			if int(count["Count(*)"]) > 0:
				$Timer.start()
				message.text = "Already exist that username"
				$Message_box.show()
			else:
				if signup_confirm_password.text != signup_password.text:
					$Timer.start()
					message.text = "Confirm password is not same as password"
					$Message_box.show()
				else:
					var data = {
						"username":signup_username.text,
						"password":signup_password.text 
					}
					
					database.insert_row("Users",data)
					$Timer.start()
					message.text = "Success"
					$Message_box.show()
		else:
				print("Error: Database query failed!")
	else:
		$Timer.start()
		message.text = "Please fill in all before proceed with register"
		$Message_box.show()

func _on_timer_timeout():
	$Message_box.hide()
	message.text = "Success"


func _on_login_pressed():
	var success = database.query("SELECT id, username, password FROM Users WHERE username ='"+ login_username.text + "' AND password ='" + login_password.text + "'")
	if (login_username.text!="" &&login_password.text!=""):
		if success:
			var check=database.query_result
			if len(check)<=0 :
				$Timer.start()
				message.text = "Incorrect Username or password"
				$Message_box.show()
			else:
				Global.user_id = check[0]["id"]
				print(Global.user_id) #check the user_id in console
				var a = get_tree().change_scene_to_file("res://Scene/UIScenes/mainmenu.tscn")
				#Checking error
				if a!=OK:
					push_error("Error while changing scene: %s" % str(a))
					
		else:
			print("Error: Database query failed!")
	else:
		$Timer.start()
		message.text = "Please fill in all before proceed with login"
		$Message_box.show()


func _on_register_pressed():
	login.hide()
	sign_up.show()

func _on_login_page_pressed():
	sign_up.hide()
	login.show()
