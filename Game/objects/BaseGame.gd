extends Node2D

signal loose

var paused = false

func set_paused(p):
	paused = p
	if(paused):
		pause_mode = PAUSE_MODE_STOP
	else:
		pause_mode = PAUSE_MODE_PROCESS

func _ready():
	set_paused(paused)
