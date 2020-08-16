extends Node2D


var Ink = preload("res://objects/SquidGame/SquidInk.tscn")
var timeBetween = 1
var current_ink

func _ready():
	randomize()
	start_game()

func start_game():
	spawn_ink()
	

func spawn_ink():
	if is_instance_valid(current_ink):
		return
	$SquidPlayer/Timer.start()
	current_ink = Ink.instance()
	current_ink.position = Vector2(rand_range(20,220), rand_range(20, 120))
	add_child(current_ink)
	current_ink.connect("body_entered", self, "remove_ink")
	
func remove_ink(_body):
	if current_ink:
		current_ink.queue_free()
		$InkTimer.start()
		$SquidPlayer/Timer.stop()


func _on_InkTimer_timeout():
	spawn_ink()


func _on_Timer_timeout():
	pass # you lost
