Ubuntu + HHVM + CakePHP3
==================

* Ubuntu 14.04 LTS
* Nginx
* HHVM
* CakePHP3

以下のアプリケーションのインストールが必要です

* VirtualBox
* Vagrant
* Berkshelf

以下のVagrantプラグインが必要です

* vagrant-omnibus

Vagrantを起動する前にBerkshelfでcookbookをダウンロードしてください
```
berks vendor cookbooks
```

準備ができたらVagrantを起動してください
```
vagrant up
```

http://192.168.33.30
