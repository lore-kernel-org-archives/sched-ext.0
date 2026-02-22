Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595981EB5F8
	for <sched-ext@lists.linux.dev>; Sun, 22 Feb 2026 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771765719; cv=none; b=XT2REQwpaSLqhLoqp7IsZEUJGxHDsKOXVOtZlBVOoaMQKBtSAAEwpHjLhrzEMvmJj2iudMxVAqwKhL2sanNNCOZYWoqwb8QA3d8zf9XwVEtWCn760iSQ04pj/pSM7sSDVnSqAG7fFK5Q5c3Ssdt3MgDfOo0WPcVhVbg1fQw19YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771765719; c=relaxed/simple;
	bh=iwrB6i6RBAYVbQRj2OPdqKhOMGQiGdVSwhpxsNaYo20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSTAZybewGlljtacsdZba0f0LBwxbPqmD37Ka/erhmG7caxtTpNj1XtncOhtdK0ZBCzt3Jpusqk9CE4CacOmws43SmQBW+ORv2YTvkoEgFerhSqqmlWCS+3ZgMng5yr80Y1b1WqZdN+133lZbr1kXMqzbQ/ocE5liT9aV+qEFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcSH9RfG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcSH9RfG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a871c8b171so21766495ad.3
        for <sched-ext@lists.linux.dev>; Sun, 22 Feb 2026 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771765717; x=1772370517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLEN2N9qA7ZIx84iVc+HLKN56en4/w0xxGdu35/fIM0=;
        b=BcSH9RfGS0BzGxdyrj4X4MwY7jeEtrA64IqeQGNnfKuokFYWPYVK/DK+tUAR+ExFQd
         wEOUqEOp5RcIgo8P6boBlYjyK57fXRHYPH+F32hCD2MdFdJBz4xxaU6P4sjie9acxoQk
         LUq0EjLdw1fb6FxtzWp9v6eKIh7U52RWOC7+s9/eZwawicnkzhgvpf60/6ki4bQOR2SZ
         jMdSWhZu4WPNYn+KKarxc35kXKbjuyfgRO/dBt9x6sf6Mj8Lw9GukTQhyZhIFPCEHtal
         5IvJD+Y+jK0tJw7mhjLTlQeXXNL7M/jpWg79RUg0PvZ0kto/TUbXRe7FAi6rVm6oLjo8
         zC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771765717; x=1772370517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DLEN2N9qA7ZIx84iVc+HLKN56en4/w0xxGdu35/fIM0=;
        b=mm3xu2hD7uiI9AdzJozXriydGgC+UZ6+E3Kx8Q/WvGRtUD1uYdUV998fZbyxc5kkVN
         FegtmTRsfcL7XavZAqaVDpVSIr1w86p62Rfy3GHGbBhx1X1rHiejBY0k2iBtyXLbn3gY
         9krUoRSqNzFagBASNcuHnPUhOz14YXM4fGNvp7nvNW+h4ZTuxAML6Mob8Fgo9JBdrDnV
         smB3ZItEpkMZLBUQbCRWplDehYovA9ueEobkqMHtWIvNIlpzzvyXCY4qBDmM0cAfxguM
         OG1YAA/PTIdp/DkdwKgDoKr9Llm8KgsLIx2UFcDmKGP/TYj+jqP0XqqSkKtbK9GVAgJ5
         UMnQ==
X-Gm-Message-State: AOJu0Yx3wqnOU16B2y+AeDMdgRFRZPM329CEwiRrh4Xyn4WJUriAi2ob
	fl5t/2ViikH40yi1PrR9U6jZikvgV2cPE1FT9tjF7RWgicsk6IlQDq7r23AqwQ==
X-Gm-Gg: AZuq6aJT4ht+DCXDLI2cSoDQfE9I7huIJIRBZYS8lt27SWcS4j0Odein9MSTgi4tB7u
	GHwuZIpacVHZh4L1HpwQCLz17M7CSLiHVB1ZBK79L032IeehWKqqvP6S4SahsieTEpR/fXAC106
	jBRrfTyyMii9oYWfNyr/YftJZKhN6HIpGhogYacBnirazmOh/Sb7sQyYNSWyn+UxiSLUJpNxoEz
	PWnIZh94xxMjQIxZemkhcXRaZU9qy1NHz0dOf/WnjnFZsCKYHe8dnkxZrGKWnhaqEQ/kn7x4SDP
	F0VOr2WdQ3X0wVRq7WsbCZBaC/tVEHTdLc5ySEf3w57mEypRSJwUmRxC9vVwAvKZkFi9u2atTJQ
	D4UM1fOc4yRiH3EV1RnkdDFkJr03AARXlaJ5aMv1JYu/GB6t2Hiz05QPu4tMbFhdIHBLJDT5Tml
	an2g0lZw6hpxyKRASqkRumITG6ScpxU610sM/wkzn3kEeBQiTKls9P0m71EU/LMiw=
X-Received: by 2002:a17:902:d50b:b0:2a9:622e:fd3e with SMTP id d9443c01a7336-2ad743e3b27mr49494565ad.4.1771765717584;
        Sun, 22 Feb 2026 05:08:37 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:f3c7:b896:5ac6:4be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75027b0asm48433865ad.67.2026.02.22.05.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 05:08:37 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 2/2] tools/sched_ext: scx_sdt: Remove unused '-f' option
Date: Sun, 22 Feb 2026 21:08:26 +0800
Message-ID: <20260222130826.37085-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260222130826.37085-1-yphbchou0911@gmail.com>
References: <20260222130826.37085-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The '-f' option is defined in getopt() but not handled in the switch
statement or documented in the help text. Providing '-f' currently
triggers the default error path.

Remove it to sync the optstring with the actual implementation.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_sdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_sdt.c b/tools/sched_ext/scx_sdt.c
index d8ca9aa316a5..a36405d8df30 100644
--- a/tools/sched_ext/scx_sdt.c
+++ b/tools/sched_ext/scx_sdt.c
@@ -54,7 +54,7 @@ int main(int argc, char **argv)
 	optind = 1;
 	skel = SCX_OPS_OPEN(sdt_ops, scx_sdt);
 
-	while ((opt = getopt(argc, argv, "fvh")) != -1) {
+	while ((opt = getopt(argc, argv, "vh")) != -1) {
 		switch (opt) {
 		case 'v':
 			verbose = true;
-- 
2.48.1

