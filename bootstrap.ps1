
# #################
# Install tools
# #################
choco feature enable -n=allowGlobalConfirmation

. .\choco\win_features.ps1
. .\choco\basic.ps1
. .\choco\communication.ps1
. .\choco\devenv.ps1
. .\choco\javascript.ps1
. .\choco\terminal.ps1

# #################
# Private Data Sources
# #################
. .\setup\generate_ssh_key.ps1
. .\setup\nuget_sources_config.ps1
. .\setup\capslock_to_esc.ps1
. .\setup\uninstall_ms_clutter.ps1

