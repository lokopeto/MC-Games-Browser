extends Node

#default values
var mem_min = 4 #minimum mem for memory calculation
var mem_max = 8 #maximum mem for memory calculation
#mem variable not related to java args
var mem_server = 4 #memory used for server execution
var mem_mine = 2 #memory used for intance in prism launcher


func mem_auto():
	var mem_os: int = OS.get_memory_info().physical / 1000000000.0
	if mem_os:
		if mem_os >= mem_min:
			mem_server = 4
			mem_mine = 2
		elif mem_os >= mem_max:
			mem_server = 4
			mem_mine = 4
