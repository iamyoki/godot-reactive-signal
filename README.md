# ReactiveSignal

A simple addon to make UI / Game Logic reactive in Godot 4.x (GDSCript).

Inspired by the signal/reactive systems in modern frontend frameworks (like React, Vue, and SolidJS).

## ✨ Features

* **True Reactivity**: No need to manually connect or emit signals. Simply access data inside `use_effect`, and the dependency tracking is automatically handled.
* **Lightweight & Efficient**: Built on top of `RefCounted` for automatic memory management, preventing memory leaks.
* **Zero Coupling**: Keeps your data layer completely decoupled from the view layer, significantly reducing boilerplate code like `connect()` and `emit_signal()`.

---

## 🚀 Quick Start

### 1. Basic Usage (Data Responsiveness)

Use `use_effect` to track and respond to data changes automatically:

```gdscript
extends Node

func _ready() -> void:
    # 1. Create a reactive signal
    var score = ReactiveSignal.new(0)
    
    # 2. Define a side effect (automatically runs whenever score.value changes)
    ReactiveSignal.use_effect(func():
        print("Current Score: ", score.value)
    ) # Prints: "Current Score: 0"
    
    # 3. Modify the data, which automatically triggers updates
    score.value = 10  # Prints: "Current Score: 10"
    score.value = 10  # Value unchanged, won't trigger
    score.value = 25  # Prints: "Current Score: 25"

```

### 2. Auto-Updating UI Components

Perfect for scenarios where multiple UI elements share and display the same state:

```gdscript
extends Control

@onready var label_1: Label = $Label1
@onready var label_2: Label = $Label2

# Create a global or local state
var player_hp = ReactiveSignal.new(100)

func _ready() -> void:
    # Keep multiple UI elements in perfect sync automatically
    ReactiveSignal.use_effect(func():
        label_1.text = "HP: " + str(player_hp.value)
        label_2.text = "Health: " + str(player_hp.value) + "%"
    )

func _on_damage_taken(amount: int) -> void:
    player_hp.value -= amount # UI updates automatically! No need to manually assign Label.text

```

---

## 🛠️ API Reference

### `ReactiveSignal`

#### Methods

* `static func use_effect(effect: Callable) -> void`
Executes the provided closure function and automatically collects any `ReactiveSignal` instances accessed within it. When the `value` of those instances changes, the `effect` is automatically re-invoked.
* `func _init(initial_value) -> void`
Constructor that initializes the signal with its starting value.
* `func clear_effects() -> void`
Manually clears all tracking side effects bound to this signal instance (useful for manual cleanup or destruction).

#### Properties

* `var value`
**Get**: Returns the current value. If called within a `use_effect` closure, it automatically registers the effect as a dependency.
**Set**: Assigns a new value. If the new value differs from the current one, it dispatches and re-runs all dependent effects. It also automatically cleans up any stale or invalid (freed) Callables during the dispatch process.

---

## 📦 Installation

1. Download or clone this repository, and copy the `addons/ReactiveSignal` folder into your Godot project's root directory.
2. Open the Godot Editor, navigate to **Project -> Project Settings -> Plugins**.
3. Locate **ReactiveSignal** and check the **Enable** box.

---

## 📄 License

This project is open-source and licensed under the **MIT License**. See the [LICENSE](./LICENSE.txt) file for more details.
