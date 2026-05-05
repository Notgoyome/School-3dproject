extends Node3D
@export var movement_component: MovementComponent
var can_rotate = true
func _ready():
	pass # Replace with function body.


func _process(delta):
	if !(can_rotate):
		return
	var direction = movement_component.direction
	var angle = atan2(direction.x, direction.y)
	rotation.y = lerp_angle(rotation.y, angle, 8.0*delta)
	pass

func instant_rotate():
	print("instant rotate")
	var direction = movement_component.direction
	var angle = atan2(direction.x, direction.y)
	rotation.y = angle