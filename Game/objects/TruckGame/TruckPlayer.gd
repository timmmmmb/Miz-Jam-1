extends KinematicBody2D


export (int) var speed = 100

var velocity = Vector2()
var position_up = true
var is_animating = false

func get_input():
	var change_lane = Input.is_action_just_pressed('change_lane')
	if change_lane && !is_animating:
		if position_up:
			$Tween.interpolate_property(self, "position:y", 8, 40, 1, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
		else:
			$Tween.interpolate_property(self, "position:y", 40, 8, 1, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
		position_up = !position_up
		$Tween.interpolate_callback(self, $Tween.get_runtime(), "_stop_animating")
		is_animating = true
		$Tween.start()
	velocity.x = speed

func _physics_process(delta):
	get_input()
	var collision = move_and_collide(velocity*delta)
	
func _stop_animating():
	is_animating = false
