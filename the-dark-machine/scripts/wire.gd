class_name Wire extends Node2D

var source: ConnectableSource
var target: Node2D
@onready var line = $Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2.ZERO)

func _process(delta):
	var p1: Vector2
	var p2: Vector2
	if source and target:
		p1 = source.global_position
		p2 = target.global_position
	elif source or target:
		if source:
			p1 = source.global_position
		else:
			p1 = target.global_position
		p2 = get_global_mouse_position()
	
	if p1 and p2:
		line.set_point_position(0, to_local(p1))
		line.set_point_position(1, to_local(p2))

func equipment_connect(global_position: Vector2):
	process_mode = Node.PROCESS_MODE_INHERIT
	var space_state := get_world_2d().direct_space_state
	var query_params := PhysicsPointQueryParameters2D.new()
	query_params.collide_with_areas = true
	query_params.position = global_position
	var collisions := space_state.intersect_point(query_params)
	for c in collisions:
		var collider := c["collider"] as Node
		var connectable := collider.get_node_or_null("ConnectableSource") as ConnectableSource
		if connectable and connectable.wire_compatible:
			print("Can connect source to: ", connectable)
			source = connectable
			break
	#print("Connecting wire at ", global_position)
