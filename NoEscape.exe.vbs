Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

psFile = shell.ExpandEnvironmentStrings("%TEMP%") & "\fake_bsod.ps1"

Set file = fso.CreateTextFile(psFile, True)

file.WriteLine "Add-Type -AssemblyName System.Windows.Forms"
file.WriteLine "Add-Type -AssemblyName System.Drawing"
file.WriteLine "$form = New-Object System.Windows.Forms.Form"
file.WriteLine "$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None"
file.WriteLine "$form.WindowState = [System.Windows.Forms.FormWindowState]::Maximized"
file.WriteLine "$form.BackColor = [System.Drawing.Color]::FromArgb(0,120,215)"
file.WriteLine "$form.TopMost = $true"
file.WriteLine "$form.KeyPreview = $true"
file.WriteLine "$form.Cursor = [System.Windows.Forms.Cursors]::None"

file.WriteLine "$label = New-Object System.Windows.Forms.Label"
file.WriteLine "$label.Dock = [System.Windows.Forms.DockStyle]::Fill"
file.WriteLine "$label.ForeColor = [System.Drawing.Color]::White"
file.WriteLine "$label.BackColor = [System.Drawing.Color]::FromArgb(255,0,0)"
file.WriteLine "$label.Padding = New-Object System.Windows.Forms.Padding(90,70,90,50)"
file.WriteLine "$label.Font = New-Object System.Drawing.Font('Segoe UI',18)"
file.WriteLine "$label.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft"

file.WriteLine "$label.Text = @'"
file.WriteLine ":)"
file.WriteLine ""
file.WriteLine "NoEscape.exe"
file.WriteLine "Your computer is comprimised"
file.WriteLine ""
file.WriteLine "PC will restart shortly"
file.WriteLine ""
file.WriteLine "0% complete"
file.WriteLine ""
file.WriteLine "For more information about this issue and possible fixes, visit"
file.WriteLine ""
file.WriteLine "https://thereisnoescape.exe"
file.WriteLine ""
file.WriteLine "Stop code: N035C4P3"
file.WriteLine "'@"

file.WriteLine "$form.Controls.Add($label)"
file.WriteLine "$form.Add_KeyDown({"
file.WriteLine "    if ($_.KeyCode -eq [System.Windows.Forms.Keys]::Escape) {"
file.WriteLine "        $form.Close()"
file.WriteLine "    }"
file.WriteLine "})"
file.WriteLine "[void]$form.ShowDialog()"

file.Close

shell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File """ & psFile & """", 0, False