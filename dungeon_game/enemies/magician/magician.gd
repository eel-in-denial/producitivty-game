extends CharacterBody2D
var health := 10.0
var speed := 100

var tik_duration := 0.2
var tik_timer := 0.0
var next_action_tik := 10
@onready var signal_eye := $Polygon2D

enum States {Idle, Cast1, Cast2, Cast3, PreCast}
var curr_state = States.Idle

@export var spell_caster: Node2D
var spell_1: SpellData = load("res://spells/spell_data/fireball.tres")
var spell_2: SpellData = load("res://spells/spell_data/ice_shards.tres")
var spell_3: SpellData = load("res://spells/spell_data/tornado.tres")
var spells: Array[SpellData] = [spell_1, spell_2, spell_3]

func _physics_process(delta: float) -> void:
	if tik_timer <= 0:
		match curr_state:
			States.Idle:
				signal_eye.color = Color(randf(), randf(), randf())
				next_action_tik -= 1
				if next_action_tik <= 0:
					curr_state = States.PreCast
			States.PreCast:
				pass
			
		tik_timer = tik_duration
	tik_timer -= delta
	
func take_damage(damage: float):
	health -= damage
	print(health)
	if health <= 0.0:
		die()

func die():
	queue_free()
