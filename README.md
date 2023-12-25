# Linux Privileges


## Description
**Linux Privileges** or `lprivileges` is designed to allow users to work as a standard user for day-to-day use, by providing a quick and easy way to get administrator rights when needed. When you do need admin rights, you can get them by clicking on the Privileges icon in your favorites, or by calling `lprivilegesreq` in your Terminal.

Working as a standard user instead of an administrator adds another layer of security to your Linux device and is considered a security best practice. Linux Privileges helps users to request Privileges escalation only when required.

`lprivileges` is inspired by [SAP Privileges](https://github.com/SAP/macOS-enterprise-privileges) and an attempt to get a similar tool on Linux, and is in early development.


## Installation
Installation is easy. Clone the repo.

```
cd /into/the/repo
sudo ./install-Linux-Privileges.sh
```

## Config file

Some Settings can be customized by editing the config file `lprivileges.conf`

Settings should be edited prior to installation if installed manually or deployed with some management tool.

- custom configuration file can be found in the file: `./etc/lprivileges.conf`
- It will be located in folder '/usr/local/etc/lprivileges' after installation.
- Do not change `lprivileges.global.conf`


### Options / Settings

- `notify_demote`
	- **1** to notify user when privileges are demoted 
	- **0** for no notification 
- `notify_grant`
	- **1** to notify user when privileges are granted
	- **0** for no notification 
- `require_password`
	- **1** to require user to authenticate to request privileges escalation.
	- **0** users do not have to authenticate to request privileges escalation.
- `reason_required`
	- **1** to require user to give a reason for the privileges escalation request.
	- **0** users do not have to give a reason for the privileges escalation request.
	- **Note:** as of now there are 5 reasons to give. see **Roadmap**.

- `reason_text`
	- Text to display to the user when Reason is required. 
	- Handy if eventually want to translate in your native language for example.
- `reason_01`
	- Change if you wish. for now must not be empty. see **Roadmap**.
	- Default text: "**Just for fun**" 
		- note: this should be changed and reviewed by your Security Team.
- `reason_02`
	- Just change if you wish. for now must not be empty. see **Roadmap**.
	- Default text: "**App installation**".
		- note: this should be changed and reviewed by your Security Team.
- `reason_03`
	- Just change if you wish. for now must not be empty. see **Roadmap**.
	- Default text: "**IT management**" - note: this temporary and will be changed.
- `reason_04`
	- Just change if you wish. for now must not be empty. see **Roadmap**.
	- Default text: "**Don't know**" 
		- note: this should be changed and reviewed by your Security Team.
- `reason_05`
	- Other Reason entered by user. Change **only** if you want to translate. for now must not be empty. see **Roadmap**.
	- The user enters a different reason than the one proposed.
		- note: this should be changed and reviewed by your Security Team.
- `timer`
	- The timer in Minutes after which the Privileges are demoted.
	- **15mn** by default.
		- note: this should be changed and reviewed by your Security Team.


## Usage

All scripts are installed in `/usr/local/bin` and available in your `$PATH`

To request Privileges run `lprivilegesreq`

For now usage is simple:

### Gnome Desktop:

If the icon is not in your favorite bar, search for the app in the 'Show Applications' in your Desktop. The favorite icon will be created at the first request in any case. 

Desktop App is a shorcut, and will open up a terminal window just like if you called `lprivilegesreq` from Terminal.


### Terminal 

run `lprivilegesreq`

Press Any Key or ctrl-C to cancel

```
 --------------------------
 Linux Privileges:
  Would you like to request Administator Privileges ?
  
    Request privileges - Press any Key
    Cancel - (c/C) or ctrl-C
 --------------------------
```
Choose or provide a reason


```
 --------------------------
 Linux Privileges:
   You requested Administator Privileges Escalation
   Please enter a reason:
    (1) Just for Fun
    (2) App installation
    (3) IT management
    (4) Don't know
    (5) Other reason
    (6) Cancel
 --------------------------
5

Other reason: lprivileges demo
```
enter your password to confirm

```
Please Enter johndoe password to confirm:

```


#### Status

You can ask your current privileges status by calling `lprivileges -s` or `lprivileges --status`

```
status requested
You currently have elevated privileges
```

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

- Finish this readme.
- Allow ≠ number of reasons.
	- manage `Other reason` in case we change the number of reasons.
- Allow display Texts to be changed.
- Fusion ( or not ) `lprivilegesreq` with `lprivileges`
- Send message thru Terminal for users connected over ssh
- "autodemote at login" option
- Request demote without waiting for timer to end.
- Finetuning user's icon Favorite creation in Gnome.
	- Sometimes when the Application is created, the Application icon is not added to user's favorite.
	- The icon favorite is automatically added at the first user request.
- Add a GUI for the `request` - `demote` in GNOME ?
- Improve text display and user interaction.
- Allow input for the request -aka `lprivileges -r "some reason"`
- Display Status in request
	- -> propose to demote if user is admin.
	- -> propose to grant is user is standard user.
- Adapt App Icon to unlocked if the user is admin during the installation.
- Adapt to other thing than Gnome Desktop ?


