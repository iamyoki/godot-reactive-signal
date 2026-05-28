@icon('radio-tower.svg')
class_name SignalContext
extends Node

static var current_context: SignalContext

var _signals: Dictionary[String, ReactiveSignal] 

## Register the signals, only the child nodes can subscribe effects to those signals.
@export var signals: Dictionary[String, Variant]

func _enter_tree() -> void:
	current_context = self
	for signal_var_name in signals:
		_signals.set(signal_var_name, ReactiveSignal.new(signals[signal_var_name]))

func get_signal(signal_var: String) -> ReactiveSignal:
	return _signals.get(signal_var)
