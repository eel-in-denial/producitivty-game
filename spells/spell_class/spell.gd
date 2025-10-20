extends Area2D
class_name Spell
var direction := Vector2.ZERO
var speed := 0.0
var damage := 0.0
var death_timer := 0.0
var velocity
var tik_timer := 0.0
var tik_timer_set := 0.0

var enemies_in_body: Array[CharacterBody2D] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func initialise_spell(spell_data: SpellData, dir := Vector2.ZERO):
	direction = dir
	speed = spell_data.speed
	damage = spell_data.base_damage
	death_timer = spell_data.death_timer
	velocity = speed * direction
	tik_timer_set = spell_data.tik_timer
	tik_timer = tik_timer_set

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and body not in enemies_in_body:
		enemies_in_body.append(body)
	on_body_hit(body)

func _on_body_exited(body: Node2D) -> void:
	if body in enemies_in_body:
		enemies_in_body.erase(body)
	
func on_body_hit(body: Node2D):
	print("hit ", body)
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		die()

func count_tik(delta: float):
	tik_timer -= delta
	if tik_timer <= 0.0:
		tik_timer = tik_timer_set
		on_tik(delta)
		
func on_tik(delta: float):
	pass
		
func count_death_timer(delta: float):
	death_timer -= delta
	if death_timer <= 0:
		die()

func move(delta: float):
	global_position += velocity * delta

func die():
	queue_free()
