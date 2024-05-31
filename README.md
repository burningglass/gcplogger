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

## 2 Write the code

### 2.1 IDE launch

`cd %HOMEPATH%\projects\gcplogger`<br/>
`code .` (to launch VS Code in the context of this project folder)

### 2.2 Develop the main script

ToDo

## 3 Update the repo

### 3.1 Set contributing-user properties (if necessary)

Under `%HOMEPATH%\projects\cryptoservice`:<br/>
`git config --global user.name "<ContributorName>"`<br/>
`git config --global user.email "<ContributorEmailAddress>"`

### 3.2 Push code and config back to GitHub

Under `%HOMEPATH%\projects\cryptoservice`:<br/>
`git add app/index.js`<br/>
`git add package.json`<br/>
`git add package-lock.json`<br/>
`git commit -m "Initial bulk (Crypto service) code upload"`<br/>
`git push`<br/>

## 4 Dockerize the application (in GCloud)

### 4.1 Connect to K8s context in GCloud

![Connecting to K8s context](https://github.com/burningglass/registrationservicemeshsetup/blob/main/README.images/Picture1.png)

### 4.2 Connect to the K8s cluster

![Connecting to the K8s cluster](https://github.com/burningglass/registrationservicemeshsetup/blob/main/README.images/Picture2.png)

![Connecting to the K8s cluster](https://github.com/burningglass/registrationservicemeshsetup/blob/main/README.images/Picture3.png)

### 4.3 Create the parent working folder (GCloud Shell environment)

`cd ~`<br/>
`mkdir projects`<br/>
`cd projects`

### 4.4 Clone the Repo (from GitHub)

`git clone <paste>` (paste in the URL copied into Clipboard per section 1.2)
