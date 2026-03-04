Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1E3DFC60
	for <sched-ext@lists.linux.dev>; Wed,  4 Mar 2026 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654292; cv=none; b=cpVh6Nx+7Ft2QVJB2qG8IuhXN0YV+rVGwzMHeqh4qGVqzrmBDm01Ha6/zfdbWXYD/pDTHDixwTZEtPtdw50HGuR8L2Pxl5zhNj4G6QaiSP4Z4DqlKs72WvQOjIMqIaCMx8ttMRBtzJudj9QZM3Gj3UMxMdRpkndyxwIzc0oFfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654292; c=relaxed/simple;
	bh=aaJkB3kUdkyVZpecA5G4vs/6ecYza03hzWlk3hi478M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9singMiwJQGX+KIyPSlN7c77L7ABUt5KcISSkweFo137IryaAbfxiW7iwU1RPdP9BhfP1i2DxPfuHY7HHZVGdXgrMAcyGd1LmLBBVbHjiqUggKaHtMIdZsYtyXDfAq5iQGL/rLDxEcSz0wvzp3rYH7q0kj9rYLmDZXXemQw7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M59mww6l; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M59mww6l"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82746ed8cdcso4696006b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 04 Mar 2026 11:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772654291; x=1773259091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLR0uc6q6cWVW4IWrcBtZzCYIrN0sWZeODfSdWirgqo=;
        b=M59mww6lLoV7bO2Q+tItNyVz/ATFQ/fq41gjARGhf/0OzPmLpGAoZK+dBi+HO4zwwT
         ExeK1Warlau6AxgdYa3NlB65q0NgBItWILVfEKml3J7WM10fdhn6rmgJElGUbXhfTGQZ
         vmuM5WORP077ZlDp5WtKhIuTXbfCPG++nRu0Gw0qS7Iy6Y6XdPnlt37kOeLA3YVRw56G
         Xgi72fCvbkCXA5veICkniTUKE3Rsj8QE5ToYB273x7mVXDHNPZkFC9FsO8JfT8ooUTAn
         d8pOQxCaOnG/qOpf4PMqRkSJu15uU1Sr1+INOnO6PA34XDI1UFyk44AqBWV2xe/007do
         ppiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772654291; x=1773259091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLR0uc6q6cWVW4IWrcBtZzCYIrN0sWZeODfSdWirgqo=;
        b=HNnRMULYrZOxIpu+r/xIFaucbWBaPlScJ1f1tA5cAszYLRPAsoJHrR8rHOpmuGLR7h
         eVF9NrG/1wEjxvXHCjeqz8KnGQMUg6jDCne/okFxnY6Asx59pPg8XT212oGJxJftDZZ5
         aS+dD+GQBYgN2cPYyEPiNrhXxAQdOMnnY3FF+SF2DBE2pYylX2qXyNJQs9iHKy4SQQ3l
         ffql7SIZ46giWKbXb00GbC8mAX6/7kruMbS9k02joHQrVc3LK7f0J9PdqSQSyW/wijwW
         BL8rHy0+JP0eS7dEbFhlOmzLtKQacGMKz2p5sW0f2qKp1zgoy2dk3cR+PeNRoUz0wzjM
         G2fA==
X-Gm-Message-State: AOJu0YxF9Orm7HvCIWhIGuB4/I+0vwKphG4xo4kOSpCqtOBog7GsYOc8
	pjEwiHI5nARGMhnxvVOh4r0JHVBYs29pqA2NrXpR3SiowldcLMTzOWVdSyXggjZW
X-Gm-Gg: ATEYQzwcCdsZHZPne8Pl1BT67EhE7EjJS16maduFSjzgWStTqSVkwGF7waQEwKM1A35
	hTOaIdZo+nVFPLAoHycQsL4Rnrx88TO1jWXiU3w/1ekVZdFCtpkoPZLWAFUprq2SNg8/cx8YH0F
	SXxw9IVu4y2z7NULzRGersi4gYAMjgLrc4Wyz7EjwWHNSQo43EUakhcjxOPt1Xx/VlOooxGuaIX
	C+DWDyS2RM1pUhn1VWVCHOdtExZ4xVYAkj7plcWguv22+jj7fD1n37+xmsxMu6tQ2YXe3G1H8HL
	1Nhaji0NmZyLO/DHOWRVrnohDR24BiCB0PU+xKAlBaMGEbOMGgnKGNNt6ARoAZ9IvHF4SDOk776
	4UfTSZUaomyRaYejkKttlXyWHC0WEeNgmhty6l1uSNaF5ByGnZqMyIDY7AlCGbOCq2L6Uhzw6rB
	TbHhTVTSjZLScVQx0Z0RQpJtd4wgMNgm1CR48TPrbAu4TAcLnrxq7y
X-Received: by 2002:a05:6a00:894:b0:823:786:1990 with SMTP id d2e1a72fcca58-82972b49a6fmr2611568b3a.21.1772654291102;
        Wed, 04 Mar 2026 11:58:11 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:61f1:eed6:e317:b900])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d5689csm24269462b3a.13.2026.03.04.11.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:58:10 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext/selftests: Fix format specifier and buffer length in file_write_long()
Date: Thu,  5 Mar 2026 03:57:57 +0800
Message-ID: <20260304195757.688275-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %ld (not %lu) for signed long, and pass the actual string length
returned by sprintf() to write_text() instead of sizeof(buf).

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/util.c b/tools/testing/selftests/sched_ext/util.c
index e47769c91918..2111329ed289 100644
--- a/tools/testing/selftests/sched_ext/util.c
+++ b/tools/testing/selftests/sched_ext/util.c
@@ -60,11 +60,11 @@ int file_write_long(const char *path, long val)
 	char buf[64];
 	int ret;
 
-	ret = sprintf(buf, "%lu", val);
+	ret = sprintf(buf, "%ld", val);
 	if (ret < 0)
 		return ret;
 
-	if (write_text(path, buf, sizeof(buf)) <= 0)
+	if (write_text(path, buf, ret) <= 0)
 		return -1;
 
 	return 0;
-- 
2.48.1

