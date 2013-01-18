Concept
=======

  When landing on a new machine(vm) with none of your cusomized environment
settings, pull this git repo and use the contents do 'deploy' your environment
into your new account.

how-to
------

* bootstrap by running 'install.py' from your home directory.
  
rcn
--

* Those 'rc' files.  (rc = Recource Configuration)


bin
---

* Custom scripts normally deployed in the users ~/bin


sbin
----

* Scripts "internal" to this project that acomplish automation.


ssh
---

  > cd ~
  > gpg env/ssh/ssh-bootstrap.tgz.asc
  > tar -xvzf ssh-bootstrap.tgz
  > ln -s ssh-bootstrap .ssh
  > git clone git-repository:ssh.git ssh
  > ln -sf ssh .ssh
  > rm -rf ssh-bootstrap*
  
ssh Rebuild
-----------
  < Rebuild ~/ssh-bootstrap >
  > cd ~
  > tar -cvzf ssh-bootstrap.tgz ssh-bootstrap
  > gpg -ac ssh-bootstrap.tgz
  > cp ssh-bootstrap.tgz.asc ~/env/ssh
  

----
<pre>
  Local Variables:
  mode: markdown
  comment-column: 80
  End:
</pre>
