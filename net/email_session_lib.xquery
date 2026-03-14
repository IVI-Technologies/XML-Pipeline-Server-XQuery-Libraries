(:~
 : Email session library.
 : Manages SMTP/IMAP email sessions for sending and reading emails.
 : Supports OAUTH2 authentication for Microsoft 365 and Gmail.
 :
 : The settings element accepts standard JavaMail properties as attributes:
 :   mail.smtp.host, mail.smtp.port, mail.smtp.user, mail.smtp.password
 :   mail.smtp.auth, mail.smtp.starttls.enable
 :   mail.imap.host, mail.imap.port, mail.imap.user, mail.imap.password
 :   mail.imap.ssl.enable
 :   mail.smtp.auth.mechanisms — Set to "XOAUTH2" for OAuth2 authentication
 :   xps_oauth2_access_token — Pre-obtained OAuth2 access token
 :   xps_oauth2_url, xps_oauth2_client_id, xps_oauth2_client_secret,
 :   xps_oauth2_grant_type, xps_oauth2_refresh_token, xps_oauth2_scope
 :
 : @author IVI Technologies
 :)
module namespace es="ddtekjava:com.ivitechnologies.pipeline.ext.email.EmailSession";

(:~
 : Creates a new email session with the specified transport properties.
 :
 : @param $settings An element with JavaMail session properties as attributes
 : @return An EmailSession Java object for use with sendEmail and readEmails
 :)
declare function es:EmailSession( $settings as element()) as ddtek:javaObject external;

(:~
 : Sends an email using the session's SMTP configuration.
 :
 : @param $this The EmailSession object
 : @param $email An Email object created with em:Email()
 : @return true on success
 :)
declare function es:sendEmail($this as ddtek:javaObject, $email as ddtek:javaObject ) as xs:boolean external;

(:~
 : Reads emails from the mailbox using a filters element.
 :
 : Filter attributes on the element:
 :   folder — Mailbox folder name (e.g., "INBOX")
 :   subjectFilter, fromFilter, to_filter, cc_filter, bcc_filter — Text pattern filters
 :   startingFrom, endingTo — Date range in "YYYY-MM-DD" format
 :   older_than_in_seconds_filter, younger_than_in_seconds_filter — Age-based filters
 :   flag_filter — IMAP flag name (e.g., "SEEN", "FLAGGED")
 :   flag_filter_value — "true" or "false" for flag state
 :   last_uid_filter — Minimum UID value for incremental reading
 :
 : @param $filters An element with email filter attributes
 : @return An Emails collection Java object
 :)
declare function es:readEmails($filters) as ddtek:javaObject external;

(:~
 : Reads emails with simple string filters.
 :
 : @param $folder Mailbox folder name (e.g., "INBOX")
 : @param $subjectFilter Subject text filter (case-insensitive substring match)
 : @param $fromFilter Sender text filter (case-insensitive substring match)
 : @param $startingFrom Starting date in "YYYY-MM-DD" format
 : @return An Emails collection Java object
 :)
declare function es:readEmails($folder as xs:string, $subjectFilter as xs:string, $fromFilter as xs:string, $startingFrom as xs:string) as ddtek:javaObject external;

(:~
 : Moves emails matching the filter criteria to a different IMAP folder.
 :
 : @param $session The EmailSession object
 : @param $settings An element with email filter attributes
 : @param $targetFolder Destination IMAP folder name (e.g., "Archive", "Trash")
 : @return true on success
 :)
declare function es:moveEmails( $session as ddtek:javaObject, $settings as element(*, xs:untyped), $targetFolder as xs:string) as xs:boolean external;
