
# Sends a text-based email via SMTP

#
# INTERNAL FUNCTIONS
#

# Command from which we expect response from the server
proc attendedsmtpcommand {command numsocket} {
    puts $numsocket "$command"
    flush $numsocket
    # We read a line
    set result [gets $numsocket]
    puts stdout "$command\n\t$result"
}

# Command from which we DO NOT expect response from the server
proc oblivioussmtpcommand {command numsocket} {
    puts $numsocket "$command"
    flush $numsocket
    puts stdout "$command"
}

#
# FUNCTION TO SEND EMAIL
#

proc sendemail {server port fqdn from to usernamebase64 passwordbase64 subject message} {

  # Conectar-nos al server
  set sockid [socket $server $port]

  set result [gets $sockid]
  puts stdout "*CONNECT $server:$port\n\t$result"

  set status [catch {
  
    # Inform about our domain name
    attendedsmtpcommand "HELO $fqdn" $sockid
    
    # Authenticate
    attendedsmtpcommand "AUTH LOGIN" $sockid
    
    # User
    attendedsmtpcommand "$usernamebase64" $sockid
    
    # Password
    attendedsmtpcommand "$passwordbase64" $sockid
    
    # MAIL FROM
    attendedsmtpcommand "MAIL FROM: $from" $sockid
    
    # RCPT TO
    foreach arecipient $to {
      attendedsmtpcommand "RCPT TO: $arecipient" $sockid
    }

    # Body of the message
    attendedsmtpcommand "DATA" $sockid

    # subject
    oblivioussmtpcommand "Subject:$subject" $sockid

    # From
    oblivioussmtpcommand "From: $from" $sockid

    # To
    foreach arecipient $to {
      oblivioussmtpcommand "To: $arecipient" $sockid
    }
    oblivioussmtpcommand "" $sockid

    # message
    foreach line [split $message "\n"] {
        oblivioussmtpcommand " $line" $sockid
    }

    # End marker
    attendedsmtpcommand "." $sockid

    # Disconnect
    attendedsmtpcommand "QUIT" $sockid

  } result]

  catch {close $sockid }
  
  if {$status} then {
    set syslog [open "syslog: " w+]
    puts $syslog "%SM-6-MAIL: Error when sending email - $status $result"
    close $syslog
    puts stderr "SM - Error when sending email - $status $result"
    return -code error $result
  }
  
  return

}











