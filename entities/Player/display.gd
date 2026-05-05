extends Node3D
@export var movement_component: MovementComponent

func _ready():
	pass # Replace with function body.


func _process(delta):
	var direction = movement_component.direction
	var angle = atan2(direction.x, direction.y)
	rotation.y = lerp_angle(rotation.y, angle, 8.0*delta)
	pass
