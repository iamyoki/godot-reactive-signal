extends Control

@onready var first_name_input: LineEdit = $HBoxContainer/FirstName
@onready var last_name_input: LineEdit = $HBoxContainer/LastName
@onready var intro_label: Label = $VBoxContainer/Intro
@onready var warning_label: Label = $VBoxContainer/Warning

var first_name = ReactiveSignal.new('')
var last_name = ReactiveSignal.new('')
var full_name = ReactiveSignal.computed(func(): 
	return first_name.value + ' ' + last_name.value
)
var intro = ReactiveSignal.computed(func():
	return 'My name is: %s' % full_name.value)

func _ready() -> void:
	first_name_input.text_changed.connect(func(new_text): first_name.value = new_text)
	last_name_input.text_changed.connect(func(new_text): last_name.value = new_text)
	
	ReactiveSignal.use_effect(func():
		intro_label.text = intro.value
	)
	
	ReactiveSignal.use_effect(func():
		var deps = [first_name.value, last_name.value]
		if not deps[0]:
			warning_label.text = 'First name should not be empty'
		elif not deps[1]:
			warning_label.text = 'Last name should not be empty'
		else:
			warning_label.text = ''
	)
