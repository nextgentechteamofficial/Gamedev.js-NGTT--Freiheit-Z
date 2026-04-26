extends CharacterBody2D



@export var speed = 300.0
@export var health = 100.0
@onready var timer: Timer = $Timer
@onready var dps_timer: Timer = $"dps timer"
@export var gravity_strength := 30
var damage = 0
var direction := 1
var has_dropped := false
var is_dead :=false
const MACHINE_PARTS = preload("uid://gciiw2pycb1i")
@onready var fuel_bar: ProgressBar = $FuelBar


func _ready() -> void:
	fuel_bar.init_health(health)
func drop_machine_parts() -> void:
	
	if is_dead and not has_dropped:
		has_dropped = true
		var machine_parts = MACHINE_PARTS.instantiate()
		machine_parts.position = global_position
		get_tree().current_scene.add_child(machine_parts)
		if (machine_parts.has_method("civilian_drops")):
			machine_parts.civilian_drops()
func gravity(delta: float) -> void:

	if not is_on_floor():
		velocity.y += gravity_strength * delta
func _physics_process(delta: float) -> void:
	if is_dead:
		return
	die()
	gravity(delta)
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	
	move_and_slide()


func _on_timer_timeout() -> void:
	direction *= -1


	var timer_wait_time := randi_range(1,10)
	timer.wait_time = timer_wait_time
	timer.start()
	
	
	
func take_damage() -> void:
	
	health -= damage
	fuel_bar.health = health


func die() -> void:
	if (health < 0.5):
		
		is_dead = true
		dps_timer.stop()
		drop_machine_parts()
		queue_free()


func _on_dps_timer_timeout() -> void:
	take_damage()
	dps_timer.start()
func start_dps_timer() -> void:
	dps_timer.start()
func set_damage(damage2: int) -> void:
	damage += damage2

func remove_damage(damage2: int) -> void:
	damage -= damage2
	if damage <= 0:
		damage = 0
		dps_timer.stop()
	

	
