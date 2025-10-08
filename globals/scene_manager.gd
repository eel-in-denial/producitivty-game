extends Node2D

var curr_scene_list = []
var transition_data: Dictionary

func _ready() -> void:
	await get_tree().process_frame
	curr_scene_list.append(get_tree().current_scene)
	print("Initial current_scene set to: ", curr_scene_list[0].name)

func temp_scene_switch(scene: Node, data := {}):
	if data:
		transition_data = data
	get_tree().root.remove_child(curr_scene_list[0])
	curr_scene_list.push_front(scene)
	get_tree().root.add_child(scene)
	print("Initial current_scene set to: ", curr_scene_list[0].name)

func return_from_temp(data := {}):
	curr_scene_list.pop_front().queue_free()
	get_tree().root.add_child(curr_scene_list[0])
