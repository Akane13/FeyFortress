extends CanvasLayer

@onready var health = $Health
@onready var gold = $Gold
@onready var score = $Score

func _process(_delta):
	#get data from global.gd (global variable)
	health.text = "Health : " + str(Global.Health)
	gold.text = "Gold : " + str(Global.Gold)
	score.text = "Score : " + str(Global.score)
