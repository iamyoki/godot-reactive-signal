extends CanvasLayer

@onready var decrease: Button = $HBoxContainer/Decrease
@onready var count_label: Label = $HBoxContainer/CountLabel
@onready var increase: Button = $HBoxContainer/Increase
@onready var brief: Label = $Brief


var count = ReactiveSignal.new(0)
var clicked_times = ReactiveSignal.new(0)

func _ready() -> void:
	# bind event to update value
	decrease.pressed.connect(_on_decrease_preseed)
	increase.pressed.connect(_on_increase_preseed)
	
	# update UI
	ReactiveSignal.use_effect(func():
		count_label.text = str(count.value)
		brief.text = 'You have clicked %d times, current value is %d' % [clicked_times.value, count.value]
	)

func _on_decrease_preseed():
	count.value -= 1
	clicked_times.value += 1
	
func _on_increase_preseed():
	count.value += 1
	clicked_times.value += 1
