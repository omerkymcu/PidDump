# PidDump


Bu PowerShell betiği, kullanıcının girdiği bir program adıyla çalışan işlem kimliklerini (PID) bulmak için oluşturulmuştur. İlk adımda, kullanıcıdan bir program adı istenir ve Get-Process cmdlet'i kullanılarak tüm işlemler listelenir. Ardından, her işlem için, kullanıcının girdiği program adıyla eşleşen işlemlerin PID'leri toplanır ve bir diziye atanır.

Eğer PID listesi boşsa, "No running processes with name {program adı}" şeklinde bir mesaj görüntülenir. Aksi takdirde, PID'ler "pids.txt" dosyasına yazdırılır ve kaç tane PID'nin bulunduğu mesajı görüntülenir.

Daha sonra, procdump'u çağırmak için bir komut istemi penceresi açılır. $prodump_path değişkeninde belirtilen procdump.exe yolunu ve $file_path değişkeninde belirtilen pids.txt dosyasının yolunu kullanarak, PID'leri okur ve her biri için procdump'u çağırır. -s parametresi, procdump'un uygulamanın çökmesini bekleyeceği süreyi ve -m parametresi, alınacak hafıza görüntüsünün maksimum boyutunu belirtir. Her hafıza görüntüsü "spool-8_{PID}.dmp" adında bir dosyaya kaydedilir.

Eğer pids.txt dosyası bulunamazsa, "File not found: {pids.txt dosyasının yolu}" şeklinde bir mesaj görüntülenir. Aksi takdirde, procdump her PID için çağrılır ve hafıza görüntüleri belirtilen dosya yolu altında kaydedilir.
