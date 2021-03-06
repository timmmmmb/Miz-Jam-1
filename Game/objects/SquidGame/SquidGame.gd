extends "res://objects/BaseGame.gd"

var Ink = preload("res://objects/SquidGame/SquidInk.tscn")
var current_ink
var possible_colors = [
	Color8(203, 255, 0),
	Color8(204, 0, 255),
	Color8(255, 0, 110),
	Color8(0, 255, 102),
	Color8(204, 0, 255)
]
var timeBetween = 3
var ink_time = 5


func _ready():
	randomize()
	start_game()


func start_game():
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	spawn_ink()


func spawn_ink():
#	if is_instance_valid(current_ink):
#		return
	$SquidPlayer/Timer.wait_time = ink_time
	$SquidPlayer/Timer.start()
	current_ink = Ink.instance()
	current_ink.position = Vector2(rand_range(20, 220), rand_range(20, 120))
	add_child(current_ink)
	current_ink.get_node("InkTexture").material.set_shader_param(
		"color", possible_colors[randi() % possible_colors.size()]
	)
	current_ink.connect("body_entered", self, "remove_ink")


func remove_ink(body):
	if is_instance_valid(current_ink):
		body._change_color(current_ink.get_node("InkTexture").material.get_shader_param("color"))
		current_ink.queue_free()
		$InkTimer.wait_time = timeBetween
		$InkTimer.start()
		$SquidPlayer/Timer.stop()
		$InkRefill.play()


func _on_InkTimer_timeout():
	spawn_ink()


func _on_Timer_timeout():
	print("Squid Game lost")
	emit_signal("loose")


func _on_TutorialTimer_timeout():
	$Tutorial.visible = false
