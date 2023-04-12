extends CharacterBody2D


@export var speed: int = 4000


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var label = $Label as Label
var player_name = ""

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())
	player_name = str(name)

	

func _ready():
	if not is_multiplayer_authority(): return
	label.text = player_name
	print("---")
	# todo: fix later
	position.x = -60
	position.y = -60

	print(position)

func handleMovement(delta):
	var move_direction = Input.get_vector("left","right","top","bottom")
	velocity = move_direction * speed * delta

func _physics_process(delta):
	if not is_multiplayer_authority(): return
	
	handleMovement(delta)
	move_and_slide();


func _on_multiplayer_synchronizer_synchronized():
	print("synced:")
	print("")
	pass # Replace with function body.
