$users = Get-ADUser -Filter *
$password = ConvertTo-SecureString "kirkcharlie" -AsPlainText -Force
forEach($user in $users) {
$user | Set-ADAccountPassword -NewPassword $password
}
