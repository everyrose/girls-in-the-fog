extends Node2D

@onready var player_scene = preload("res://scenes/player.tscn") as PackedScene
@onready var enemy_scene = preload("res://scenes/enemy.tscn") as PackedScene

# network code
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

# menu
@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEntry

var STEAM_ID

func _ready():
		# steam integration
	var INIT: Dictionary = Steam.steamInit()
	print("Did Steam initialize?: "+str(INIT))
	var TICKET = Steam.getAuthenticationStatus()
	print(TICKET)
	Steam.connect("get_auth_session_ticket_response",test)
	Steam.connect("lobby_created", _on_lobby_created)
	Steam.connect("overlay_toggled", _overlay_Toggled)
	
	var IS_ONLINE: bool = Steam.loggedOn()
	STEAM_ID = Steam.getSteamID()
	var IS_OWNED: bool = Steam.isSubscribed()
	print("Is online:", IS_ONLINE)
	print("Steam ID:", STEAM_ID)
	print("Is owned:", IS_OWNED)
	
	print("Trying to create lobby")
	
	Steam.createLobby(Steam.LOBBY_TYPE_PUBLIC, 3);

	
	if IS_OWNED == false:
		print("User does not own this game")
		get_tree().quit()
	
	
	var enemy = enemy_scene.instantiate() as CharacterBody2D;
	enemy.position.x  = -50
	enemy.position.y = 60
	
	add_child(enemy)
	
	pass 
	
#func _overlay_Toggled(is_toggled: bool):
#	print("Overlay toggled: "+str(is_toggled))
	
func _overlay_Toggled(is_toggled: bool) -> void: 
	print("Overlay toggled: "+str(is_toggled))
	
	
func _on_lobby_created(connect: int, lobby_id: int):
	print("on lobby created")
	print(lobby_id)
	print(lobby_id)
	print(lobby_id)



func test(r):
	print("steam connected")
	print(r)



func _process(delta):
	# steam integration
	Steam.run_callbacks()
	
	pass


func _on_host_button_pressed():
	main_menu.hide()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	
	multiplayer.peer_connected.connect(add_player)
	
	add_player(multiplayer.get_unique_id())

	pass # Replace with function body.


func _on_join_button_pressed():
	main_menu.hide()
	enet_peer.create_client("193.93.219.107", PORT)
#	enet_peer.create_client("149.90.141.138", PORT)
#	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer
	print(IP.get_local_addresses())

	pass # Replace with function body.
	
func add_player(peer_id):
	print(peer_id);
	
	var player = player_scene.instantiate() as CharacterBody2D;
	player.position.x = -60
	player.position.y = -60;
	player.name = str(peer_id)

	add_child(player);
	print(player.position)


func _on_join_button_2_pressed():
	print("is overlay enabled")
	print(Steam.isOverlayEnabled())
	print("show overlay")
	print(STEAM_ID)
	Steam.activateGameOverlayInviteDialog(STEAM_ID)
	pass # Replace with function body.
