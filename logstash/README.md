# Configuration details for Senzing Integration

## Using a Kubernetes ConfigMap and Secret

* You can define the variables in a ConfigMap (for non-sensitive data like QS_ES_HOSTS) and a Secret (for sensitive data like QS_ES_USER, QS_ES_PASSWORD, and QS_ES_SSL_CERTIFICATE_AUTHORITY).

## TLS Certificates


* The variable QS_ES_SSL_CERTIFICATE_AUTHORITY in the line:

```
ssl_certificate_authorities => "${QS_ES_SSL_CERTIFICATE_AUTHORITY}"
```

... is used to specify the path or content of the Certificate Authority (CA) certificate that Logstash should trust when connecting to an Elasticsearch cluster over SSL/TLS. This certificate ensures that Logstash can verify the identity of the Elasticsearch server and establish a secure connection.

* How to Generate QS_ES_SSL_CERTIFICATE_AUTHORITY

The value for QS_ES_SSL_CERTIFICATE_AUTHORITY typically needs to be a Base64-encoded version of the CA certificate or the file path where the certificate is stored. Here's how to generate or acquire it:

1. Obtain the CA Certificate

Option A: From Elasticsearch Setup

* If you are using a self-managed Elasticsearch cluster, you might have created a CA during the initial setup.
* Locate the CA certificate file, which might be named ca.crt or elasticsearch-ca.pem.
* For example, if using Elasticsearch's elasticsearch-certutil, it generates the CA file as part of the certs directory.

2. Option B: From Managed Services

* If using a managed Elasticsearch service (e.g., AWS OpenSearch or Elastic Cloud), the provider will usually give you the CA certificate as part of the service's setup documentation. Download it to your local machine.

2. Encode the CA Certificate to Base64

* If the QS_ES_SSL_CERTIFICATE_AUTHORITY value is required in Base64 format (e.g., when stored in a Kubernetes Secret), encode the certificate using the following commands:

```
cat /path/to/ca.crt | base64 -w 0 > ca.crt.base64
```

3. Store the CA Certificate

* You can supply the value of QS_ES_SSL_CERTIFICATE_AUTHORITY to Logstash in multiple ways, depending on your setup:

Option A: File Path

* Save the CA certificate in the Logstash container or host file system.
* Reference it directly in the configuration:

```
ssl_certificate_authorities => "/path/to/ca.crt"
```

Option B: Kubernetes Secret

* Create a Kubernetes Secret containing the Base64-encoded certificate:

```
kubectl create secret generic logstash-certificates \
  --from-file=ca.crt=/path/to/ca.crt \
  -n logstash
```

* Mount the Secret as a file in the Logstash pod or inject it as an environment variable:

```
env:
  - name: QS_ES_SSL_CERTIFICATE_AUTHORITY
    valueFrom:
      secretKeyRef:
        name: logstash-certificates
        key: ca.crt
```

Option C: Inline Environment Variable

** NOT RECOMMENDED **

* Export the Base64-encoded CA certificate as an environment variable:

```
export QS_ES_SSL_CERTIFICATE_AUTHORITY=$(cat /path/to/ca.crt | base64 -w 0)
```

4. Validate the Connection

* After setting up the CA certificate, test the connection between Logstash and Elasticsearch to ensure SSL/TLS works as expected. 
* You can enable debug logs in Logstash to troubleshoot issues related to SSL verification.
* This process ensures secure communication between Logstash and Elasticsearch by validating the server's SSL certificate with the trusted CA. Let me know if you need further guidance!



## References

* https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-logstash-quickstart.html


