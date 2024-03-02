$users = Get-LocalUser
$password = ConvertTo-SecureString "charliekirk" -AsPlainText -Force
forEach($user in $users) {
$user | set-localuser -password $password
}
