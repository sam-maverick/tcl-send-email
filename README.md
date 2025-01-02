With this [Tcl](https://www.tcl.tk/) (Tool Command Language) script, you can send text-based emails via SMTP from a Cisco IOS router (Check [here](https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/ios_tcl/configuration/15-s/ios-tcl-15-s-book/nm-script-tcl.html) for documentation and compatibility information on Tcl in Cisco routers).

## Installation

Clone this repo.

Copy  `param_sendemail_example.tcl` as `param_sendemail.tcl`

Edit the parameters of `param_sendemail.tcl` as appropriate.

Copy all the files to the flash of your router.

## Usage

Create some `myscript.tcl` with the content below and copy it to the flash of your router.

```
source flash:param_sendemail.tcl
source flash:lib_sendemail.tcl

set mailsubject "This is the subject"
set mailbody "This is a sample email.
Allow a blank line to separe the paragraphs.
And just put the text over here."

set returncode [catch {sendemail $EMSERVER $EMPORT $EMLOCALFQDN $EMFROM $EMTO $EMUSERNAMEBASE64 $EMPASSWORDBASE64 $mailsubject $mailbody} returnstringvalue]
```

Then, from the CLI of your router, run your script:

```
Router# tclsh
Router(tcl)# source slot0:myscript.tcl
```

Unless otherwise configured, your router will use your WAN address to perform the SMTP connection (no NAT). Open the access in your ACL's as appropriate, if you are using ACL's.

## License

See the [LICENSE](LICENSE)