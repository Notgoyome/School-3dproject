extends Node

@export var spring_arm: SpringArm3D
@export var mouse_sensivity = 1
@export var look_down_max_angle = -80
@export var look_up_max_angle = 75

var CONST_MOUSE_SENSITVITY = 0.001

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		spring_arm.rotation.y -= event.relative.x * mouse_sensivity * CONST_MOUSE_SENSITVITY
		spring_arm.rotation.x -= event.relative.y * mouse_sensivity * CONST_MOUSE_SENSITVITY

		spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(look_down_max_angle), deg_to_rad(look_up_max_angle))
		spring_arm.rotation.y = fmod(spring_arm.rotation.y, 2*PI)

func get_forward_camera():
	return  -spring_arm.transform.basis.x
