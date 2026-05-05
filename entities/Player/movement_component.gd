extends Node
class_name MovementComponent

@export var ref_node: Node3D
@export var character: CharacterBody3D
@export var walking_speed = 5
@export var running_speed = 20

var jump_timer: Timer;

var _target_speed = walking_speed
var current_move_speed : float = walking_speed

var request_jump = false

var running = false
var has_jumped = false
var landed = false
var was_grounded = false

var movement_direction = Vector3.ZERO
var target_direction = Vector3.ZERO

signal on_run_end
signal on_jump_begin

var direction : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	jump_timer = Timer.new()
	jump_timer.wait_time = 0.1
	jump_timer.one_shot = true
	jump_timer.timeout.connect(jump)
	add_child(jump_timer)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	landed = false
	has_jumped = false
	handle_movement(delta)
	handle_jump()
	handle_sprint(delta)
	if (!character.is_on_floor()):
		character.velocity.y -= 50 * delta

	was_grounded = character.is_on_floor()

	character.move_and_slide()

	pass

func handle_movement(delta: float):
	var forward = -ref_node.transform.basis.z
	forward.y = 0
	var right = ref_node.transform.basis.x

	var axis = Input.get_vector( "left", "right", "down", "up")

	# character.velocity = axis.y * forward * current_move_speed
	# character.velocity = axis.x * right * current_move_speed
	
	target_direction = (axis.y * forward + axis.x * right).normalized()
	if target_direction != Vector3.ZERO:
		# movement_direction = movement_direction.move_toward(target_direction, 10*delta)
		var sum = target_direction * current_move_speed
		# character.velocity = character.velocity.move_toward(sum, 100*delta)
		character.velocity.x = move_toward(character.velocity.x, sum.x, 60 * delta)
		character.velocity.z = move_toward(character.velocity.z, sum.z, 60 * delta)
	elif character.is_on_floor():
		character.velocity.x = move_toward(character.velocity.x, 0, 50 * delta)
		character.velocity.z = move_toward(character.velocity.z, 0, 50 * delta)

	if (axis != Vector2.ZERO):
		direction = Vector2(target_direction.x, target_direction.z).normalized()


func handle_jump():
	if Input.is_action_just_pressed("jump") and character.is_on_floor() and !request_jump:
		request_jump = true
		on_jump_begin.emit()
		jump_timer.start()
	if character.is_on_floor():
		if !was_grounded:
			landed = true
	
func jump():
	has_jumped = true
	character.velocity.y += 20
	request_jump = false

func handle_sprint(delta: float):
	if Input.is_action_pressed("sprint"):
		_target_speed = running_speed
	if Input.is_action_just_released("sprint"):
		_target_speed = walking_speed

	current_move_speed = move_toward(current_move_speed, _target_speed, 70*delta)
	if current_move_speed >= running_speed - 0.1 && character.velocity.length() > 0.1:
		running = true
	else:
		if running:
			on_run_end.emit()
		running = false

func get_velocity():
	return character.velocity
