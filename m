Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53F534455
	for <sched-ext@lists.linux.dev>; Tue,  8 Sep 2026 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875270; cv=none; b=UKyi1j9fdmfA2RuD3ecbcSMoCkfWuvoqAoB4S8kv6/u+AiQIhE/bDzNuV7ka4qwD/gEX/cfqaTdDjzUnKFfeRsQBSt7xIlv4pheQNADbIdaAxLbEZ1YZ328vHkzdcYZBMigvEaMUb+H1Qijx7v0zaHjCtYGwQgzS9RctBCKpscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875270; c=relaxed/simple;
	bh=CCFtida8nca/w/groI0yW973itC7Gs1IjWuLA95PeX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIuvUhakTnB+N6ob0lxhjLwYzvnwtHq5MEJ4BM3pNU857q1IBWuSYuhOWrsZRUBxHR0bsCXwadZtrca2Ld3e8Jqg5zg6Ur/fjt5oFt9t217i+SsEqxpg0O7NZrCOTv594+aFtRUbmIlW7kA+PiiVi/KTbpUL86hd9xr0wWnv/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbupQnDh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbupQnDh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381b831d535so7330409a91.0
        for <sched-ext@lists.linux.dev>; Tue, 08 Sep 2026 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875257; x=1789480057; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLD/K1lvDEeaDw2NO1f8UH7a8vvp5ePsXYtoYlGWm7c=;
        b=LbupQnDh1CpOhaYrSYBV6lGHu1KWaMXKwrIISV3ikPz6dXfRFGSGJ59ozo2J7HeEEf
         mOS2j654Qiojy4VVeUlGBZ+jiXORaS+HPgkV8G7nxv4gBPkKMc5iNzpQZnrUFZ/W08ze
         Kft74ojjYUL0+CrAfvA8wjGwKHKO8uX2+6XYqs3/ML92Gq8og59YEabIsLSb2h+VFdWX
         hlyoS0gDzHGtlwXOnoCoB1xJLuC8ImhOIkW6DU80NyDnknshMyjHd/yfZGQiDC8s/PIp
         8TYyebN3u/AgpK5B1hhJadZT+Nt9CMsf623P53SeURaFIOdaC7pT44l1B3UaNZTzCwb8
         5Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875257; x=1789480057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLD/K1lvDEeaDw2NO1f8UH7a8vvp5ePsXYtoYlGWm7c=;
        b=Xv36qvcBhLwCsSpqAy2wPF4+DoMrvoG0duDPDTbJo/RjNJEnWlYOXhwqTcbT7D7adZ
         Di/vk4vGy2p1+5V+2XGhHz793OpML4jPF/IAh1zn8Fvk16fVMDZYxkfDRdSw1zB61jpr
         eZicUs5cc+SbTttJpKlpW27xUVBLdmebe56jXs72fmEgRsOl7rBofu6jzXrTthk/L2II
         ykbFM8746YCRWNxCpSnejK9kK5qWC6BsfxIQCq2kb9KJL5k3/kmVtoWGP0vhfpzA1qVn
         0Qsz/Oh26CQWLyZYLmZqgrgNBN1OFpop2LvkpGV7u3j9ZrbV6fmfpUAwq8ba//yQNiYf
         Aatw==
X-Gm-Message-State: AFuF++nkgXi06xhEM62Jz+CoETOQ2Mo0Lj5tyNUtIaDIE4TfSx+3sKfk
	ZJAh3+ljfHk0USOZBqVnYNqUmPHDut0Q5WQ152x4SC9nqtaBbxiCJyZNANa/Fg==
X-Gm-Gg: AYBFou0E6sUtWCwp1CCZVBiSNojbNGFZyaT6pcJQNFdJEbVc1UQsiHKoztL58viwBks
	ElKozisYxacvKsAiW9EVB/9iLuP1VT2EsQEonO/TN9gBqTJcGdPMFQrMc8G07kzM7HWA7TsgNiV
	GLSK+Isicx+Hb7Ol63+KLolUCSw40oicZdxGA3wCVlYOHJnK9su6vyV6RVxpafp/jQlJtGdrozb
	6TtuCmHVcIoVu22hy+6wBvjfvT8PRRtmO8ZxSdiER5Z7c+SW41sA/uFPW5UM+Lr0kV/PJusNlxl
	EfSo2dLxT8aL2gcA3H2e4pY5m0/NgpLs2UT+A6xaNZxCFKMBxxywIDHBdf1AtM0EbMdjGk6TXtq
	6LFaD67ESrWPpHqQsL4O9FzWLZriUHvH7Hfb48CO9vA0PaC0UyDayB8rU2lNSvm+u/Pztoow1JL
	Isc1HQ3acWANWdLenK4xmKmr6np2byMkNnb8Wl2fBR9fhq1GufKT6+6afLIORhAA6MwA/w7qaOB
	SRAIqVLbUrq7OPRrMIYhWIPfzjgYtNs5L43aRWzJo/7lhsiSrv+tR6o+Hp10eefahwmFJ4=
X-Received: by 2002:a17:90a:dfcd:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-39b84cce5a8mr12671063a91.14.1788875256761;
        Tue, 08 Sep 2026 06:47:36 -0700 (PDT)
Received: from cchengyang.duckdns.org (1-164-68-170.dynamic-ip.hinet.net. [1.164.68.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae610e5b2sm9994013a91.0.2026.09.08.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:47:36 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH sched_ext/for-7.4 0/2] sched_ext: Clean up -rdynamic and LDFLAGS in Makefiles
Date: Tue,  8 Sep 2026 21:47:07 +0800
Message-ID: <20260908134722.8671-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the demo schedulers and selftests with CC=clang-N fails under
-Werror because CFLAGS passes the link-time flag -rdynamic to compile
steps ($(CC) -c):

    $ make CC=clang-21
    clang-21: error: argument unused during compilation: '-rdynamic'
                     [-Werror,-Wunused-command-line-argument]

Patch 1: Drop the inert -rdynamic from tools/sched_ext. Binaries remain
byte-identical before and after.

Patch 2: Move -rdynamic to LDFLAGS and append with '+=' in selftests.

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  tools/sched_ext: Drop the no-op -rdynamic from CFLAGS
  selftests/sched_ext: Move -rdynamic to LDFLAGS and append to it

 tools/sched_ext/Makefile                   | 2 +-
 tools/testing/selftests/sched_ext/Makefile | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.0

