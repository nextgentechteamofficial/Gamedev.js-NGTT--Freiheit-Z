extends Node2D

func _ready() -> void:
	$CanvasLayer/ColorRect/AnimationPlayer.play("Fade_out")
