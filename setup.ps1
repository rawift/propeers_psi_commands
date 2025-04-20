# Set execution policy and security protocol
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Install Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Enable global confirmation for Chocolatey
choco feature enable -n allowGlobalConfirmation

# Install Git, Python, and NSSM
choco install git -y
choco install python -y
choco install nssm -y

# Install required Python packages
python -m pip install pytz python-dotenv selenium webdriver-manager

# Define Desktop path
$desktop = [Environment]::GetFolderPath('Desktop')

# Clone the repository to Desktop\propeer_bot
git clone https://github.com/rawift/propeer_bot.git "$desktop\propeer_bot"

# Define the path to the Python script
$pythonScript = "$desktop\propeer_bot\run_meeting.py"

# Define the service name
$serviceName = "PropeerBotService"

# Install the Python script as a Windows service using NSSM
nssm install $serviceName "python" "$pythonScript"

# Start the service
nssm start $serviceName
