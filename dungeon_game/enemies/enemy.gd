extends CharacterBody2D
class_name Enemy
var health := 10.0
var speed := 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity = (Global.player_position - global_position).normalized() * speed * delta * 60
	move_and_slide()

func take_damage(damage: float):
	health -= damage
	print(health)
	if health <= 0.0:
		die()

func die():
	queue_free()
