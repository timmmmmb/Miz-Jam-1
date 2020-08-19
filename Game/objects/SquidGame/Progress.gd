extends Node2D

func _draw():
	if(get_parent().get_node("SquidPlayer/Timer").time_left != 0):
		draw_circle_arc_poly(get_parent().get_node("SquidPlayer").position+Vector2(0, -25), 8, 0, (get_parent().get_node("SquidPlayer/Timer").time_left*PI*2)/get_parent().get_node("SquidPlayer/Timer").wait_time, Color8(0,0,150))
	else:
		draw_circle_arc_poly(get_parent().get_node("SquidPlayer").position+Vector2(0, -25), 8, 0, 2*PI, Color8(0,0,150))
						
func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = angle_from + i * (angle_to - angle_from) / nb_points - PI/2
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

func _process(_delta):
	update()
