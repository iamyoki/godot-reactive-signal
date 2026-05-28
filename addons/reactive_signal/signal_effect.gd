@icon('sparkle.svg')
class_name SignalEffect
extends Node

var signal_context: SignalContext

func _enter_tree() -> void:
	signal_context = SignalContext.current_context
	ReactiveSignal.use_effect(func(): effect(SignalContext.current_context))

func effect(context: SignalContext):
	pass
