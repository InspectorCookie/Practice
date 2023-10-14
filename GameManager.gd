extends Node


@onready var enemy_scene: PackedScene = load("res://enemy.tscn")
var wave: int = 1
var enemiesRemaining: int = 2
var spawnCount: int = 0
var spawnPoints: Array[Node] = []
var level: Node2D
var spawnTimer: Timer
var timeBetweenSpawns: float = 1.0


func _ready() -> void:
	level = get_tree().get_first_node_in_group("Level")
	spawnPoints = get_tree().get_nodes_in_group("Spawn")
	initialize_spawn_timer()
	handleNextwave()



func initialize_spawn_timer() -> void:
	spawnTimer = Timer.new()
	add_child(spawnTimer)
	spawnTimer.wait_time = timeBetweenSpawns
	spawnTimer.one_shot = false
	spawnTimer.timeout.connect(spawnEnemy)


func handleNextwave() -> void:
	spawnCount = 0
	spawnTimer.start()

func spawnEnemy() -> void:
	var randomSpawn: Node2D = \
		spawnPoints[randi_range(0, spawnPoints.size()-1)]
	var inst = enemy_scene.instantiate()
	level.add_child(inst)
	inst.global_position = randomSpawn.position
	spawnCount += 1
	if spawnCount == wave * 2:
		spawnTimer.stop()

func handleEnemyDeath() -> void:
	enemiesRemaining -= 1
	if enemiesRemaining == 0:
		wave += 1
		enemiesRemaining = wave * 2
		handleNextwave()
