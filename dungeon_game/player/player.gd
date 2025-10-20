extends CharacterBody2D


@export var speed := 300.0
@export var dash_speed := 800.0
@export var dash_time := 0.17
@export var dash_cooldown := 1.0
@export var health := 100.0
@export var health_bar: ProgressBar

@export var spell_caster: Node2D
@onready var pointer := $Pointer
enum State {Running, Dashing, KnockedBack}
var current_state: State = State.Running
var spell_1: SpellData = load("res://spells/spell_data/fireball.tres")
var spell_2: SpellData = load("res://spells/spell_data/ice_shards.tres")
var spell_3: SpellData = load("res://spells/spell_data/tornado.trSes")
var spells: Array[SpellData] = [spell_1, spell_2, spell_3]

var spell_timers: Array[float] = [0.0, 0.0, 0.0]
var aiming_spell: SpellData = null

var direction: Vector2
var prev_direction: Vector2
var mouse_global_position: Vector2

var dash_timer := 0.0
var dash_cooldown_timer := 0.0
var can_dash := true

var knock_back_timer := 0.0

signal dead

func _ready() -> void:
	health_bar.max_value = health
	health_bar.value = health

func _physics_process(delta: float) -> void:
	Global.player_position = global_position
	
	mouse_global_position = get_global_mouse_position()
	pointer.look_at(mouse_global_position)
	
	for timer in range(3):
		if spell_timers[timer] > 0.0:
			spell_timers[timer] -= delta
	
	match current_state:
		State.Dashing:
			dash_timer -= delta
			if dash_timer <= 0:
				exit_dash()
		State.Running:
			var direction := Input.get_vector("left", "right", "up", "down")
			if direction:
				prev_direction = direction
				velocity = direction * speed
			else:
				velocity = velocity.move_toward(Vector2.ZERO, speed)
			if dash_cooldown_timer > 0:
				dash_cooldown_timer -= delta
				if dash_cooldown_timer <= 0:
					dash_cooldown_timer = 0
					can_dash = true
		State.KnockedBack:
			knock_back_timer -= delta
			velocity = velocity.move_toward(Vector2.ZERO, 2000 * delta)
			if knock_back_timer <= 0.0:
				current_state = State.Running
			
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action("dash") and can_dash:
		dash()
	elif event.is_action_pressed("spell_1") and spell_timers[0] <= 0.0:
		spell_caster.aim(spell_1)
		aiming_spell = spell_1
	elif event.is_action_pressed("spell_2") and spell_timers[1] <= 0.0:
		spell_caster.aim(spell_2)
		aiming_spell = spell_2
	elif event.is_action_pressed("spell_3") and spell_timers[2] <= 0.0:
		spell_caster.aim(spell_3)
		aiming_spell = spell_3
	elif event.is_action_released("spell_1") and aiming_spell == spell_1:
		spell_caster.cast(spell_1)
		spell_timers[0] = spells[0].cooldown
		aiming_spell = null
	elif event.is_action_released("spell_2") and aiming_spell == spell_2:
		spell_caster.cast(spell_2)
		spell_timers[1] = spells[1].cooldown
		aiming_spell = null
	elif event.is_action_released("spell_3") and aiming_spell == spell_3:
		spell_caster.cast(spell_3)
		spell_timers[2] = spells[2].cooldown
		aiming_spell = null

func dash():
	current_state = State.Dashing
	velocity = prev_direction*dash_speed
	dash_timer = dash_time
	can_dash = false
	
func exit_dash():
	current_state = State.Running
	velocity = Vector2.ZERO
	dash_timer = 0.0
	dash_cooldown_timer = dash_cooldown

func take_damage(damage: int):
	health -= damage
	health_bar.value = health


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		#body.knock_back()
		knock_back((global_position - body.global_position).normalized())
		health -= 5
		health_bar.value = health
		if health <= 0:
			dead.emit()

func knock_back(direction: Vector2):
	current_state = State.KnockedBack
	knock_back_timer = 0.4
	velocity = direction * 600.0
