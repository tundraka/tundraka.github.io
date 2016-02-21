# Notes

### node
Used [nvm](2). Instruction in the README.

### sshd
- Restarting: `sudo service ssh restart`

### nginx
- Edit configuration: `sudo vi /etc/nginx/sites-enabled`
- Restart nginx: `sudo service nginx reload`

### iptables
- From [here](1)
- Installing iptables-persist: `sudo apt-get install iptables-persistent`
- ipv4 conf: `/etc/iptables/rules.v4`
- ipv6 conf: `/etc/iptables/rules.v6`
- Testing ipv4 conf: `sudo iptables-restore -t /etc/iptables/rules.v4`
- Testing ipv6 conf: `sudo ip6tables-restore -t /etc/iptables/rules.v6`
- Reloading changes: `sudo service iptables-persistent reload`
- Looking at ipv4 changes: `sudo iptables -S`
- Looking at ipv6 changes: `sudo ip6tables -S`
- Flush all rules: `sudo service iptables-persistent flush`

[1]: https://www.digitalocean.com/community/tutorials/how-to-implement-a-basic-firewall-template-with-iptables-on-ubuntu-14-04
[2]: https://github.com/creationix/nvm
