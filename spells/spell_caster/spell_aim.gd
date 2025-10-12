extends Node2D
@onready var aim_line := $AimLine
@onready var range_line := $RangeLine
var curr_spell: SpellData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aim_line.visible = false
	range_line.visible = false


func aim(spell: SpellData):
	curr_spell = spell
	aim_line.visible = true
	var mouse_global_pos = get_global_mouse_position()
	match spell.type:
		SpellData.Type.Ranged:
			aim_line.add_point(Vector2.ZERO)
			aim_line.add_point(Vector2(spell.aim_length, 0))
			aim_line.look_at(mouse_global_pos)
		SpellData.Type.RangedSpread:
			var angle = - spell.spread_angle / 2
			for x in range(spell.spread_num):
				aim_line.add_point(Vector2.ZERO)
				aim_line.add_point(Vector2(spell.aim_length * cos(angle), spell.aim_length * sin(angle)))
				aim_line.add_point(Vector2.ZERO)
				angle += spell.spread_angle / (spell.spread_num - 1)
			aim_line.look_at(mouse_global_pos)
		SpellData.Type.RangedAOE:
			range_line.visible = true
			var resolution: int = 50
			for i in range(resolution + 1):
				var theta: float = 2*PI*i / resolution
				range_line.add_point(Vector2(spell.range*cos(theta), spell.range*sin(theta)))
			for i in range(resolution + 1):
				var theta: float = 2*PI*i / resolution
				aim_line.add_point(Vector2(spell.aoe_radius*cos(theta), spell.aoe_radius*sin(theta)))
				aim_line.position = get_local_mouse_position().limit_length(curr_spell.range)
				
			

func update_aim():
	var mouse_global_pos = get_global_mouse_position()
	match curr_spell.type:
		SpellData.Type.Ranged:
			aim_line.look_at(mouse_global_pos)
		SpellData.Type.RangedSpread:
			aim_line.look_at(mouse_global_pos)
		SpellData.Type.RangedAOE:
			aim_line.position = get_local_mouse_position().limit_length(curr_spell.range)

func reset_aim():
	range_line.visible = false
	range_line.clear_points()
	aim_line.visible = false
	aim_line.clear_points()
	aim_line.position = Vector2.ZERO
