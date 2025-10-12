extends Resource
class_name  SpellData
enum Type {Ranged, RangedAOE, RangedSpread, SelfAOE}


@export var spell_name: String
@export var icon: Texture2D
@export var type: Type
@export var cooldown: float
@export var base_damage: float
@export var speed: float
@export var scene: PackedScene
@export var sound: AudioStream
@export var death_timer: float = 5.0

@export_group("aim properties")
@export var aim_length := 200.0


@export_category("type properties")
@export var range: float 

@export_group("ranged spread")
@export var spread_num: int
@export var spread_angle_deg: float:
	set(value):
		spread_angle_deg = value
		spread_angle = value * PI / 180
var spread_angle

@export_group("aoe")
@export var aoe_radius: float
@export var tik_timer: float
