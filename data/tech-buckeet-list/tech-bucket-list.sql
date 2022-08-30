CREATE TABLE tech_bucket_list (
  _id integer primary key autoincrement,
  description TEXT NOT NULL UNIQUE,
  difficulty INT,
  effort INT,
  priority INT,
  reoccurring INT,
  effort_type TEXT,
  complete datetime,
  last_updated datetime default current_timestamp,
  date_created datetime default current_timestamp
);


insert into tech_bucket_list(description) VALUES('setup ddwrt web frontend certificate');
insert into tech_bucket_list(description) VALUES('port rapi-finance-endpoint to ktor');
insert into tech_bucket_list(description) VALUES('port rapi-finance-endpoint to rust');
insert into tech_bucket_list(description) VALUES('code submenu names in xmonad');
insert into tech_bucket_list(description) VALUES('find a project to work on - fiverr.com - become a seller');
insert into tech_bucket_list(description) VALUES('setup webserver for brianhenning.xyz');
insert into tech_bucket_list(description) VALUES('build aes encrypt a file using haskell');
insert into tech_bucket_list(description) VALUES('fix shell script to use new git pattern');
insert into tech_bucket_list(description) VALUES('virtualize pihole on docker proxmox');
insert into tech_bucket_list(description) VALUES('code an android app');
insert into tech_bucket_list(description) VALUES('record live tv on linux with silicondust hdhomerun');
insert into tech_bucket_list(description) VALUES('learn to use obs for content creation');
insert into tech_bucket_list(description) VALUES('practice squashing with git');
insert into tech_bucket_list(description) VALUES('build an app to stream audio to an android phone');
insert into tech_bucket_list(description) VALUES('update main windows 10 machine to the latest version');
insert into tech_bucket_list(description) VALUES('linux - swap init program with bash (testing)');
insert into tech_bucket_list(description) VALUES('virtualize plexserver on docker in proxmox');
insert into tech_bucket_list(description) VALUES('virtualize nextcloud on docker in proxmox');
insert into tech_bucket_list(description) VALUES('backup 2fa codes');
insert into tech_bucket_list(description) VALUES('backup photos');
insert into tech_bucket_list(description) VALUES('selfhost nextcloud (dropbox replacement)');
insert into tech_bucket_list(description) VALUES('learn more about digital ocean');
insert into tech_bucket_list(description) VALUES('learn more about aws');
insert into tech_bucket_list(description) VALUES('learn more about azure');
insert into tech_bucket_list(description) VALUES('learn more about goodle cloud service');
insert into tech_bucket_list(description) VALUES('learn more about upcloud');
insert into tech_bucket_list(description) VALUES('lora - setup a sender/receiver');
insert into tech_bucket_list(description) VALUES('linux cross compiler for rasperrry pi arm');
insert into tech_bucket_list(description) VALUES('gpg key on yubikey');
insert into tech_bucket_list(description) VALUES('ssh key on yubikey');
insert into tech_bucket_list(description) VALUES('setup linux pam module for yubikey');
insert into tech_bucket_list(description) VALUES('spotify playlist extract');
insert into tech_bucket_list(description) VALUES('learn traefik (reverse proxy)');
insert into tech_bucket_list(description) VALUES('python spotify');
insert into tech_bucket_list(description) VALUES('lean gimp basics - distrotube');
insert into tech_bucket_list(description) VALUES('create profile avitar');
insert into tech_bucket_list(description) VALUES('finance app to output a budget');
insert into tech_bucket_list(description) VALUES('JOOQ update and delete');
insert into tech_bucket_list(description) VALUES('mine crypto currency');
insert into tech_bucket_list(description) VALUES('automate bridge setup');
insert into tech_bucket_list(description) VALUES('learn blender - make something 3D');
insert into tech_bucket_list(description) VALUES('make my own PCB');
insert into tech_bucket_list(description) VALUES('install FreeNAS');
insert into tech_bucket_list(description) VALUES('finance_db with redis backend');
insert into tech_bucket_list(description) VALUES('finance_db with mongodb backend');
insert into tech_bucket_list(description) VALUES('build hardware hackintosh');
insert into tech_bucket_list(description) VALUES('docker run void');
insert into tech_bucket_list(description) VALUES('install haikuOS');
insert into tech_bucket_list(description) VALUES('raspberian cross compiler in c on gentoo');
insert into tech_bucket_list(description) VALUES('setup heroku dns with cloudflare');
insert into tech_bucket_list(description) VALUES('gentoo primary system');
insert into tech_bucket_list(description) VALUES('dictation linux');
insert into tech_bucket_list(description) VALUES('dictation macos');
insert into tech_bucket_list(description) VALUES('fix ddwrt reverse proxy issue');
insert into tech_bucket_list(description) VALUES('docker dns server on debian');
insert into tech_bucket_list(description) VALUES('setup bastion host');
insert into tech_bucket_list(description) VALUES('learn kali linux');
insert into tech_bucket_list(description) VALUES('subdomain for fastly app');
insert into tech_bucket_list(description) VALUES('learn kuberneties');
insert into tech_bucket_list(description) VALUES('gentoo setup and build custom kernel');
insert into tech_bucket_list(description) VALUES('monthly backup ddwrt, pihole, pfsense');
insert into tech_bucket_list(description) VALUES('migrate cert script to react and other apps');
insert into tech_bucket_list(description) VALUES('setup fastly VCL');
insert into tech_bucket_list(description) VALUES('learn replay attack for cookies');
insert into tech_bucket_list(description) VALUES('setup nvim LSP');
insert into tech_bucket_list(description) VALUES('build nvim LSP script for download');
insert into tech_bucket_list(description) VALUES('learn express http router');
insert into tech_bucket_list(description) VALUES('install portainer front end for docker');
insert into tech_bucket_list(description) VALUES('build sqlite for contacts');
insert into tech_bucket_list(description) VALUES('build sqlite for tech bucket list');
insert into tech_bucket_list(description) VALUES('learn BOLA and IDOR');
insert into tech_bucket_list(description) VALUES('setup proxmox certificate');
insert into tech_bucket_list(description) VALUES('fix pfsense certificate');
insert into tech_bucket_list(description) VALUES('setup splunk in proxmox debian docker');
insert into tech_bucket_list(description) VALUES('nix packages to replace flatpak');
insert into tech_bucket_list(description) VALUES('setup openwrt test network');
insert into tech_bucket_list(description) VALUES('setup console fonts');
insert into tech_bucket_list(description) VALUES('setup origin upstream from fastly');
insert into tech_bucket_list(description) VALUES('setup linux color scheme everforest');
insert into tech_bucket_list(description) VALUES('update lua nvim config');
insert into tech_bucket_list(description) VALUES('setup https on the pihole');
insert into tech_bucket_list(description) VALUES('fix xmonad warnings');
insert into tech_bucket_list(description) VALUES('setup docker redis server');
insert into tech_bucket_list(description) VALUES('setup macvlan docker');
insert into tech_bucket_list(description) VALUES('replace sudo with doas');

insert into tech_bucket_list(description) VALUES('install bottles gentoo');
insert into tech_bucket_list(description) VALUES('sunset lastpass');
insert into tech_bucket_list(description) VALUES('convert bitwardent to keepass');
insert into tech_bucket_list(description) VALUES('use syncthing with keepass');
insert into tech_bucket_list(description) VALUES('fix mongodb  5 on gentoo');
insert into tech_bucket_list(description) VALUES('run a kvm version of freebsd to test dotfiles');
insert into tech_bucket_list(description) VALUES('lxc container running in proxmox');
insert into tech_bucket_list(description) VALUES('fix brave privacy mode full screen video from youtube');
insert into tech_bucket_list(description) VALUES('proxmox install backup server');
insert into tech_bucket_list(description) VALUES('learn about session cookies');
