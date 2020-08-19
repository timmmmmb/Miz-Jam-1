extends "res://objects/BaseGame.gd"

var Section1 = preload("res://objects/TruckGame/TruckSection1.tscn")
var Section2 = preload("res://objects/TruckGame/TruckSection2.tscn")
var Section3 = preload("res://objects/TruckGame/TruckSection3.tscn")
var Section4 = preload("res://objects/TruckGame/TruckSection4.tscn")

var possible_sections = [Section1, Section2, Section3, Section4]
const SECTION_WIDTH = 448
var section_offset = -116

var sections = []

func _ready():
	randomize()
	start_game()

func start_game():
	spawn_section(false)
	spawn_section(false)
	spawn_section()
	
func spawn_section(random_index = true):
	var sectionIndex = 0
	if random_index:
		sectionIndex = randi() % 4
	var section = possible_sections[sectionIndex].instance()
	call_deferred("add_child", section)
	call_deferred("move_child",section, 0)
	section.position.x = section_offset
	section_offset += SECTION_WIDTH
	section.get_node("Visibility").connect("screen_exited", self, "out_of_bounds")
	sections.append(section)
	
func out_of_bounds():
	sections[0].queue_free()
	sections.remove(0)
	spawn_section()


func _on_TruckPlayer_collide():
	print("Truck Game lost")
	emit_signal("loose")


func _on_Timer_timeout():
	$TruckPlayer/Camera/Tutorial.visible = false
