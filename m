Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A233ACF0F
	for <sched-ext@lists.linux.dev>; Wed, 13 May 2026 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660271; cv=none; b=AQB2p7lB2KEm4Ye6VtxodYylgTF/qx6WzDK2pf/dRAworPXPEmHwHl4Now1Lmv39aO4aul4Lrq4ND2S7785TukVnN6Zv+B3cz8uqlUuAJD2fzfdp0cQx+Pg6c+4xTFUFaDu5q8SUtkdp5qbXiGQBwc3H/orwu2KRFQt6usA+h6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660271; c=relaxed/simple;
	bh=y2T9UJEFjIBNKYn8iu4aqEdVJPvBg7s5+bYvzq37mds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CiA50BhGgCWrUMv8xb4lrp5X/6NhcASL5kP1SVZASu00F9xpl887neZ6tw9zrzjqiOTjkHxuGJcSH3+RNLD1znOP4FPkiniEEsjPjwKF4Gd6Fzbrx2NAn9MBb07XP2FsNw96nSSNdr4moBOWONb39gm5pN2EWLbydcj/DyMzXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPuosTPi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPuosTPi"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-367d88b9940so3086656a91.1
        for <sched-ext@lists.linux.dev>; Wed, 13 May 2026 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778660269; x=1779265069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dUYoa9i6HSBwYXJ+q898Z0Ff2BZayXkDbVzfIzdYh70=;
        b=KPuosTPizq7oMzsK9Lcy5Hi06bRnNO2hhrLtGOxfjeEUvqfxfhCmZXHF8hcHGbBJwZ
         jO7+LCG6H9PQilmQ3uxM1SU2t4B48agWso6WG7vKmsaRDMN7/eNUAdL7mJfB0/H3Np3H
         W+0Y8Q5AY6oN3PFdklQPCLJC7CRGhxgMnikx1salEd+uJ8zHWL9VPtucPtg6cS5vcMxk
         uRTRljyNbvp043aJcyGFYKg9LZIqDdiwghBE+iOTcHNsR0BNrijRHpk28iRYq8s2pgIF
         Bc2UqCidVWBnE/EORWCbgeUIeBwRSPhebCHFTtDubYnEsgM5FptxdaKyPEYy5rIzRiAK
         ybSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778660269; x=1779265069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUYoa9i6HSBwYXJ+q898Z0Ff2BZayXkDbVzfIzdYh70=;
        b=apNzHrTAL3E6uEv9svbohphK9MU6Aiyq9VACQnUdLhwvz4T8UdQRW7/Q4RKUQ/CPz6
         AUsa0uwduqTDB5+I48qYPuFpr8XKuSbyT8NlieY9NOOm6HahtErO3b//3LSpbYJgj7RW
         PP+dWzOQjavnYKuA6E2+5D6g+VnMdSQBfTq95dydAukE7jlMDJadLFLJlAOuMK7MXF77
         misdAib7yHBpPnqHRKfycLosYrskf6jHfxDsPLMl5+TRzRTLKp5jwj/T1+cfxBGu6dZc
         NBhsSxJjAZKbfOL7PCOZbJ0wIXkGqh4sERJMUTCyAXwN9dprSpPmOv9SizAnp1escuPh
         5KIQ==
X-Gm-Message-State: AOJu0Yww14266VqdC7PF7BJlTQoNcErAzMpkd/9FbW+RLfoMHO+PmPPd
	WPRqZUfih+1pk+9aVbaOEZJCZX92u+L6YVUNCUrT6O9LzgTCOCvTtJuAK1FGjw==
X-Gm-Gg: Acq92OHxaxx5NKr8XrZDAWF5RLIexfKDVXg+cffbjDRIzm+tufmzIZrF40SfCu8hIrT
	YTwzJkcIsVJei9at2UEJHvyfHo6HXDEccdI6SOYCrzA4IqFh5EinxsZX+b/ZfW14Yq3QJwinIqr
	E+3dN6wFe82fCLY9FZXl2ApWKQeXVmu49NfCC7V+MbiqlFgyHgD2l/Tlw+e8YALGcT/gqHZTHEI
	xlkmp6RrF1Xm1BaQf4EKCRqs0RtOjYa4DN6JvbY/sTrlPcXAEhzWZoON5bhNebDZwXSKbg1fhll
	3KQAfXvwYOznz2lm1y/ADHWH1R2iAjYj9StSB9gnSjQd8VEXiObHzytVWIQLTnPLMIeschjeIi3
	8hqWuPfU3k77Y5/jKX7dBPb315hyO9wYm+JuS9y78L38e+E4Q2VERnWDKN96etHWzmQ3EQyS6yJ
	RknniztjVjlA9NM+PWUfcbgJ6sTFGyGseljESahcTzgOGUP6aaMw2hmAgfvbaaDoYBwG/UkkIYy
	EUez4BCg5/CB32odf3wZA==
X-Received: by 2002:a17:90b:5823:b0:367:bf59:6f9b with SMTP id 98e67ed59e1d1-368f3f82278mr2601072a91.19.1778660269172;
        Wed, 13 May 2026 01:17:49 -0700 (PDT)
Received: from cchengyang.tail151456.ts.net (36-225-72-95.dynamic-ip.hinet.net. [36.225.72.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b0716e90sm1865376a91.12.2026.05.13.01.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:17:48 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH sched_ext/for-7.1-fixes] tools/sched_ext: scx_qmap: Fix qa arena placement
Date: Wed, 13 May 2026 16:17:11 +0800
Message-ID: <20260513081731.15825-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__arena is a pointer qualifier meaning "this pointer points to arena
memory". When used on a global variable declaration, it expands to
nothing in scx's build because __BPF_FEATURE_ADDR_SPACE_CAST is never
defined, leaving qa as a plain global in BSS. bpftool then generates
skel->bss->qa instead of the expected skel->arena->qa, causing:

  scx_qmap.c: error: 'struct scx_qmap' has no member named 'arena'

__arena_global is the correct annotation for global variables that
reside in the arena. When __BPF_FEATURE_ADDR_SPACE_CAST is not defined
it expands to SEC(".addr_space.1"), placing qa in the arena ELF section.
When __BPF_FEATURE_ADDR_SPACE_CAST is defined it expands to
__attribute__((address_space(1))). In both cases bpftool generates the
typed skel->arena accessor.

Fixes: b986ae709b39 ("sched_ext: scx_qmap: move globals and cpu_ctx into a BPF arena map")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index bea43d235908..7e77f22674ea 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -89,7 +89,7 @@ struct {
 #endif
 } arena SEC(".maps");
 
-struct qmap_arena __arena qa;
+struct qmap_arena __arena_global qa;
 
 /*
  * Global idle-cid tracking, maintained via update_idle / cpu_offline and
-- 
2.43.0

