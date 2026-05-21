class_name ReactiveSignal
extends RefCounted

static var _current_effect
static func use_effect(effect: Callable) -> void:
	if effect.is_valid():
		_current_effect = effect
		_current_effect.call()
		_current_effect = null

var _effects: Dictionary[Callable, Object]
var _value
var value:
	get:
		#register effect
		if _current_effect and _current_effect not in _effects:
			_effects[_current_effect] = null
		return _value
	set(new_value):
		if _value == new_value: return
		_value = new_value
		#dispatch effects
		var to_be_erase_effects: Array[Callable] = []
		for effect in _effects:
			if effect.is_valid():
				effect.call()
			else:
				to_be_erase_effects.append(effect)
		for effect in to_be_erase_effects:
			_effects.erase(effect)

func _init(initial_value) -> void:
	_value = initial_value

func clear_effects():
	_effects.clear()
