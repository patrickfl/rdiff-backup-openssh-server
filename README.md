# rdiff-backup-openssh-server
## Summary
Docker Image for a rdiff-backup target with openssh-server

## Details
This image is proving a openssh server with rdiff-backup service.
For backup purposes a a user rdiff-backup is been created.
The container allows only key-authentication any password authentication has been disabled.

## Usage example
    docker run -d -p 2222:22 -v /secrets/id_rsa.pub:/home/rdiff-backup/.ssh/authorized_keys patrickfl/rdiff-backup-openssh-server
