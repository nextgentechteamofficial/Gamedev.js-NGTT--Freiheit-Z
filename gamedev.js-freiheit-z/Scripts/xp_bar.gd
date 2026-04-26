extends ProgressBar
@onready var timer: Timer = $Timer
@onready var useage_bar: ProgressBar = $UseageBar
@onready var rich_text_label: RichTextLabel = $RichTextLabel

var health := 0.0 : set = _set_health

func _set_health(new_health: float):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	rich_text_label.text = str(int(health))
	
	
	if health < prev_health:
		timer.start()
	else:
		useage_bar.value = health	
func init_health(_health: float, _max_value: float):
	health = _health
	max_value = _max_value
	value = _health
	useage_bar.max_value = _max_value
	useage_bar.value = _health


func _on_timer_timeout() -> void:
	useage_bar.value = health
