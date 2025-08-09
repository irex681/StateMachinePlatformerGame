class_name Player extends CharacterBody2D

@export var gravity: float = 2000.0
@export var max_y_velocity: float = 600.0
@export var hang_gravity: float = 10.0
@export var max_x_velocity: float = 400
var x_velocity: float
@export var walking_x_acceleration: float = 80
@export var falling_x_acceleration: float = 40
@export var jump_speed: float = 600

@export var level: TileMapLayer

@onready var statelabel: Label = $Statelabel

signal touching_red

var collisionpos: Vector2
var celllocationfordraw: Vector2

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D =  get_last_slide_collision()
	if collision != null:
		var tilecollided: TileMapLayer = get_last_slide_collision().get_collider()
		#ver centerpos 
		
		var celllocation: Vector2 = collision.get_position()
		
		print(celllocation)
		
		
		
			
		
		var cellhit: Vector2i = level.local_to_map(celllocation)	
		
		print(is_on_wall(),get_wall_normal())
		
			
		if is_on_wall():
			if get_wall_normal().x == -1 :
				cellhit = cellhit
			if get_wall_normal().x == 1 :
				cellhit = cellhit + Vector2i(-1,-1)
		if is_on_ceiling():
			cellhit = cellhit + Vector2i(0,-1)
			
		celllocationfordraw = cellhit * 16 + Vector2i(8,8)
		
		get_parent().queue_redraw()
		
		if tilecollided.get_cell_atlas_coords(cellhit) == Vector2i(0,0):
			tilecollided.set_cell(cellhit,0,Vector2i(1,0)) # replacing the hit tile
		if tilecollided.get_cell_atlas_coords(cellhit) == Vector2i(1,1):
			tilecollided.set_cell(cellhit,0,Vector2i(2,0))
		
		var cellhitdata: TileData = level.get_cell_tile_data(cellhit)
		if cellhitdata !=null:
			if (cellhitdata.get_custom_data("onTouchLose")):
				emit_signal("touching_red")
