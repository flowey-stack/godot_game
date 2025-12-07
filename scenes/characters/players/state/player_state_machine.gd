class_name PlayerStateMachine extends Node

var states : Array[ PlayerState ]
var prev_state : PlayerState
var current_state :PlayerState

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(delta):
	ChangeState( current_state.Process( delta ) )
	pass

func _physics_process(delta):
	ChangeState( current_state.Physics( delta ) )
	pass

func _unhandled_input(event):
	ChangeState(current_state.HandInput(event))
	pass

func Initialize( _player : Player2 ) -> void:
	states = []
	
	for c in get_children():
		if c is PlayerState:
			states.append(c)
	
	if states.size()>0:
		states[0].player = _player
		ChangeState( states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func ChangeState(new_state : PlayerState) -> void:
	if new_state == null || new_state == current_state:
		return
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
	
