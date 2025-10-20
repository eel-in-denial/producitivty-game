extends Resource
class_name CharacterData

enum Rarity {Apprentice, Mage, Archmage}

@export var name := ""
@export var rarity: Rarity = Rarity.Apprentice
@export var owned := 0
@export var sprite: Texture2D
@export var player_scene: PackedScene
