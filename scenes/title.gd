extends Node2D


func _on_button_pressed() -> void:
	print("START!")
	get_tree().change_scene_to_packed(preload("res://scenes/city.tscn"))
