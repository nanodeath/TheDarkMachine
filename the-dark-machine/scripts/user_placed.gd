class_name UserPlaced extends Node

signal returning

func return_equipment():
	emit_signal("returning")
	get_parent().queue_free()
