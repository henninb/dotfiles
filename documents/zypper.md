zypper repos
sudo zypper mr -e 6
zypper repos
sudo zypper mr -e 7
sudo zypper refresh

https://en.opensuse.org/images/1/17/Zypper-cheat-sheet-1.pdf


Repository priorities are without effect. All enabled repositories share the same priority.

# | Alias                            | Name                                            | Enabled | GPG Check | Refresh
--+----------------------------------+-------------------------------------------------+---------+-----------+--------
1 | devel_tools                      | Generic Development Tools (openSUSE_Tumbleweed) | Yes     | (r ) Yes  | No
2 | download.opensuse.org-non-oss    | Main Repository (NON-OSS)                       | Yes     | (r ) Yes  | Yes
3 | download.opensuse.org-oss        | Main Repository (OSS)                           | Yes     | (r ) Yes  | Yes
4 | download.opensuse.org-tumbleweed | Main Update Repository                          | Yes     | (r ) Yes  | Yes
5 | openSUSE-20200318-0              | openSUSE-20200318-0                             | No      | ----      | ----
6 | repo-debug                       | openSUSE-Tumbleweed-Debug                       | Yes     | (r ) Yes  | Yes
7 | repo-source                      | openSUSE-Tumbleweed-Source                      | Yes     | (r ) Yes  | Yes


nix-env -i dzen2
installing 'dzen2-0.9.5'
warning: error: unable to download 'https://cache.nixos.org/s469v52vf927f6y8dyim2m56fh328q1l.narinfo': SSL connect error (35); retrying in 255 ms
warning: error: unable to download 'https://cache.nixos.org/s469v52vf927f6y8dyim2m56fh328q1l.narinfo': SSL connect error (35); retrying in 685 ms
warning: error: unable to download 'https://cache.nixos.org/s469v52vf927f6y8dyim2m56fh328q1l.narinfo': SSL connect error (35); retrying in 1040 ms
warning: error: unable to download 'https://cache.nixos.org/s469v52vf927f6y8dyim2m56fh328q1l.narinfo': SSL connect error (35); retrying in 2598 ms
error: unable to download 'https://cache.nixos.org/s469v52vf927f6y8dyim2m56fh328q1l.narinfo': SSL connect error (35)

Self resolved. It worked after running sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf.

/etc/nix/nix.conf:

sudo nix-channel --update
