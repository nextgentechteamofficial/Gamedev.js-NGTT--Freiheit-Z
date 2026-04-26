extends Area2D
@export var fuel_amount := 10
@export var xp_amount := 2000
func civilian_drops() -> void:
	pass
func _ready() -> void:
	print("hi")


	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("collect_parts"):
			body.collect_parts(fuel_amount, xp_amount)
			queue_free()
