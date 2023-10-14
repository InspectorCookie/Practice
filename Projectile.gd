extends Area2D

class_name Projectile


var speed: float = 25.0
var damage: float = 30.0
var timeToLive: float = 1.0
var spawnedFrom: Node


func _ready() -> void:
	body_entered.connect(on_body_entered)
	handle_time_to_live()
	

func handle_time_to_live() -> void:
	var ttl_timer:Timer = Timer.new()
	add_child(ttl_timer)
	ttl_timer.wait_time = timeToLive
	ttl_timer.one_shot = true
	ttl_timer.timeout.connect(func(): queue_free())
	ttl_timer.start()

func _physics_process(delta: float) -> void:
	position += transform.x * speed


func on_body_entered(body: Node2D) -> void:
	if body == spawnedFrom: return
	if body is Enemy:
		var enemy: Enemy = body as Enemy
		enemy.apply_damage(damage)
	queue_free()
