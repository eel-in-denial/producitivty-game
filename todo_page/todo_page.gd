extends Control

@export var todo_list: VBoxContainer

@onready var edit_popup := $EditPopup
@export var edit_name: LineEdit
var todo_file = preload("res://todo_page/todo_item/todo_item.tscn")
var edit_index := 0

var curr_editing_item: TodoItem
var curr_editing_data := {}
var todo_items_data = []

func _ready() -> void:
	edit_popup.visible = false	

func init_tasks():
	for data in todo_items_data:
		create_item(data)

func open_edit_popup(todo_item: TodoItem = null, data := {"name": "", "coins": 5, "completed": false, "index": 0}):
	curr_editing_item = todo_item
	curr_editing_data = data
	edit_name.text = data["name"]
	edit_popup.visible = true
	get_tree().paused = true

func close_edit_popup():
	edit_popup.visible = false
	get_tree().paused = false
	curr_editing_data = {}
	curr_editing_item = null


func _on_add_item_pressed() -> void:
	open_edit_popup()
	

func _on_close_edit_pressed() -> void:
	close_edit_popup()


func _on_save_edit_pressed() -> void:
	curr_editing_data["name"] = edit_name.text
	if curr_editing_item == null:
		curr_editing_data["index"] = todo_items_data.size()
		todo_items_data.append(curr_editing_data)
		create_item(curr_editing_data)
	else:
		curr_editing_item.edit(curr_editing_data)
	close_edit_popup()
	
func create_item(data: Dictionary):
	var todo_item: TodoItem = todo_file.instantiate()
	todo_item.edit(data)
	todo_item.open_popup.connect(open_edit_popup)
	todo_item.delete_todo.connect(delete_item_data)
	todo_list.add_child(todo_item)

func delete_item_data(index: int):
	todo_items_data.pop_at(index)
