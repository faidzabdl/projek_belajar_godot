extends Button

var item_name
var qty
signal change(value)
signal habis

func _ready():
	text = Global.item[item_name].name
	emit_signal("change", "_on_pressed")


func _on_pressed() -> void:
	if Global.item.has(item_name):
		if Global.item[item_name]["qty"] > 1:
			Global.item[item_name]["effect"].call()
			emit_signal("change")
			Global.item[item_name]["qty"] -= 1
		else:
			print("habis")	
			emit_signal("habis")
			queue_free()
	else:
		print("tidak ada efek")		
	pass # Replace with function body.
