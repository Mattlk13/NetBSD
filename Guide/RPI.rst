.. 
 Copyright (c) 2013-2022 Jun Ebihara All rights reserved.
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 .. todo:: :1,$s/2016-11-12/2016-11-12/g
 .. todo:: :1,$s?2015/06/27?2015/06/27?g
 .. todo:: apache+php+mysql設定
 .. todo:: uim-pref-gtk
 .. todo:: webkit-gtk
 .. todo:: icewmの設定方法を書く
 .. todo:: btキーボード・マウス
 .. todo:: deforaos-* をテスト
 .. todo:: lang/ocamlをテスト
 .. todo:: lang/squeak
 .. todo:: www/wordpress
 .. todo:: puppetまたはansibleで設定する
 .. todo:: KOBO起動方法＆テスト
 .. todo:: beaglebone black テスト v7
 .. todo:: port-arm:2013/8/29 Radoslaw Kujawa
 .. todo:: For I2C consult the iic(4) man page, also see the i2cscan(8) utility and its source.
 .. todo:: For GPIO see gpio(4) man page.
 .. todo:: For SPI as far as I know there are no generic user-space components provided, besides support for SPI flashes.
 .. todo:: .build.sh -j -u -U -a earmv6hf -m evbarm iso-image

=================================
RaspberryPIでNetBSDを使ってみる
=================================

特徴
----

* NetBSDをRaspberryPIで利用するために、ディスクイメージを用意しました。
* Xが動いて、ご家庭のテレビでmikutterが動きます。
* うまく動いたら、動いた記念写真をツイートだ！
* fossil(http://www.fossil-scm.org/)も入れてあります。家庭内Webサーバとかチケットシステムとかwikiサーバになるんでないかい。

準備するもの
-------------
* RaspberryPI本体
* HDMI入力のあるテレビ／ディスプレイ
* USBキーボード
* USBマウス
* 有線ネットワーク

ケースは Geekworm Raspberry Pi 3/4ケースをそれぞれ使っています。

起動ディスクの作成
-------------------
* ディスクイメージのダウンロード

::

 earmv6hf 
 # ftp http://cdn.netbsd.org/pub/NetBSD/misc/jun/raspberry-pi/
 2016-11-12-earmv6hf/2016-11-12-netbsd-raspi-earmv6hf.img.gz
 
* 2GB以上のSDカードを準備します。
* ダウンロードしたディスクイメージを、SDカード上で展開します。

::

	disklabel sd0  ..... 必ずインストールするSDカードか確認してください。
	gunzip < 2016-11-12-netbsd-raspi-earmv6hf.img.gz.gz|dd of=/dev/rsd0d bs=1m

NetBSD Arm Bootable Images
-------------------------------

 NetBSD Arm Bootable Images が、https://nycdn.netbsd.org/pub/arm/ 以下にあります。
 RPIと同じ手順で起動できます。

RaspberryPIの起動
------------------
#. HDMIケーブル／USBキーボード/USBマウス/有線ネットワークをRPIにさします。
#. 電源を入れてRPIを起動します。
#. 少し待つと、HDMIからNetBSDの起動メッセージが表示されます。
#. メモリカードの容量にあわせたサイズまでルートパーティションを自動調整します。(現在、RPI2では自動調整プログラムの起動が失敗します)
#. 容量調整後に再起動します。再起動した後は、起動プロセスが最後まで進み、ログインできる状態になります。
#. 起動しない場合、まず基板上のLEDを確認してください。

*赤いランプのみ点灯している場合*
 - OSを正しく読み込めていません。
 - 少なくともMSDOS領域に各種ファームウェアファイルが見えていることを確認する。
 - SDカードの接触不良の可能性があるので、SDカードを挿しなおしてみる。
 - ファームウェアが古いため起動しない
*緑のランプも点灯している場合*
 - OSは起動しているのに画面をHDMIに表示できていません。
 - HDMIケーブルを差した状態で電源ケーブルを抜き差しして、HDMIディスプレイに何か表示するか確認する。
 - HDMIケーブル自体の接触不良。ケーブルを何度か差し直してください。
 - 電源アダプタ容量には、少なくとも800mA程度の容量を持つアダプタを使ってみてください。スマートフォン用のアダプタならまず大丈夫です。起動途中で画面が一瞬消えたり、負荷をかけるといきなり再起動したりする場合は、電源やUSBケーブルを気にしてみてください。

ログイン
---------
 rootでログインできます。rootアカウントではリモートからログインすることはできません。

::

 login: root

 startxでicewmが立ち上がります。

::

 # startx

mikutterを使ってみよう
----------------------
* xtermからdilloとmikutterを起動します。

::

	# dillo &
	# mikutter &

* しばらく待ちます。
* mikutterの認証画面がうまく出たら、httpsからはじまるURLをクリックするとdilloが起動します。
* twitterのIDとパスワードを入力すると、pin番号が表示されます。pin番号をmikutterの認証画面に入力します。
* しばらくすると、mikutterの画面が表示されます。表示されるはずです。落ちてしまう場合は時計が合っているか確認してください。
* 漢字は[半角/全角]キーを入力すると漢字モードに切り替わります。anthyです。
* 青い鳩を消したいとき：mikutterのプラグインを試してみる

::

% touch ~/.mikutter/plugin/display_requirements.rb

　すると、鳩が消えます。
mikutterはプラグインを組み込むことで、機能を追加できる自由度の高いtwitterクライアントです。プラグインに関しては、「mikutterの薄い本 プラグイン」で検索してみてください。

fossilを使ってみよう
----------------------
fossilは、Wiki/チケット管理システム/HTTPサーバ機能を持つ、コンパクトなソースコード管理システムです。fossilバイナリひとつと、リポジトリファイルひとつにすべての情報が集約されています。ちょっとしたメモをまとめたりToDoリストを簡単に管理できます。

::

 % fossil help
 Usage: fossil help COMMAND
 Common COMMANDs:  (use "fossil help -a|--all" for a complete list)
 add         changes     finfo       merge       revert      tag       
 addremove   clean       gdiff       mv          rm          timeline  
 all         clone       help        open        settings    ui        
 annotate    commit      import      pull        sqlite3     undo      
 bisect      diff        info        push        stash       update    
 branch      export      init        rebuild     status      version   
 cat         extras      ls          remote-url  sync      
 %  fossil init sample-repo
 project-id: bcf0e5038ff422da876b55ef07bc8fa5eded5f55
 server-id:  5b21bd9f4de6877668f0b9d90b3cff9baecea0f4
 admin-user: jun (initial password is "f73efb")
 %  ls -l 
 total 116
 -rw-r--r--  1 jun  users  58368 Nov 14 18:34 sample-repo
 % fossil server sample-repo -P 12345 &
 ブラウザでポート12345にアクセスし、fossil initを実行した時のユーザとパスワードでログインします。

キーマップの設定を変更する
--------------------------
* ログインした状態でのキーマップは/etc/wscons.confで設定します。

::

	encoding jp.swapctrlcaps .... 日本語キーボード,CtrlとCAPSを入れ替える。

* Xでのキーマップは.xinitrcで設定します。

::

	setxkbmap -model jp106 jp -option ctrl:swapcap


コンパイル済パッケージをインストールする
--------------------------------------------------
* コンパイルしたパッケージを以下のURLに用意しました。

::

 % cat /etc/pkg_install.conf
　PKG_PATH=http://cdn.netbsd.org/pub/NetBSD/misc/jun/raspberry-pi/earmv6hf/2016-11-12

* パッケージのインストール

 pkg_addコマンドで、あらかじめコンパイル済みのパッケージをインストールします。関連するパッケージも自動的にインストールします。

::

 # pkg_add zsh

* パッケージの一覧

 pkg_infoコマンドで、インストールされているパッケージの一覧を表示します。

::

	# pkg_info

* パッケージの削除

::

	# pkg_delete パッケージ名


/usr/pkgsrcを使ってみよう
--------------------------

 たとえばwordpressをコンパイル／インストールする時には、以下の手順で行います。

::

 # cd /usr/
 # ls /usr/pkgsrc               ... 上書きしてしまわないか確認
 # ftp http://cdn.netbsd.org/pub/pkgsrc/current/pkgsrc.tar.gz
 # tar tzvf pkgsrc.tar.gz |head ... アーカイブの内容確認
 # tar xzvf pkgsrc.tar.gz　　　　　　　
 # ls /usr/pkgsrc
 # cd /usr/pkgsrc/www/php-ja-wordpress
 # make package-install



 # cd /usr/pkgsrc
 # cvs update -PAd

パッケージ管理
----------------

 pkg_chk コマンドを使って、インストールしたパッケージを管理してみましょう。あらかじめpkgsrcの内容を更新しておきます。どこからパッケージファイルを取得するかは、/etc/pkg_install.confのPKG_PATHに書いておきます。

::

 # pkg_info    ... インストールしているパッケージ名と概要を出力します。
 # pkg_chk -g  ... 使っているパッケージの一覧を/usr/pkgsrc/pkgchk.confに作ってくれます。
 # pkg_chk -un ... パッケージをアップデートします。（nオプション付きなので実行はしません)
 # pkg_chk -u  ... パッケージをアップデートします。

ユーザー作成
--------------

::

	# useradd -m jun
	# passwd jun
　root権限で作業するユーザーの場合：
	# useradd -m jun -G wheel
       # passwd jun

サービス起動方法
----------------
  /etc/rc.d以下にスクリプトがあります。dhcpクライアント(dhcpcd)を起動してみます。

::

 テスト起動：
   /etc/rc.d/dhcpcd onestart
 テスト停止：
   /etc/rc.d/dhcpcd onestop

 
正しく動作することが確認できたら/etc/rc.confに以下のとおり指定します。
   dhcpcd=YES
  /etc/rc.confでYESに指定したサービスは、マシン起動時に同時に起動します。

::

 起動:
   /etc/rc.d/dhcpcd start
 停止：
   /etc/rc.d/dhcpcd stop
 再起動：
  /etc/rc.d/dhcpcd restart

vndconfigでイメージ編集
------------------------

NetBSDの場合、vndconfigコマンドでイメージファイルの内容を参照できます。

::

 # gunzip 2016-11-12-netbsd-raspi-earmv6hf.img.gz
 # vndconfig vnd0 2016-11-12-netbsd-raspi-earmv6hf.img
 # vndconfig -l
 vnd0: /usr (/dev/wd0e) inode 53375639
 # disklabel vnd0
 　　 :
 8 partitions:
 #        size    offset     fstype [fsize bsize cpg/sgs]
 a:   3428352    385024     4.2BSD      0     0     0  # (Cyl.    188 -   1861)
 b:    262144    122880       swap                     # (Cyl.     60 -    187)
 c:   3690496    122880     unused      0     0        # (Cyl.     60 -   1861)
 d:   3813376         0     unused      0     0        # (Cyl.      0 -   1861)
 e:    114688      8192      MSDOS                     # (Cyl.      4 -     59)
 # mount_msdos /dev/vnd0e /mnt
 # ls /mnt
 LICENCE.broadcom    cmdline.txt         fixup_cd.dat        start.elf
 bootcode.bin        fixup.dat           kernel.img          start_cd.elf
 # cat /mnt/cmdline.txt
 root=ld0a console=fb
 #fb=1280x1024           # to select a mode, otherwise try EDID 
 #fb=disable             # to disable fb completely

 # umount /mnt
 # vndconfig -u vnd0

HDMIじゃなくシリアルコンソールで使うには
----------------------------------------
* MSDOS領域にある設定ファイルcmdline.txtの内容を変更してください。
https://raw.github.com/Evilpaul/RPi-config/master/config.txt

::

 fb=1280x1024           # to select a mode, otherwise try EDID 
 fb=disable             # to disable fb completely

起動ディスクを変えるには
------------------------
* MSDOS領域にある設定ファイルcmdline.txtの内容を変更してください。

::

 root=sd0a console=fb ←ld0をsd0にするとUSB接続したディスクから起動します

最小構成のディスクイメージ
--------------------------
  NetBSD-currentのディスクイメージに関しては、以下の場所にあります。日付の部分は適宜読み替えてください。

::

 # ftp://nyftp.netbsd.org/pub/NetBSD-daily/HEAD/201502042230Z/evbarm-earmv6hf/binary/gzimg/rpi_inst.bin.gz
 # gunzip < rpi_inst.bin.gz |dd of=/dev/rsd3d bs=1m   .... sd3にコピー。

  RaspberryPIにsdカードを差して、起動すると、#　プロンプトが表示されます。
 # sysinst      .... NetBSDのインストールプログラムが起動します。

X11のインストール
------------------
 rpi.bin.gzからインストールした場合、Xは含まれていません。追加したい場合は、

　ftp://nyftp.netbsd.org/pub/NetBSD-daily/HEAD/201310161210Z/evbarm-earmv6hf/binary/sets/ 以下にあるtarファイルを展開します。tarで展開するときにpオプションをつけて、必要な権限が保たれるようにしてください。

::

 tar xzpvf xbase.tar.gz -C /     .... pをつける

クロスビルドの方法
------------------
* ソースファイル展開
* ./build.sh -U -m evbarm -a earmv6hf release
* earm{v[4567],}{hf,}{eb} earmv4hf
* http://mail-index.netbsd.org/tech-kern/2013/11/12/msg015933.html

.. csv-table::

 acorn26,armv2
 acorn32,armv3 armv4 (strongarm)
 cats shark netwinder, armv4 (strongarm)
 iyonix,armv5
 hpcarm,armv4 (strongarm) armv5.
 zaurus,armv5
 evbarm,armv5/6/7


外付けUSB端子
--------------
  NetBSDで利用できるUSBデバイスは利用できる（はずです)。電源の制約があるので、十分に電源を供給できる外付けUSBハブ経由で接続したほうが良いです。動作しているRPIにUSBデバイスを挿すと、電源の関係でRPIが再起動してしまう場合があります。その場合、電源を増強する基板を利用する方法もあります。

外付けSSD
--------------
 コンパイルには、サンディスク X110 Series SSD 64GB（読込 505MB/s、書込 445MB/s） SD6SB1M-064G-1022I　を外付けディスクケース経由で使っています。NFSが使える環境なら、NFSを使い、pkgsrcの展開をNFSサーバ側で実行する方法もあります。RPIにSSDを接続した場合、OSの種類と関係なく、RPI基板の個体差により、SSDが壊れる場合があるので十分注意してください。


液晶ディスプレイ
-----------------
  液晶キット( http://www.aitendo.com/page/28 )で表示できています。
aitendoの液晶キットはモデルチェンジした新型になっています。
On-Lap 1302でHDMI出力を確認できました。
HDMI-VGA変換ケーブルを利用する場合、MSDOS領域にある設定ファイルcmdline.txtで解像度を指定してください。

::

 https://twitter.com/oshimyja/status/399577939575963648
 とりあえずうちの1024x768の液晶の場合、 hdmi_group=2 hdmi_mode=16 の2行をconfig.txtに書いただけ。なんと単純。disable_borderはあってもなくても関係なし。


inode
-------
  inodeが足りない場合は、ファイルシステムを作り直してください。

	# newfs -n 500000 -b 4096 /dev/rvnd0a

bytebench
--------------
  おおしまさん(@oshimyja)がbytebenchの結果を測定してくれました。

 https://twitter.com/oshimyja/status/400306733035184129/photo/1
 https://twitter.com/oshimyja/status/400303304573341696/photo/1


壁紙
-----
  おおしまさん(@oshimyja)ありがとうございます。

::

  http://www.yagoto-urayama.jp/~oshimaya/netbsd/Proudly/2013/


--

パーティションサイズをSDカードに合わせる
-----------------------------------------
　2GB以上のSDカードを利用している場合、パーティションサイズをSDカードに合わせることができます。この手順はカードの内容が消えてしまう可能性もあるため、重要なデータはバックアップをとるようにしてください。
  手順は、http://wiki.netbsd.org/ports/evbarm/raspberry_pi/ のGrowing the root file-systemにあります。

シングルユーザでの起動
"""""""""""""""""""""
#. /etc/rc.confのrc_configured=YESをNOにして起動します。
#.  戻すときはmount / ;vi /etc/rc.conf　でNOをYESに変更してrebootします。

参考URL
--------
* http://wiki.netbsd.org/ports/evbarm/raspberry_pi/
* NetBSD Guide http://www.netbsd.org/docs/guide/en/
* NetBSD/RPiで遊ぶ(SDカードへの書き込み回数を気にしつつ)  http://hachulog.blogspot.jp/2013/03/netbsdrpisd.html
* http://www.raspberrypi.org/phpBB3/viewforum.php?f=86 NetBSDフォーラム
* http://www.raspberrypi.org/phpBB3/viewforum.php?f=82 日本語フォーラム


