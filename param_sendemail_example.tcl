
#
# Parameters used by lib_sendemail.tcl
#

# Mail server
set EMSERVER "smtp.something.com"
# Server port for SMTP. It will usually be 25
set EMPORT "25"
# From address in the following format: Common_Name <address@something.com>
# Do not use special characters such as [, á, ç, ñ
set EMFROM "Michel <m.foucault@something.com>"
# To address in the following format: Common_Name <address@recipient.com>.
# One recipient per line; do not separe recipients with , or ;
# Do not use special characters such as [, á, ç, ñ
set EMTO {
"Noam <n.chomsky@recipient.com>"
}
# SMTP username encoded with BASE64. It usually coincides with the From address.
set EMUSERNAMEBASE64 "bS5mb3VjYXVsdEBzb21ldGhpbmcuY29t"
# SMTP password encoded with BASE64
set EMPASSWORDBASE64 "cGFzc3dvcmQ="
# Fully Qualified Domain Name of our machine. Some mail servers require connected clients to have a PTR record registered to the DNS system, about the client's IP address. Otherwise, try with an arbitrary domain name.
set EMLOCALFQDN "www.dummy.com"

