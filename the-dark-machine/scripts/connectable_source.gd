class_name ConnectableSource extends Node2D

## Can be connected using a wire
@export var wire_compatible: bool

signal connection_established(target: ConnectableTarget)
signal connection_lost(target: ConnectableTarget)

func connect_to(target: ConnectableTarget):
	emit_signal("connection_established", target)

func disconnect_from(target: ConnectableTarget):
	emit_signal("connection_lost", target)
