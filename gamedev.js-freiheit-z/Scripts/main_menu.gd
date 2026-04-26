extends Node2D

var button_type = null

func _on_start_pressed() -> void:
	button_type = "start"
	$ColorRect.show()
	$ColorRect/fade_timer.start()
	$ColorRect/AnimationPlayer.play("Fade_in")
	


func _on_quit_pressed() -> void:
	button_type = "quit"
	$ColorRect.show()
	$ColorRect/fade_timer.start()
	$ColorRect/AnimationPlayer.play("Fade_out")
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://Scenes/Level1 Map.tscn")
	
