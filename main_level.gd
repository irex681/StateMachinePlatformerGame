extends Node2D

@onready var player_spawn_point: Marker2D = $PlayerSpawnPoint
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var player: Player = $Player

func _ready() -> void:

	player.connect("touching_red", respawn_player)
	player.position = player_spawn_point.position

func respawn_player():
	player.position = player_spawn_point.position
	

	


func _draw() -> void:
	draw_circle($Player.celllocationfordraw, 12, Color.DARK_BLUE)
