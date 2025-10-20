extends Node2D

var spells_array := []
var spell_timers_array := []
@onready var spell_aim = $SpellAim
@export var spell_container: Node2D
var aiming := false

func init_spells(spells: Array):
	spells_array = spells
	for spell in spells:
		var spell_timer = Timer.new()
		spell_timers_array.append(spell_timer)
		add_child(spell_timer)

func _physics_process(delta: float) -> void:
	if aiming:
		spell_aim.update_aim()

func aim(spell: SpellData):
	print("sdiuhf")
	aiming = true
	spell_aim.aim(spell)

func cast(spell: SpellData):
	var loc_mouse_pos = get_local_mouse_position()
	aiming = false
	spell_aim.reset_aim()
	match spell.type:
		SpellData.Type.Ranged:
			var casting_spell: Spell = spell.scene.instantiate()
			casting_spell.initialise_spell(spell, loc_mouse_pos.normalized())
			spell_container.add_child(casting_spell)
			casting_spell.global_position = global_position
		SpellData.Type.RangedSpread:
			var angle = atan2(loc_mouse_pos.y, loc_mouse_pos.x) - (spell.spread_angle / 2)
			for i in range(spell.spread_num):
				var casting_spell: Spell = spell.scene.instantiate()
				casting_spell.initialise_spell(spell, Vector2(cos(angle), sin(angle)))
				spell_container.add_child(casting_spell)
				casting_spell.global_position = global_position
				angle += spell.spread_angle / (spell.spread_num - 1)
		SpellData.Type.RangedAOE:
			var casting_spell: Spell = spell.scene.instantiate()
			casting_spell.initialise_spell(spell)
			spell_container.add_child(casting_spell)
			casting_spell.global_position = global_position + get_local_mouse_position().limit_length(spell.range)
