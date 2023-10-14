extends CharacterBody2D
class_name Player

@export var speedMultiplier: float = 1.0
@export var projectile: PackedScene

const MOOVESPEED: float = 500.0

func _physics_process(delta: float) -> void:
	move()
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"): shoot()

func move() -> void:
	var movement: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_left"): movement.x -= 1.0
	if Input.is_action_pressed("move_right"): movement.x += 1.0
	if Input.is_action_pressed("move_up"): movement.y -= 1.0
	if Input.is_action_pressed("move_down"): movement.y += 1.0
	velocity = movement * (MOOVESPEED * speedMultiplier)
	move_and_slide()


func shoot() -> void:
	var inst: Projectile = projectile.instantiate()
	inst.spawnedFrom = self
	owner.add_child(inst)
	inst.transform = $Marker2D.global_transform
