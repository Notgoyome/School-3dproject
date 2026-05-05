extends SpringArm3D

@export var movement_component: MovementComponent
@onready var camera: Camera3D = $Camera3D
var base_length
# Called when the node enters the scene tree for the first time.
func _ready():
	base_length = spring_length
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = movement_component.get_velocity()
	var speed = velocity.length()
	if speed > movement_component.walking_speed + 0.1:
		spring_length = lerp(spring_length, base_length + (speed-10)*0.1, 5*delta)
		camera.fov = lerp(camera.fov,80.0, 5*delta)
		position.y = lerp(position.y, 2.0, 5*delta)
	else:
		spring_length = lerp(spring_length, base_length, 10*delta)
		camera.fov = lerp(camera.fov,70.0, 5*delta)
		position.y = lerp(position.y, 1.0, 5*delta)


	pass
