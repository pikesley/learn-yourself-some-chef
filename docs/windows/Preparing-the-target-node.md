# Preparing the target node

Thanks to Windows licensing restrictions, we can't include a Windows Vagrant node in this tutorial. :(  
So, you'll have to fire up a Windows Server 2008 R2 test node in some other way - one of the Amazon EC2 quickstart AMIs works just great.

We'll start it in a minute, but first we need to push some Chef environments to our new chef server. The environments, 'studio' and 'live', are already defined in the chef-repo, so we can do (from inside the learn-yourself-some-chef/ directory):

   knife environment from file chef-repo/environments/studio.rb
   knife environment from file chef-repo/environments/live.rb

I don't know why there isn't a Rake task for this, and I don't enough about Rake (yet) to fix it. Anyway, we should now be able to see them here (we'll dig into what these are a bit later).

##Bootstrapping the Windows node

I'm using a Amazon EC2 Microsoft Windows Server 2008 R2 Base node:
<img src="select_ec2_ami.png" />

Fire up the node, and RDP in as Administrator.

Open Powershell, and download & install the chef-client msi

    PS C:\Users\Administrator> Import-Module BitsTransfer; Start-BitsTransfer -source "http://opscode.com/chef/install.msi"; .\install.msi /qb

Wait till the MSI installation is completed, then close & reopen your Powershell window.  Test chef-client is installed:

    PS C:\Users\Administrator> chef-client --version
    Chef: 0.10.8

Hurrah!

Now we need to register our Windows node with the chef server

    PS C:\Users\Administrator> knife configure client c:\Chef
    WARNING: No knife configuration file found
    Creating client configuration
    Writing client.rb
    Writing validation.pem
    ERROR: Errno::ENOENT: No such file or directory - /etc/chef/validation.pem

Edit client.rb

    PS C:\Users\Administrator> notepad C:/Chef/client.rb

To look something like the following:

    log_level        :info
    log_location     STDOUT
    chef_server_url  'http://{your.chef.server.external.dns}'
    validation_client_name 'chef-validator'
    validation_key   "C:/chef/validation.pem"
    client_key       "C:/chef/client.pem"
    file_cache_path  "C:/chef/cache"
    cache_type       "BasicFile"
    cache_options    ({ :path => "C:/chef/cache/checksums", :skip_expires => true })

And make sure C:/Chef/validation.pem contains your chef validator private key

    PS C:\Users\Administrator> notepad C:/Chef/validation.pem

looks something like:

    -----BEGIN RSA PRIVATE KEY-----
    MIIEpAIB
    ..... many private lines ...
    Bck60T8b76MC2A==
    -----END RSA PRIVATE KEY-----

Finally lets run chef-client so it can register itself with our chef server

    PS C:\Users\Administrator>  chef-client -c C:\chef\client.rb
    [Tue, 24 Apr 2012 15:46:50 +0000] INFO: *** Chef 0.10.8 ***
    [Tue, 24 Apr 2012 15:48:06 +0000] INFO: Client key C:/chef/client.pem is not present - registering
    [Tue, 24 Apr 2012 15:48:29 +0000] INFO: HTTP Request Returned 404 Not Found: Cannot load node AMAZONA-13U3D33
    [Tue, 24 Apr 2012 15:48:30 +0000] INFO: Run List is []
    [Tue, 24 Apr 2012 15:48:30 +0000] INFO: Run List expands to []
    [Tue, 24 Apr 2012 15:48:30 +0000] INFO: Starting Chef Run for AMAZONA-13U3D33
    [Tue, 24 Apr 2012 15:48:30 +0000] INFO: Running start handlers
    [Tue, 24 Apr 2012 15:48:30 +0000] INFO: Start handlers complete.
    [Tue, 24 Apr 2012 15:48:30 +0000] INFO: Loading cookbooks []
    [Tue, 24 Apr 2012 15:48:30 +0000] WARN: Node AMAZONA-13U3D33 has an empty run list.
    [Tue, 24 Apr 2012 15:48:37 +0000] INFO: Chef Run complete in 7.192015 seconds
    [Tue, 24 Apr 2012 15:48:37 +0000] INFO: Running report handlers
    [Tue, 24 Apr 2012 15:48:37 +0000] INFO: Report handlers complete

And if you check your node list in chef server you should see a new entry.

Double Hurrah!

So let's move on to uploading the dummy cookbooks.