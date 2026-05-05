extends CPUParticles3D

@export var movement_component: MovementComponent
@export var character: CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (character.is_on_floor() and movement_component.running):
		emitting = true
	else:
		emitting = false
	pass
