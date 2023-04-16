## Eb3tly 

Peer to Peer (P2P) data transfer within LAN. Under heavy development 🚧.

- **Cross-platform support**<br>
  For instance you can transfer files between Android and Windows
- **Transfer multiple files**<br>
  You can pick any number of files.
- **Pick files faster**<br>
  Most of the apps use <a href='https://github.com/miguelpruivo/flutter_file_picker'>file_picker</a> for picking the files. But for android it caches files before retrieving the paths. If the file size is large it will result in considerable amount of delay. So I have tweaked <a href='https://github.com/abhi16180/flutter_file_picker'>file_picker</a> to avoid caching(android) *unless it is required (some files need to be cached)*. No matter how many files are selected ,paths will be retrieved within no time.
  (Note:Caching issue is android specific)
- **Smooth UI**<br>
  Material You design.
- **Works between the devices connected via mobile-hotspot / between the devices connected to same router (same local area network)**

- **Uses cryptographically secure secret code generation for authentication (internally).**<br>
 Even though the files are streamed at local area network,files cannot be downloaded/received without using Photon. No external client like browser can get the files using url,as secret code is associated with url. It will be regenerated for every session.
- **Supports high-speed data transfer** <br>
  Eb3tly is capable of transferring files at a very high rate but it depends upon the wifi bandwidth.
(No internet connection required)
