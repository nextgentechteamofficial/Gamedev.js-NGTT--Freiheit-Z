extends CharacterBody2D


@export var speed = 300.0
@onready var timer: Timer = $Timer
var direction := 1

func _physics_process(delta: float) -> void:
	
	

	
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	
	move_and_slide()


func _on_timer_timeout() -> void:
	direction *= -1
	
	var timer_wait_time := randi_range(1,10)
	print(timer_wait_time)
	timer.wait_time = timer_wait_time
	timer.start()
	
	
	
