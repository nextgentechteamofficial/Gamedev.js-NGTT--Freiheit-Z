extends Area2D

@export var speed = 200
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var collision_shape_2d_riggedbody: CollisionShape2D = $RigidBody2D/CollisionShape2D
@export var explosion_scale := 5
@export var timer_time = 1
@onready var timer: Timer = $Timer
@export var damage = 50
@export var attack_cost := 15.0

var has_exploded = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = timer_time # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if (has_exploded == false):
		pass
	collision_shape_2d.global_position = collision_shape_2d_riggedbody.global_position

	


func _on_body_entered(body: Node2D) -> void:
	var scale_factor := Vector2(explosion_scale, explosion_scale)
	if body.is_in_group("Player"):
		pass
	else:
		if (body.is_in_group("civilians")):
			if body.has_method("set_damage"):
		
				body.set_damage(damage)
				
			if body.has_method("start_dps_timer"):
				
				body.start_dps_timer()
				
			
		if (has_exploded == false):
			
			collision_shape_2d.apply_scale(scale_factor)
			has_exploded = true
			timer.start()
			
		
		


func _on_timer_timeout() -> void:
	queue_free()# Replace with function body.
