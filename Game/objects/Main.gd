extends HBoxContainer
onready var jumpgame = get_node("VBoxContainer/ViewportContainer1/Viewport/JumpGame")
onready var squidgame = get_node("VBoxContainer/ViewportContainer2/Viewport/SquidGame")
onready var truckgame = get_node("VBoxContainer2/ViewportContainer1/Viewport/TruckGame")
onready var dodgegame = get_node("VBoxContainer2/ViewportContainer2/Viewport/DodgeGame")
onready var games = [jumpgame, squidgame, truckgame, dodgegame]
var starttime = OS.get_ticks_msec()

func _ready():
	get_tree().paused = true
	restart()

func loose():
	for game in games:
		game.pause_mode = PAUSE_MODE_STOP

func restart():
	for game in games:
		game.pause_mode = PAUSE_MODE_STOP
	jumpgame.pause_mode = PAUSE_MODE_PROCESS
	starttime = OS.get_ticks_msec()

func _process(_delta):
	if(jumpgame.pause_mode == PAUSE_MODE_STOP && Input.is_action_just_pressed('restart')):
		get_tree().reload_current_scene()
		restart()
