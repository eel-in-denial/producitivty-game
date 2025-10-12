extends Spell

var pull_force: float = 85

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	count_death_timer(delta)
	count_tik(delta)
	for enemy in enemies_in_body:
		enemy.global_position += (global_position - enemy.global_position).normalized() * pull_force * delta

func on_body_hit(body: Node2D):
	pass

func on_tik(delta: float):
	for enemy in enemies_in_body:
		enemy.take_damage(damage)
