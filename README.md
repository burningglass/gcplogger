# gcplogger
Simple logger with corresponding GCloud logging configuration steps

## 1 Repo set-up

### 1.1 Create an empty Repo (in GitHub)

This can be Private or Public:

![Repo set-up](README.images/Picture1.png)

### 1.2 Copy Repo location to clipboard

![Copy repo location](README.images/Picture2.png)

### 1.3 Create the parent working folder

On the local Desktop (using the Command Prompt):

`cd %HOMEPATH%`</br>
`mkdir projects`</br>
`cd projects`

### 1.4 Clone the repo

`git clone <paste>` (paste in the URL copied into Clipboard from GitHub above)

## 2 Configure GCloud Logging Service Account

This technical account is needed to secure the transport channel from applications to the Cloud log(s)

### 2.1 Create the script

Switch to the same subfolder (see above):

`cd %HOMEPATH%\projects\gcplogger\logsetup`

Create the script file, a complete script is available here:

[createServiceAccount script](https://github.com/burningglass/gcplogger/blob/main/logsetup/createServiceAccount.sh)

Be sure to replace the [PROJECT_ID] placeholder in this script

### 2.2 Execute the script to create the Service Account

Execute the script, carefully monitoring its output to ensure no errors with service account set-up

If the script executed successfully, the new service account should be visible from the GCloud dashboard Service Accounts page - see below:

![Browsing Service Accounts](https://github.com/burningglass/registrationstore/blob/main/README.images/Picture3.png)

**Important:** The output is a file called sa-pk.json, ensure that you rename this with a '.' prefix (to .sa-pk.json) so filesystems will hide it

Save this file under a top-level `/var/.tokens` folder, i.e. from the root of the local drive

Note. This output file (`/var/.tokens/.sa-pk.json`) is referenced by the application's .env file (defining all environment variables)

**Important:** The .sa-pk.json (a secret token) should remain **outside** version control and **never copied** into application artifacts

## 3 Develop a test application

### 3.1 Create the Python virtual environment

Use VS Code Terminal to create the application's Python virtual environment

Each project should have its own discrete set of package references

`cd %HOMEPATH%\projects`<br/>
`pip list` reveals all Python system-wide packages 

Create the virtual environment:

`python -m venv .venv`

### 3.2 Activate the virtual environment

Activate the virtual environment (the .venv folder should appear in the project folder):

`cd .venv\Scripts`<br/>
`.\activate.bat`<br/>
`pip list --local`

The final command should now reveal only those Python packages installed for this project:

![Activating the virtual environment](README.images/Picture3.png)

**Important:** Before opening Visual Studio Code (next step), open a Powershell Command Prompt and ensure Powershell has rights to run the virtual environment activation script:

`Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted`

![Setting script execution policy](README.images/Picture4.png)

### 3.3 Open VS Code within the project folder

`cd %HOMEPATH%\projects\gcplogger`<br/>
`code .`

### 3.4 Install python-dotenv to enable Env support

This will allow the Python application to read key-value pairs from an .env file in the root project folder

Issue this command (e.g. from VS Code's Terminal):

`pip install python-dotenv` (which installs this in the project's virtual env)

Now create and populate the .env file as follows (replacing PROJECT_ID with the actual GCloud Project ID and DB_AUP with the strong password - see section 2.2):

`PRIVATE_IP=0`<br/>
`FLASK_DEBUG=1`<br/>
``<br/>
`\# Consider the following as 'secrets' (i.e. deploy in a mem-mounted cfg file (not env vars) when running in K8s)`<br/>
`REGISTRATION_DB_INSTANCE_NAME=[PROJECT_ID]:europe-west3:registration-instance`<br/>
`GOOGLE_APPLICATION_CREDENTIALS=/var/.tokens/.sa-pk.json`<br/>
`REGISTRATION_DB_USERNAME=admin`<br/>
`REGISTRATION_DB_PASSWORD=[DB_AUP]`<br/>
`REGISTRATION_DB_NAME=registration-db`

**Important:** The last five env settings are used by the Cloud SQL Connector (installed by a later step)

The FLASK_DEBUG setting will allow Flask (its installation is covered below) to support interactive code debugging (setting/hitting breakpoints in this web application's code)

### 4.10 Install/enable GCloud Logger

This is an (easier)alternative to installing the Cloud SQL Proxy sidecar (which needs to run alongside the Python application):

[Cloud SQL Connector for Python applications](https://pypi.org/project/cloud-sql-python-connector/0.1.0/)

[Clould SQL Connector docs](https://cloud.google.com/sql/docs/postgres/connect-connectors#python)

This connector establishes application connections to Google Cloud SQL databases using:
- IAM Authorization based on a GCloud Service Account (ensuring a genuine connection to the target Cloud SQL database)
- a TLS 1.3 encrypted channel (it transparently creates this channel and manages all requisite cert (re)generation/exchange with GCloud)

Issue this command (e.g. from VS Code's Terminal):

`cd %HOMEPATH%\projects\registrationstore`<br/>
`pip install "cloud-sql-python-connector[pg8000]"`<br/>
(per https://pypi.org/project/cloud-sql-python-connector/)

The above will install this connector into the project's virtual env

### 4.11 Freeze the application's package version dependency requirements

Issue the following command (**Important:** issue this from VS Code's Terminal where the Terminal prompt shows the prefix '(.venv)' since the Python virtual environment must be showing active, reflecting all packages installed by the steps above):

`cd %HOMEPATH%\projects\gcplogger`<br/>
`pip freeze > requirements.txt`

The resulting file (requirements.txt) now lists all packages(with versions) the application requires to run

[Fixed dependencies for Python application](https://github.com/burningglass/registrationstore/blob/main/requirements.txt)

### 4.14 Develop the application's main logic class (with entry-point)

Create a new file called registrationstore.py, the complete example is available in Github:

[registrationstore](https://github.com/burningglass/registrationstore/blob/main/registrationstore.py)

![Developing registrationstore.py](README.images/Picture9.png)

With this file open, hit F5 to run/debug the application (it will most likely listen on port 5000 by default)

## 5 Update the repo

### 5.1 Set contributing-user properties (if necessary)

Under `%HOMEPATH%\projects\cryptoservice`:

`git config --global user.name "<ContributorName>"`<br/>
`git config --global user.email "<ContributorEmailAddress>"`

### 5.2 Push code and config back to GitHub

Under `%HOMEPATH%\projects\gcplogger`:

`git add .env`<br/>
`git add .gitignore`<br/>
`git add db.py`<br/>
`git add registrationstore.py`<br/>
`git add requirements.txt`<br/>
`git commit -m "Initial bulk (Store data access service) code upload"`<br/>
`git push`<br/>
