class_name ConnectableTarget extends Node2D

## Can be connected using a wire
@export var wire_compatible: bool

signal activated

func activate():
	emit_signal("activated")
