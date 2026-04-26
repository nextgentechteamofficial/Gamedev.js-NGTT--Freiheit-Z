extends ProgressBar
@onready var timer: Timer = $Timer
@onready var useage_bar: ProgressBar = $UseageBar

var health := 0.0 : set = _set_health

func _set_health(new_health: float):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	
	if health < prev_health:
		timer.start()
	else:
		useage_bar.value = health	
func init_health(_health: float):
	health = _health
	max_value = _health
	value = _health
	useage_bar.max_value = _health
	useage_bar.value = _health


func _on_timer_timeout() -> void:
	useage_bar.value = health
