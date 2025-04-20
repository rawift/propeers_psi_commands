# Set execution policy and security protocol
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Install Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install Git and Python
choco install git -y
choco install python -y

# Install Python dependencies
python -m pip install pytz python-dotenv selenium webdriver-manager

# Define desktop path and clone repository
$desktop = [Environment]::GetFolderPath('Desktop')
if (Test-Path "$desktop\propeer_bot") { Remove-Item -Recurse -Force "$desktop\propeer_bot" }
git clone https://github.com/rawift/propeer_bot.git "$desktop\propeer_bot"

# Start the Python script as a background job
Start-Job -ScriptBlock { python "$desktop\propeer_bot\run_meeting.py" 'https://meet.google.com/wwd-qbgx-xrf' '2025-04-20T18:08:00.000Z' 'abhirawat' }
