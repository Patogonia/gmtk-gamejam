extends RigidBody2D

var empurrado: bool = false

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


func _empurrao(direcao_empurrao):
	if (pode_mover):
		self.apply_impulse(Vector2(1,1), direcao_empurrao / 4) #= self.global_position - posicao_empurrao


func _explode():
	if (pode_destruir):
		self.queue_free()
