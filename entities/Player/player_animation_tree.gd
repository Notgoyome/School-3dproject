extends AnimationTree

var locomotion_blend = "parameters/StateMachine/Locomotion/blend_position"
var speed_scale = "parameters/GeneralScale/scale"
var is_begin_jump = false
var request_jump = false
var landed = false

@export var movement_component: MovementComponent
@export var debug: AnimationPlayer

func _ready():
	movement_component.on_jump_begin.connect(play_jump_animation)
	pass


func _process(delta):
	var speed = Vector2(movement_component.get_velocity().x, movement_component.get_velocity().z).length()
	self[locomotion_blend] = speed

	landed = movement_component.landed
	if movement_component.running:
		self[speed_scale] = 1.0 + (speed-10)*0.05
	else:
		self[speed_scale] = 1.0

func play_jump_animation():
	var play_back = self.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback
	if movement_component.running:
		play_back.travel("run_jump")
	else:
		play_back.travel("jump")
