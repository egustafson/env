Cygwin Bootstrap Notes
======================

create /etc/passwd
------------------

* `mkpasswd -l > /etc/passwd`

remount /home
-------------

* https://cygwin.com/cygwin-ug-net/using.html#using-pathnames

    /etc/fstab.d/<username>
    
    c:/Users/<username>/<cygwin-home-path>    /home/<username>    ntfs    binary     0    0


list installed packages
-----------------------

* `cygcheck -s`
