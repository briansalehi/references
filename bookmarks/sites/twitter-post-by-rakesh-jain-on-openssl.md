# Twitter Post by Rakesh Jain for OpenSSL Tips

<details>
<summary>Generate a private openssl key?</summary>

> ```sh
> openssl genpkey -algorithm rsa -out private.key
> ``````

> Origin: thread 1

> References:
---
</details>

<details>
<summary>Generate an openssl certificate signing request?</summary>

> ```sh
> openssl req -new -key private.key -out request.csr
> ``````

> Origin: thread 2

> References:
---
</details>

<details>
<summary>Generate a self-signed openssl certificate?</summary>

> ```sh
> openssl req -new x509 -key private.key -out certificate.crt -days 365
> ``````

> Origin: thread 3

> References:
---
</details>

<details>
<summary>Encrypt files using AES256 encryption?</summary>

> Encrypt `sensitive.txt` using AES256 encryption and store the result in `sensitive.enc`.
>
> ```sh
> openssl enc -aes256 -in sensitive.txt -out sensitive.enc
> ``````

> Origin: thread 4

> References:
---
</details>

<details>
<summary>Decrypt files using AES256 encryption?</summary>

> Decrypt 'sensitive.enc' using AES256 encryption and retrieve the original content.
>
> ```sh
> openssl enc -aes256 -d -in sensitive.enc -out sensitive.txt
> ``````

> Origin: thread 5

> References:
---
</details>

<details>
<summary>Verify an openssl certificate?</summary>

> Display detailed certificate information, including issuer, subject, validity, and public key details.
> 
> ```sh
> openssl x509 -in certificate.crt -noout -text
> ``````

> Origin: thread 6

> References:
---
</details>

<details>
<summary>Convert openssl certificate formats?</summary>

> Convert a certificate from one format (e.g., .crt) to another (e.g., .pem).
>
> ```sh
> openssl x509 -in certificate.crt -out certificate.pem
> ``````

> Origin: thread 8

> References:
---
</details>

<details>
<summary>Create an openssl certification change?</summary>

> Create a certificate chain ('chain.crt') by concatenating 'intermediate.crt' and 'root.crt'.
>
> ```sh
> cat intermediate.crt root.crt > chain.crt
> ``````

> Origin: thread 9

> References:
---
</details>

<details>
<summary>Sign an openssl CSR with a CA?</summary>

> Sign the CSR using the CA certificate and private key to create a valid certificate.
>
> ```sh
> openssl x509 -req -in request.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out certificate.crt -days 365
> ``````

> Origin: thread 10

> References:
---
</details>

<details>
<summary>Generate a random number using openssl?</summary>

> Generate a random 128-bit hexadecimal number, useful for encryption keys or nonces.
>
> ```sh
> openssl rand -hex 16
> ``````

> Origin: thread 11

> References:
---
</details>

<details>
<summary>Test the openssl heartbleed vulnerability?</summary>

> Check if `example.com` is vulnerable to the Heartbleed bug (CVE-2014-0160) in TLS 1.0.
>
> ```sh
> openssl s_client -connect example[dot]com:443 -tlsextdebug -tls1 -x -no_ssl3
> ``````

> Origin: thread 12

> References:
---
</details>

<details>
<summary>Check openssl CSR details?</summary>

> Review the contents of a Certificate Signing Request (CSR), including provided information.
>
> ```sh
> openssl req -in csr.csr -noout -text
> ``````

> Origin: thread 13

> References:
---
</details>

<details>
<summary>View openssl certificate expiry?</summary>

> See the certificate's expiration date for timely renewal.
>
> ```sh
> openssl x509 -enddate -noout -in certificate.crt
> ``````

> Origin: thread 14

> References:
---
</details>

<details>
<summary>Check openssl certificate rotation?</summary>

> Inspect the Certificate Revocation List (CRL) for revoked certificates.
>
> ```sh
> openssl crl -in certificate.crl -noout -text
> ``````

> Origin: thread 15

> References:
---
</details>

<details>
<summary>Convert PFX to PEM?</summary>

> ```sh
> openssl pkcs12 -in certificate.pfx -clcerts -nokeys -out certificate.pem
> ``````

> Origin: thread 16

> References:
---
</details>

<details>
<summary>Create a password protected openssl private key?</summary>

> Generate an AES256 encrypted RSA private key with a passphrase.
>
> ```sh
> openssl genpkey -algorithm RSA -aes256 -out private.key
> ``````

> Origin: thread 17

> References:
---
</details>

<details>
<summary>Test if client openssl supports SSLv2/v3?</summary>

> ```sh
> openssl s_client -connect example.com:443 -ssl2/-ssl3
> ``````

> Origin: thread 18

> References:
---
</details>

<details>
<summary>Extract public openssl key from private?</summary>

> ```sh
> openssl rsa -in private.key -pubout -out public.key
> ``````

> Origin: thread 19

> References:
---
</details>

<details>
<summary>Encrypt and decrypt files with passphrase using openssl?</summary>

> ```sh
> openssl enc -aes256 -salt -in sensitive.txt -out sensitive.enc
> openssl enc -aes256 -d -in sensitive.enc -out sensitive_decrypted.txt
> ``````

> Origin: thread 20

> References:
---
</details>
