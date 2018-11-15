$repeat = (New-TimeSpan -Minutes 1)
$principal = New-ScheduledTaskPrincipal -UserID partners\MSACAPPRDIIS01$ -LogonType Password
$trigger = New-JobTrigger -Once -At "05/30/2018 7:15 AM" -RepeatIndefinitely -RepetitionInterval $repeat

set-ScheduledTask "Incoming Mail Batch Job" –Principal $principal  -Trigger $trigger




