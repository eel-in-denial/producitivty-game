extends Node2D
var enemy = preload("res://dungeon_game/enemies/enemy.tscn")
var spawn_timer_set := 5.0
var spawn_timer := spawn_timer_set


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer <= 0.0:
		spawn_enemies(1)
		spawn_timer = spawn_timer_set

func spawn_enemies(num: int):
	for i in range(num):
		var x = 0.0
		var y = 0.0
		match randi_range(1, 4):
			1:
				x = -700
				y = randf_range(-400, 400)
			2:
				x = randf_range(-700, 700)
				y = -400
			3:
				x = 700
				y = randf_range(-400, 400)
			4:
				x =randf_range(-700, 700)
				y = 400
		create_enemy(Vector2(x, y) + Global.player_position)

func create_enemy(pos: Vector2):
	var new_enemy = enemy.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = pos
