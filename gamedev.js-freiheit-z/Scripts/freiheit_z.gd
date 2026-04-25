extends CharacterBody2D

@onready var freiheit_z: CharacterBody2D = $"."
@export var speed = 500.0
@export var jump_velocity = -400.0
@onready var ray_cast_2d: RayCast2D = $RayCast2D
const PROJECTILE = preload("uid://dbnijstff0fso")
const GRENADE = preload("uid://bmun4t8ibvmye")
const AXE = preload("uid://csb56d5flb8vd")


@export var fuel = 100.0
@export var fuel_usagerate = 2.0
@onready var timer: Timer = $Timer
@export var lvl_max := 3
@export var xp_needed := 2000
@onready var treiheit_axe: Node2D = $treiheit_axe
var current_lvl := 1
var current_xp := 0
func handle_current_weapons() -> void:
	pass
func collect_parts(fuel_amount: float, xp_amount: int) -> void:
	current_xp += xp_amount
	fuel += fuel_amount
	
func lvl_up() -> void:
	if (current_xp >= xp_needed and current_lvl < lvl_max):
		print("leveled up")
		current_xp -= xp_needed
		current_lvl += 1
func grenade_shot() -> void:
	var mouse_pos = get_local_mouse_position()
	ray_cast_2d.target_position = mouse_pos
	if (is_shooting()):
		var grenade := GRENADE.instantiate()
		if fuel < grenade.attack_cost:
			grenade.free()
			return
		fuel -= grenade.attack_cost
		var direction = (get_global_mouse_position() - global_position).normalized()
		grenade.position = global_position
		grenade.global_rotation = direction.angle()
		get_parent().add_child(grenade)
func aiming(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	ray_cast_2d.target_position = mouse_pos
	if (is_shooting()):
		var blast := PROJECTILE.instantiate()
		if fuel < blast.attack_cost:
			blast.free()
			return
		fuel -= blast.attack_cost
		var direction = (get_global_mouse_position() - global_position).normalized()
		blast.position = global_position
		blast.global_rotation = direction.angle()
		get_parent().add_child(blast)
		
		
func _ready() -> void:
	treiheit_axe = AXE.instantiate()
	add_child(treiheit_axe)

func axe_attack() -> void:
	
	if is_melee():
		treiheit_axe.animated_sprite_2d.visible = true
		treiheit_axe.collision_shape_2d.visible = true
		treiheit_axe.start_timer()
		if fuel < treiheit_axe.axe_cost:
			
			
			return
		fuel -= treiheit_axe.axe_cost
		
	var offset := Vector2(40,-30)
	var new_position := Vector2((offset.x + global_position.x), (offset.y + global_position.y))
	treiheit_axe.global_position = new_position
func is_shooting() -> bool:
	var is_shooting = false
	if (Input.is_action_just_pressed("Attack")):
		is_shooting = true
	else:
		is_shooting = false
	return is_shooting
	
func is_melee() -> bool:
	var is_melee = false
	if (Input.is_action_just_pressed("Melee")):
		is_melee = true
	else:
		is_melee = false
	return is_melee

func _physics_process(delta: float) -> void:
	print(fuel)
	lvl_up()
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
	grenade_shot()
	axe_attack()
	fuel_system()
	fuel_death()
	move_and_slide()

func fuel_system() -> void:
	if timer.is_stopped():
		timer.start()
		
func fuel_death() -> void:
	if (fuel < 0):
		queue_free()

func _on_timer_timeout() -> void:
	fuel -= fuel_usagerate
