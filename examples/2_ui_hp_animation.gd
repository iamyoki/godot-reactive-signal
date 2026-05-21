extends CanvasLayer

@onready var hp_label: Label = $HBoxContainer/HPLabel
@onready var hpbg: ProgressBar = $HBoxContainer/HPClip/HPBG
@onready var hp_fill_slower: ProgressBar = $HBoxContainer/HPClip/HPFillSlower
@onready var hp_fill: ProgressBar = $HBoxContainer/HPClip/HPFill
@onready var hp_value_label: Label = $HBoxContainer/HPClip/HPValue
@onready var damage_button: Button = $DamageButton
@onready var heal_button: Button = $HealButton

@export var max_hp: float = 999.0
@export var damage_value: float = 99.0
@export var heal_value: float = 88.0
 
var hp = ReactiveSignal.new(max_hp)
var tw: Tween

func _ready() -> void:
	damage_button.pressed.connect(_on_damage_pressed)
	heal_button.pressed.connect(_on_heal_pressed)
	
	ReactiveSignal.use_effect(func():
		hp_value_label.text = str(int(hp.value))
	)
	
	ReactiveSignal.use_effect(func():
		if tw and tw.is_running():
			tw.kill()
		tw = get_tree().create_tween().set_parallel(true)
		tw.tween_property(hp_fill, 'value', hp.value/max_hp*100, .2)
		if hp_fill_slower.value < hp_fill.value:
			tw.tween_property(hp_fill_slower, 'value', hp.value/max_hp*100, .2)
		else:
			tw.tween_property(hp_fill_slower, 'value', hp.value/max_hp*100, .5).set_delay(.2)
	)

func _on_damage_pressed():
	var next_hp = hp.value - damage_value
	hp.value = next_hp if next_hp > 0 else 0
	
func _on_heal_pressed():
	var next_hp = hp.value + heal_value
	hp.value = next_hp if next_hp < max_hp else max_hp
