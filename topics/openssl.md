# OpenSSL

## CA Private Key

<details>
<summary>Generate a CA Certificate private key?</summary>

> Because CA private key is so sensitive, and anyone obtaining it has access to
> generate new certificates, you should encrypt the key with an AES encryption.
>
> ```sh
> openssl genrsa -aes256 -out ca-key.pem 4096
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=VH4gXcvkmOY
> ---
> **References**
> ---
</details>

## CA Certificate

<details>
<summary>Generate an X509 Certificate?</summary>

> ```sh
> openssl req -new -x509 -sha256 -days 3650 -key ca-key.pem -out ca.pem
> ``````
> ---
> **Resources**
> - https://www.youtube.com/watch?v=VH4gXcvkmOY
> ---
> **References**
> ---
</details>

<details>
<summary>Dump the x509 Certificate text?</summary>

> **Description**
>
> ```sh
> openssl x509 -in ca.pem -text
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=VH4gXcvkmOY

> **References**
> ---
</details>

<details>
<summary>Generate a CA Certificate Sign request file?</summary>

> **Description**
>
> ```sh
> openssl genrsa -out cert-key.pem
> openssl req -new -sha256 -subj "/CN=customsubject" -key cert-key.pem -out cert.csr
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=VH4gXcvkmOY
> ---
> **References**
> ---
</details>

<details>
<summary>Generate a self-signed CA Certificate?</summary>

> ```sh
> echo "subjectAllName=DNS:*.sampleproject.com,IP:10.0.0.2" > extfile.cnf
> openssl x509 -req -sha256 -days 3560 -in cert.csr -CA ca.pem -CAkey ca-key.pem -out cert.pem -extfile extfile.cnf -CAcreateserial
> ``````
>
> Now combine the pem files:
>
> ```sh
> cat cert.pem > fullchain.cert
> cat ca.pem >> fullchain.cert
> ``````

> **Resources**
> - https://www.youtube.com/watch?v=VH4gXcvkmOY
> ---
> **References**
> ---
</details>
