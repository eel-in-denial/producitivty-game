extends Panel
class_name  TodoItem

signal delete_todo(index: int)
signal open_popup(todo_item: TodoItem, data: Dictionary)
signal todo_toggled(data: Dictionary)

@export var coin_amount := 5
@export var name_label: Label
var list_index := 0
var item_data := {"name": "", "coins": 5, "completed": false, "index": 0}
var initializing := true
# Called when the node enters the scene tree for the first time.

func edit(data := {"name": "", "coins": 5, "completed": false, "index": 0}):
	item_data = data
	name_label.text = item_data["name"]
	coin_amount = item_data["coins"]
	list_index = item_data["index"]
	$MarginContainer/Panel/CheckBox.button_pressed = item_data["completed"]
	$MarginContainer/Panel/Coins.text = "Coins: " + str(coin_amount)
	initializing = false


func _on_check_box_toggled(toggled_on: bool) -> void:
	if not initializing:
		if toggled_on:
			Global.coins += coin_amount
			item_data["completed"] = true
		else:
			Global.coins -= coin_amount
			item_data["completed"] = false
		todo_toggled.emit(item_data)


func _on_delete_pressed() -> void:
	delete_todo.emit(item_data["index"])
	queue_free()


func _on_edit_pressed() -> void:
	open_popup.emit(self, item_data)
