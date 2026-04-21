extends CharacterBody2D


@export var speed = 300.0
@export var health = 100.0
@onready var timer: Timer = $Timer
@onready var dps_timer: Timer = $"dps timer"
var damage = 0
var direction := 1
const MACHINE_PARTS = preload("uid://gciiw2pycb1i")

@export var collectible: PackedScene =MACHINE_PARTS
func _physics_process(delta: float) -> void:
	die()
	
	

	
	
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
	print(health)

func die() -> void:
	if (health < 0.5):
		print("one guy died")
		queue_free()


func _on_dps_timer_timeout() -> void:
	take_damage()
func start_dps_timer() -> void:
	if (dps_timer.is_stopped()):
		dps_timer.start()
func set_damage(damage2: int) -> void:
	damage = damage2
	

	
