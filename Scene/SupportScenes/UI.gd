extends CanvasLayer

@onready var health = $Hp/Health
@onready var gold = $Money/Gold
@onready var score = $Score

func _process(_delta):
	#get data from global.gd (global variable)
	health.text = str(Global.Health) + " / 10"
	gold.text = str(Global.Gold) 
	score.text = str(Global.score)
