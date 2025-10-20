extends CharacterBody2D
enum States {Idle, Dash, SignalDash}
var curr_state = States.Idle
var state_timer := 0.0

@export var dash_time := 0.2
@export var dash_signal_time := 0.5
@export var dash_speed := 1800.0
@onready var aim_line := $Line2D

var health := 10.0
var direction: Vector2

func _ready() -> void:
	aim_line.add_point(Vector2.ZERO)
	aim_line.add_point(Vector2.RIGHT * dash_speed * dash_time)
	aim_line.visible = false
	state_timer = randf_range(2.0, 4.0)
func _physics_process(delta: float) -> void:
	state_timer -= delta
	if state_timer <= 0.0:
		match curr_state:
			States.Idle:
				curr_state = States.SignalDash
				state_timer = dash_signal_time
				direction = (Global.player_position - global_position).normalized()
				aim_line.visible = true
				aim_line.look_at(direction + global_position)
			States.SignalDash:
				curr_state = States.Dash
				state_timer = dash_time
				velocity = direction * dash_speed * delta * 60 
				aim_line.visible = false
			States.Dash:
				curr_state = States.Idle
				state_timer = randf_range(2.0, 4.0)
				velocity = Vector2.ZERO
	
	move_and_slide()

func take_damage(damage: float):
	health -= damage
	print(health)
	if health <= 0.0:
		die()

func die():
	queue_free()
