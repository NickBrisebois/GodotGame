extends KinematicBody2D

onready var tween = $Tween
export var speed = 3

var is_moving = false

enum DIRECTIONS {
	RIGHT,
	LEFT,
	UP,
	DOWN,
	IDLE,
}

var tile_size = 16
var inputs = {
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN,
}

var last_dir 	= DIRECTIONS.IDLE
var current_dir = DIRECTIONS.IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	#position = position.snapped(Vector2.ONE * tile_size)
	#position+= Vector2.ONE * tile_size/2
	pass

func _input(event):
	if event is InputEventKey and !is_moving:
		match event.scancode:
			KEY_RIGHT:
				last_dir = current_dir
				current_dir = DIRECTIONS.RIGHT
				move(Vector2.RIGHT)
			KEY_LEFT:
				last_dir = current_dir
				current_dir = DIRECTIONS.LEFT
				move(Vector2.LEFT)
			KEY_UP:
				last_dir = current_dir
				current_dir = DIRECTIONS.UP
				move(Vector2.UP)
			KEY_DOWN:
				last_dir = current_dir
				current_dir = DIRECTIONS.DOWN
				move(Vector2.DOWN)
	else:
		current_dir = DIRECTIONS.IDLE

func move(dir):
	$RayCast2D.cast_to = dir * tile_size
	$RayCast2D.force_raycast_update()
	if !$RayCast2D.is_colliding():
		move_tween(dir)

# Move in a fancy way
func move_tween(dir):
	tween.interpolate_property(self,
							"position",
							position,
							position + dir * tile_size,
							1.0/speed,
							Tween.TRANS_SINE,
							Tween.EASE_IN_OUT,
							0)
	tween.start()

func _process(_delta):
	is_moving = tween.is_active()

	if is_moving:
		match current_dir:
			DIRECTIONS.RIGHT:
				$Sprite.play("WalkRight")
			DIRECTIONS.LEFT:
				$Sprite.play("WalkLeft")
			DIRECTIONS.UP:
				$Sprite.play("WalkUp")
			DIRECTIONS.DOWN:
				$Sprite.play("WalkDown")
	elif current_dir == DIRECTIONS.IDLE:
		if last_dir == DIRECTIONS.DOWN:
			$Sprite.play("WalkUp")
		else:
			$Sprite.play("Idle")

