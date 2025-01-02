
source flash:param_sendemail.tcl
source flash:lib_sendemail.tcl


set mailsubject "This is the subject"

set mailbody "This is a sample email.

Allow a blank line to separe the paragraphs.

And just put the text over here."
	
set returncode [catch {sendemail $EMSERVER $EMPORT $EMLOCALFQDN $EMFROM $EMTO $EMUSERNAMEBASE64 $EMPASSWORDBASE64 $mailsubject $mailbody} returnstringvalue]

