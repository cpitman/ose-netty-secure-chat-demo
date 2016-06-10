OpenShift Netty Secure Chat Demo
================================

One of the features of OpenShift v3 is the ability to host and load balance
non-HTTP/S applications as long as they use TLS and clients support SNI.

SNI (Server Name Indication) is very simple in concept: in order for a load
balancer to know which application to send traffic to, it needs to know the
hostname that the user is trying to connect to. But with TLS, all the traffic 
is encrypted! SNI adds the plain text hostname to the handshake, which can be
used by the OpenShift Router to forward traffic to the right pod.

This demo creates a template for a simple example application from the Netty
project, a TLS based chat server. After using the template to create an app,
you'll be able to use command line tools to connect to the pod and send 
messages to other users!

How To Use
----------

Everything that you need to use this demo is in the `ose` folder. Execute the 
following either in the `openshift` project or a standalone project:

```
oc create -f ose/
oc import-image java
```

After creating the template, instantiate the template in a project. The easiest
way to do this is to login to the web console, open a project, and select "Add
to Project". The select "netty-secure-chat" and follow the wizard.

It will then take up to a couple minutes for all of the resources to be pulled 
down and the build to complete. Once the pod is deployed, lookup the hostname
of the deployed route. Then execute the following to test it (replacing 
`$HOSTNAME` with your own route):

```
openssl s_client -servername $HOSTNAME -connect $HOSTNAME:443
```

For example:

```
openssl s_client -servername chat-test-chat2.rhel-cdk.10.1.2.2.xip.io -connect chat-test-chat2.rhel-cdk.10.1.2.2.xip.io:443
```

Once connected to the app, you can the send a message by enter a line of text 
and pressing `Enter`. Multipl eusers can login at the same time using the same
command and then send messages to each other.

Thats it: A simple demo of deploying TCP applications to OSE.
