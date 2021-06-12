extends RigidBody2D

export var pode_mover: bool
export var pode_destruir: bool
export var colide: bool


func _ready():
	if (pode_mover):
		self.set_collision_layer_bit(14,true)
	else:
		self.mode = RigidBody2D.MODE_STATIC
	
	if (pode_destruir):
		self.set_collision_layer_bit(13, true)
	
	if (colide):
		self.set_collision_layer_bit(12, true)
		self.set_collision_mask_bit(0, true)


func _process(_delta) -> void:
	if (Input.is_action_just_pressed("ui_left")):
		_empurrar(self.global_position + Vector2(-10,0))
	if (Input.is_action_just_pressed("ui_right")):
		_empurrar(self.global_position + Vector2(10,0))
	if (Input.is_action_just_pressed("ui_up")):
		_empurrar(self.global_position + Vector2(0,-10))
	if (Input.is_action_just_pressed("ui_down")):
		_empurrar(self.global_position + Vector2(0,10))


func _empurrar(posicao_empurrao: Vector2):
	if (pode_mover):
		self.apply_impulse(posicao_empurrao, Vector2(self.global_position - posicao_empurrao) * 20) #= self.global_position - posicao_empurrao


func _dano():
	if (pode_destruir):
		self.queue_free()
