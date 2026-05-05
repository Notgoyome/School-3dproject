extends Node3D

@export var display_node: Node3D
var alpha = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	alpha += delta
	if alpha > 2*PI:
		alpha -= 2*PI
	var offset = cos(alpha) * 0.1

	display_node.transform.origin.y = offset
	display_node.rotation.y = alpha
	pass
