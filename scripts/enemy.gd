extends CharacterBody2D


const SPEED = 1000.0

#@onready var navigation_agent = $NavigationAgent2D as NavigationAgent2D
@onready var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
@onready var line = get_tree().get_first_node_in_group("playerLine") as Line2D

func _ready():
	pass


func _physics_process(delta):
#	navigation_agent.target_position = player.global_position
#
#
#	if not navigation_agent.is_navigation_finished():
#		var movement_delta = SPEED * delta
#		var current_agent_position = global_position
#		var next_path_position = $NavigationAgent2D.get_next_path_position()
#
#		line.clear_points()
#
#
#		for i in $NavigationAgent2D.get_current_navigation_path():
#			line.add_point(i)
#
#		velocity = (next_path_position - position).normalized() * movement_delta
#		print("velocity:")
#		print(velocity)
#		move_and_slide()
	pass
		
func on_path_changed() -> void:
	pass

