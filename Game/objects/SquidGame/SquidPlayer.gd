extends KinematicBody2D

var velocity = Vector2()
export (int) var run_speed = 100
var particle = preload("res://objects/SquidGame/Particles.tscn")
onready var prev_particles = get_node("Sprite/Particles")

func get_input():
	velocity.x = 0
	velocity.y = 0
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
		
	if left:
		velocity.x -= run_speed
	if right:
		velocity.x += run_speed
	if up:
		velocity.y -= run_speed
	if down:
		velocity.y += run_speed
		
	if velocity.x > 0:
		if velocity.y > 0:
			rotation_degrees = 135
		elif velocity.y < 0:
			rotation_degrees = 45
		else:
			rotation_degrees = 90
	elif velocity.x < 0:
		if velocity.y > 0:
			rotation_degrees = -135
		elif velocity.y < 0:
			rotation_degrees = -45
		else:
			rotation_degrees = -90
	else:
		if velocity.y > 0:
			rotation_degrees = 180
		elif velocity.y < 0:
			rotation_degrees = 0

func _physics_process(_delta):
	get_input()
	$Sprite.animation = "swim"
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
func _change_color(color):
	$Sprite.material.set_shader_param("color", color)
	var newparticles = particle.instance()
	newparticles.process_material = prev_particles.process_material.duplicate()
	add_child(newparticles)
	prev_particles.emitting = false
	newparticles.process_material.color = color
	prev_particles = newparticles
