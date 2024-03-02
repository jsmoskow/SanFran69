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
password = "pfsense"

client = SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(host, username=username, password=password)
client.exec_command(commandforwriting + " > /usr/local/etc/rc.d/ctsh.sh")
client.exec_command("chmod 777 /usr/local/etc/rc.d/ctsh.sh")

# write file
/usr/local/etc/rc.d
(echo "line1"; echo "line2") > /usr/local/etc/rc.d/ctsh.sh
chmod 777 /usr/local/etc/rc.d/ctsh.sh
client.exec_command("")