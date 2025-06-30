extends Button

var item_name
signal change(value)

func _ready():
	text = Global.item[item_name].name
	emit_signal("change", "_on_pressed")


func _on_pressed() -> void:
	if Global.item.has(item_name):
		Global.item[item_name]["effect"].call()
		emit_signal("change")
	else:
		print("tidak ada efek")		
	pass # Replace with function body.
