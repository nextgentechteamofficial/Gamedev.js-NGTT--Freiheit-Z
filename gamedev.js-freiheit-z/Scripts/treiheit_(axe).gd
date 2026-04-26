extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@export var axe_cost: float = 10.0
@export var damage: int = 100
@export var timer_time := 1

func _ready() -> void:
	collision_shape_2d.disabled = true
	animated_sprite_2d.visible = false
	timer.wait_time = timer_time
	
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("civilians"):
		print("200 pump")
		if body.has_method("set_damage"):
			body.set_damage(damage)
		if body.has_method("start_dps_timer"):
			body.start_dps_timer()
	


func _on_timer_timeout() -> void:
	animated_sprite_2d.visible = false
	collision_shape_2d.disabled = true

func start_timer() -> void:
	if timer.is_stopped():
		timer.start()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("civilians"):
		if body.has_method("remove_damage"):
			body.remove_damage(damage)
