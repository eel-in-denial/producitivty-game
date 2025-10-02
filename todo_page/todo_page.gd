extends Control

@export var todo_list: VBoxContainer

@onready var edit_popup := $EditPopup
@export var edit_name: LineEdit
var todo_file = preload("res://todo_page/todo_item/todo_item.tscn")
var edit_todo_item: TodoItem

var todo_items_array: Array[TodoItem] = []

func _ready() -> void:
	Global.open_popup.connect(open_edit_popup)
	edit_popup.visible = false

func open_edit_popup(data := {"name": "", "coins": 5, "todo_item": null}):
	if data["todo_item"] == null:
		edit_todo_item = todo_file.instantiate()
	else:
		edit_todo_item = data["todo_item"]
	edit_name.text = data["name"]
	edit_popup.visible = true
	get_tree().paused = true

func close_edit_popup():
	edit_popup.visible = false
	get_tree().paused = false


func _on_add_item_pressed() -> void:
	open_edit_popup()
	

func _on_close_edit_pressed() -> void:
	close_edit_popup()


func _on_save_edit_pressed() -> void:
	var text = edit_name.text
	close_edit_popup()
	if edit_todo_item in todo_items_array:
		todo_list.add_child(edit_todo_item)
	edit_todo_item.edit(text)

func delete_item(item: TodoItem):
	todo_items_array.erase(item)
