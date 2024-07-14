class_name Game extends Node2D

@export var next_level: PackedScene

func go_to_next_level():
	get_tree().change_scene_to_packed(next_level)
