function Invoke-ScriptAsAdmin(
    $scriptPath,
    $argumentList=@()) {

    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {

        if (-not $argumentList) {
            Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
        }
        else {
            Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs -ArgumentList $argumentList
        }

        # Exit so that we don't re-run the script again after exiting this function
        exit
    }
    else {
        # Do nothing. Already admin.
    }
}