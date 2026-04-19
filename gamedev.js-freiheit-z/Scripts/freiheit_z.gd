extends CharacterBody2D

@onready var freiheit_z: CharacterBody2D = $"."
@export var speed = 500.0
@export var jump_velocity = -400.0
@onready var ray_cast_2d: RayCast2D = $RayCast2D
const PROJECTILE = preload("uid://c2qdn0wcuswvm")


func aiming(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	ray_cast_2d.target_position = mouse_pos
	if (is_shooting()):
		var blast := PROJECTILE.instantiate()
		var direction = (get_global_mouse_position() - global_position).normalized()
		blast.position = global_position
		blast.global_rotation = direction.angle()
		get_parent().add_child(blast)
		
		

func is_shooting() -> bool:
	var is_shooting = false
	if (Input.is_action_just_pressed("Attack")):
		is_shooting = true
	else:
		is_shooting = false
	return is_shooting
	


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
