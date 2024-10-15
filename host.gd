extends Node
@onready var java_script: Node = $"../Java_Script"
@onready var status_label: Label = $"../Status"

var args = [
	Utils.git + "clone " + Utils.git_clone + " ./servers/" + Utils.folder_name, #ignores git clone if exist 
	
	Utils.git + "-C ./cf/ fetch origin", #updates the repo
	Utils.git + "-C ./cf/ status",
	Utils.git + "-C ./cf/ pull",
	
	"cd ./" + Utils.folder_name + " && " #executes the server
]

func _ready() -> void:

	var java_download = java_script.java_verif()




func _host_update():
	GlobalThread.thread = Thread.new()
	GlobalThread.thread.start(host_execute)

func host_execute():
	#loop for execution of every command
	for args_exec in args:
		if args_exec == args[0]:
			host_status.call_deferred(0)
		elif args_exec == args[1] or args[2] or args[3]:
			host_status.call_deferred(1)
		
		
		var output = []
		var error_code = OS.execute("CMD.exe", ["/C", args_exec], output)

#		print(args_exec, " = ", output, error_code)

		 # execution of zip_exec

func host_status(status: int):
	var host_statusdisplay: String
	if status == 0:
		host_statusdisplay = "Baixando Servidor"
	elif status == 1:
		host_statusdisplay = "Verificando"
	elif status == 2:
		host_statusdisplay = "Baixando Java"
	elif status == 3:
		host_statusdisplay = "Extraindo"
	elif status == 4:
		host_statusdisplay = "Iniciando"


#	print(status, host_statusdisplay)
	status_label.text = host_statusdisplay




func _on_host_pressed() -> void:
	host_execute()
