
# #################
# Install tools
# #################
choco feature enable -n=allowGlobalConfirmation

. .\windows\choco\win_features.ps1
. .\windows\choco\basic.ps1
. .\windows\choco\communication.ps1
. .\windows\choco\devenv.ps1
. .\windows\choco\javascript.ps1
. .\windows\choco\terminal.ps1

# #################
# Private Data Sources
# #################
. .\windows\setup\generate_ssh_key.ps1
. .\windows\setup\nuget_sources_config.ps1
. .\windows\setup\capslock_to_esc.ps1
. .\windows\setup\uninstall_ms_clutter.ps1
. .\windows\setup\environment_variables.ps1
. .\windows\setup\nuget_sources_config.ps1
. .\windows\setup\bg-random-schedule.ps1
. .\windows\setup\windows_prefs.ps1

