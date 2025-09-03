# Cyber Security
# The Ultimate Kali Linux Book
## book
## Packt Publishing
### chapter
### Glen D. Singh
#### surface

#### Ethical Hacking
##### Introduction to Ethical Hacking

###### How does penetration testing methodologies help testers?

Many learners are excited to get started, and can't wait to compromise their first targeted system. Some would be too eager and forget to perform an important step during a process. Hence, various penetration testing methodologies exist to help ethical hackers and penetration testers take a specific course of action during security assessments to ensure all aspects are thoroughly tested for security vulnerabilities.

###### What are the common penetration testing methodologies?

* Penetration Testing Execution Standard (PTES)
* Payment Card Industry Data Security Standard (PCI DSS)
* Penetration Testing Framework (PTF)
* Technical Guide to Information Security Testing and Assessment
* Open Source Security Testing Methodology Manual
* OWASP Web Security Testing Guide
* OWASP Mobile Security Testing Guide
* OWASP Firmware Security Testing Methodology

###### What are the pre-engagement steps before starting penetration tests?

1. Obtain Legal Permission: obtain a written legal permission from persons in authority
2. Rules of Engagement: define the scope of the penetration test
3. Non-Disclosure Agreement (NDA): a legally signed agreement between client and provider that specifies that a penetration tester and their employer will not share or hold onto any sensitive or proprietary information that is encountered during assessment.
4. Begin Penetration Testing

###### What are the benefits of using threat modeling in penetration testing?

Threat modeling is a process used to assist penetration testers to better understand the threats that applications are most prone to and to help them address the most common threats that a target faces.

###### What are the common threat models?

* **STRIDE**: Spoofing identity, tampering with data, repudiation threats, information disclosure, denial of service, and elevation of privilege
* **PASTA**: Process for attack simulation and threat analysis

###### What damages can spoofing identity threat cause and what are the mitigations?

A threat actor can impersonate the identity of a legitimate user to gain unauthorized access to a service. As a mitigation, multi-factor authentication (MFA) can be used to improve the verification process of legitimate users.

###### What damages can tampering data cause and what are the mitigations?

A threat actor can intercept and alter sensitive data that is being transmitted, causing unauthorized transfer of data on behalf of victims. As a mitigation, an end-to-end encryption such as digital certificates and signatures to protect data and its integrity during transmission.

###### What damages can repudiation threads cause and what are the mitigations?

A threat actor can perform a Denial of Service (DoS) attack on a service to deny any legitimate requests from authorized and trusted users. This would create a potential financial loss. As a mitigation technique, each user's activity should be recorded and each activity should be validated that is associated with a unique identifier, where a user cannot deny their action on a system.

###### What damages can information disclosure cause and what are the mitigations?

Sensitive data can be exposed to unauthorized persons, either through a security vulnerability within a database or insecure APIs and implementations. As a mitigation, access controls should be used and data encryption technologies should be applied to services.

###### What damages can denial of service cause and what are the mitigations?

A threat actor can flood unsolicited request messages to a system, causing the resources of the hosting server to be overwhelmed and become unavailable to process legitimate requests from authorized users. As a mitigation, intrusion prevention systems (IPS) should be applied to detect and prevent malicious network traffic.

###### What damages can elevation of privileges cause and what are the mitigations?

A threat actor may exploit a service to escalate their privileges and obtain unauthorized access to administrative areas of system. As a mitigation, implementing the principle of least privileges helps ensure that users have only the minimum level of access needed to perform their tasks. Furthermore, regular auditing of users’ privileges helps in recognizing suspicious activities.

###### What are the post-exploitation steps?

After a threat actors compromise targeted systems, they attempt to expand their foothold on the network by compromising additional systems and setting up backdoor access.

After successfully detecting threads and exploiting them, reporting is one of the most important elements of any penetration test.

###### What are the penetration testing approaches?

* **White Box:** in this approach penetration tester is provided with full information about the targets, and is usually given credentials with varying degrees of access to quickly and thoroughly identify vulnerabilities.
* **Black Box:** the most common form of penetration testing and most typical among external network penetration tests and social engineering penetration tests. Penetration testers are given very little or no information about the target.
* **Gray Box:** penetration testers are given enough information to only reduce assessment time.

###### What is the difference between vulnerability assessment and penetration testing?

In a vulnerability assessment, the cybersecurity professional uses a vulnerability scanner to perform authenticated and unauthenticated scans. There are downsides to using only automation tests when performing penetration tests and it is highly unethical to only report the result of vulnerability scanning tools. The most effective security assessment involves the combination of manual and automation tests.

###### What are the phases of exploitation?

1. Reconnaissance
2. Scanning and Enumeration
3. Gaining Access
4. Maintaining Access
5. Covering Tracks

---

# Linux Administration
# The Ultimate Kali Linux Book
## book
## Packt Publishing
### chapter
### Glen D. Singh
#### surface

#### Penetration Testing
##### Building a Penetration Testing Lab

###### Setup the latest Metasploit?

Metasploit is available on https://metasploit.com.

```sh
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod u+x msfinstall
./msfinstall
```

Once installed, the binary can be found in `/opt/metasploit-framework/bin`.






















