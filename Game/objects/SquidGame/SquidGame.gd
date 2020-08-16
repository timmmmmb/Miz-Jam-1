extends Node2D


var Ink = preload("res://objects/SquidGame/SquidInk.tscn")
var timeBetween = 1
var current_ink
var possible_colors = [	Color8(203, 255, 0),Color8(204, 0, 255),Color8(255, 0, 110),Color8(0, 255, 102),Color8(204, 0, 255)]

func _ready():
	randomize()
	start_game()

func start_game():
	spawn_ink()
	

func spawn_ink():
#	if is_instance_valid(current_ink):
#		return
	$SquidPlayer/Timer.start()
	current_ink = Ink.instance()
	current_ink.position = Vector2(rand_range(20,220), rand_range(20, 120))
	add_child(current_ink)
	current_ink.get_node("InkTexture").material.set_shader_param("color", possible_colors[randi() % possible_colors.size()])
	current_ink.connect("body_entered", self, "remove_ink")

func remove_ink(body):
	if is_instance_valid(current_ink):
		body.get_node("Sprite").material.set_shader_param("color", current_ink.get_node("InkTexture").material.get_shader_param("color"))
		current_ink.queue_free()
		$InkTimer.start()
		$SquidPlayer/Timer.stop()


func _on_InkTimer_timeout():
	spawn_ink()


func _on_Timer_timeout():
	pass # you lost

