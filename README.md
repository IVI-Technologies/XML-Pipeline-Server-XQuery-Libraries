# XML Pipeline Server — XQuery Extension Libraries

A comprehensive set of XQuery extension function libraries for [XML Pipeline Server](https://www.xmlpipelineserver.com) (XPS). These libraries expose Java-based functionality to XQuery pipelines, enabling file I/O, networking, security, data transformation, and more.

## Libraries

| Library | Module | Description |
|---------|--------|-------------|
| **Date/Time** | | |
| [time_lib](date_time/time_lib.xquery) | `DateTime` | Format current date/time in local or UTC time zones |
| [timezone_lib](date_time/timezone_lib.xquery) | `TimeZoneToOffset` | Convert UTC dates to timezone-aware offsets (DST-aware) |
| [ical_lib](date_time/ical_lib.xquery) | `ICALParser` | Convert between iCalendar (RFC 5545) and xCalendar (XML) |
| **File System** | | |
| [file_lib](file/file_lib.xquery) | `FileOperations` | Copy, move, delete, read, write, list, and sync files and directories |
| **Networking** | | |
| [http_lib](net/http_lib.xquery) | `HTTP` | HTTP client — all verbs, Basic/Digest auth, proxy, multipart, custom headers |
| [sftp_lib](net/sftp_lib.xquery) | `SFTP` | SFTP file transfer — upload, download, list, delete, rename, with connection pooling |
| [ftp_lib](net/ftp_lib.xquery) | `FTP` | FTP/FTPS file transfer — same operations as SFTP, with connection pooling |
| [ldap_lib](net/ldap_lib.xquery) | `LDAPSession` | LDAP search with pagination, sorting, Kerberos/GSSAPI support |
| [email_session_lib](net/email_session_lib.xquery) | `EmailSession` | SMTP/IMAP email sessions — send, read, move, filter emails (OAuth2 supported) |
| [email_message_lib](net/email_message_lib.xquery) | `Email` | Create and inspect email messages, attachments, headers |
| [email_message_part_lib](net/email_message_part_lib.xquery) | `EmailMessagePart` | Inspect and extract individual email parts (body, attachments) |
| [email_message_collection_lib](net/email_message_collection_lib.xquery) | `Emails` | Iterate over email collections returned by readEmails() |
| **PDF** | | |
| [foprocessor_lib](pdf/foprocessor_lib.xquery) | `FOProcessor` | Convert XSL-FO documents to PDF using Apache FOP |
| [form_fields_lib](qrcode/form_fields_lib.xquery) | `PDF` | Extract form fields from PDF documents using Apache PDFBox |
| **Process** | | |
| [process_lib](process/process_lib.xquery) | `SimpleProcessBuilder` | Execute external OS processes with timeout |
| **QR Code** | | |
| [qrcode_lib](qrcode/qrcode_lib.xquery) | `QrCodeManager` | Encode and decode QR code images with optional GZIP compression |
| **Security** | | |
| [jsonwebtoken_lib](security/jsonwebtoken_lib.xquery) | `JSONWebToken` | Create and verify RSA-256 signed JWT tokens |
| [nonce_lib](security/nonce_lib.xquery) | `Nonce` | Compute URL-safe HMAC-SHA1 signatures |
| [pgp_lib](security/pgp_lib.xquery) | `PGP` | PGP file encryption and decryption (BouncyCastle) |
| [rsa_lib](security/rsa_lib.xquery) | `RSA` | RSA string encryption and decryption with PEM keys |
| **SQL** | | |
| [sqlcommand_lib](sql/sqlcommand_lib.xquery) | `SQLCommand` | Execute SQL queries from XML profiles with parameterized binding |
| **XML** | | |
| [xsd_validation_lib](xml/xsd_validation_lib.xquery) | `XSDValidation` | Validate XML against XSD schemas, check well-formedness |
| **XSLT** | | |
| [xslt_lib](xslt/xslt_lib.xquery) | `XSLT` | Run XSLT transformations from XQuery (Saxon Enterprise) |
| **ZIP** | | |
| [zip_lib](zip/zip_lib.xquery) | `Zip` | Create ZIP archives, GZIP compress/decompress strings |

## Usage

Import a library in your XQuery module using its namespace URI:

```xquery
import module namespace xps_sftp = "ddtekjava:com.ivitechnologies.pipeline.ext.net.SFTP"
  at "[xps_root]/xquery_lib/xps/net/sftp_lib.xquery";

let $config := <config host="sftp.example.com" port="22" user="admin" password="secret"/>
let $files := xps_sftp:listFiles($config)
return $files
```

All functions are implemented as Java external functions. The `ddtekjava:` namespace prefix maps XQuery function calls to their Java implementations within XML Pipeline Server.

## Documentation

Each library file includes xqDoc-style inline documentation with module descriptions, function descriptions, `@param`, and `@return` annotations. Refer to the individual `.xquery` files for detailed API documentation.

For the complete XML Pipeline Server documentation, see the [User's Guide](https://www.xmlpipelineserver.com).

## Requirements

- XML Pipeline Server 2.x (build 248 or later)
- Java 1.8 or later (Java 11+ recommended, Java 25 supported)

## License

Copyright IVI Technologies, Inc. All rights reserved.
