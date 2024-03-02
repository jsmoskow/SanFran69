$users = Get-ADUser -Filter *
$password = ConvertTo-SecureString "charliekirk" -AsPlainText -Force
forEach($user in $users) {
$user | Set-ADAccountPassword -NewPassword $password
}