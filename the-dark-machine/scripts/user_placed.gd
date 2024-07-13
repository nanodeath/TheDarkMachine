class_name UserPlaced extends Node

signal returning

func return_equipment():
	emit_signal("returning")
	if is_inside_tree():
		# Might be getting freed imminently, e.g. wire
		get_parent().queue_free()
