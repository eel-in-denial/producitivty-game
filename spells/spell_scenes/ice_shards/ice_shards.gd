extends Spell

func _physics_process(delta: float) -> void:
	count_death_timer(delta)
	move(delta)
