# s3-synchronizer

This program loads the S3 data on local file system by copying the data from S3 bucket based on the specified S3 mounts (i.e., `defaultS3Mounts`) JSON configuration.
The program does not download any further changes to objects in s3 beyond the initial download.

## Prerequisites

#### Tools

- Go 1.13.7+

## Usage

```bash
$ s3-synchronizer-darwin-amd64 -h
Usage of bin/s3-synchronizer-darwin-amd64:
  -defaultS3Mounts string
        A JSON string containing information about the default S3 mounts 
        E.g., [{"id":"some-id","bucket":"some-s3-bucket-name","prefix":"some/s3/prefix/path","writeable":false,"kmsKeyId":"some-kms-key-arn"}]
        The "writeable" is not implemented yet but supported in the JSON structure, for future.
  -concurrency int
        The number of concurrent parts to download (default 20)
  -debug
        Whether to print debug information
  -destination string
        The directory to download to (default "./")
  -pollInterval int
        The delay (in seconds) between api http requests (default 60)
  -region string
        The aws region to use for the session (default "us-east-1")
  -profile string
        AWS Credentials profile. Default is no profile. The code will look for credentials in the following order: ENV variables, default credentials profile, EC2 instance metadata
```

## Building

```bash
$ ./build.sh
```