@icon('orbit.svg')
class_name SignalBinder
extends Node

var signal_context: SignalContext

func _enter_tree() -> void:
	signal_context = SignalContext.current_context

func _ready() -> void:
	bind(signal_context)

func bind(context: SignalContext) -> void:
	pass
