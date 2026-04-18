extends CharacterBody2D


@export var speed = 500.0
@export var jump_velocity = -400.0
@onready var ray_cast_2d: RayCast2D = $RayCast2D
const PROJECTILE = preload("uid://dbnijstff0fso")


func aiming(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	ray_cast_2d.target_position = mouse_pos
	var blast := PROJECTILE.instantiate()
	blast.position = ray_cast_2d.target_position
	get_parent().add_child(blast)
	


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Move Left ", "Move Right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	var up_direction := Input.get_axis("Move Up" , "Move Down")
	if up_direction:
		velocity.y = up_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
		
	aiming(delta)
	move_and_slide()
