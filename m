Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40BF3E7BCE
	for <sched-ext@lists.linux.dev>; Thu, 25 Jun 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400430; cv=none; b=l4aQa6znWY7Yo5LhzRdkRkWUPsFLuAZ+o32oMcFiNVNUUQMfKo6ODFJUvdRbS/A14/Kcr7+l1SeD//Vd2hfQrx5ul0qTbtj0wfkoR6+XtR9sfm6Ncuvsu9THqrq5WaQObz+hTg4m+W5rsSmnm21qIhEKSuKxCjCxQ2P7B8mpMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400430; c=relaxed/simple;
	bh=BW/Z9r5QXuyUTqKbMNbf4FGkCTeNI2BDVgYHa/ym0pI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qe8Ub1OOrxoPE4vgEYAZcdW5ISnvn7xc/3gYd+c/wEJjfCtcwsYb8VHI7i6lh1XP/Z7ikGv0g01/5BOJD8mOZIts8tfNzPfoiK5L6zBpSsiJMYtoYynfCuKCGgQFydRq4wRNRCaOpfDZ/RmctWweG2sxCYBjiNGteccjICO5lSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPrwmW2r; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPrwmW2r"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37d7c265ca5so1925995a91.2
        for <sched-ext@lists.linux.dev>; Thu, 25 Jun 2026 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782400429; x=1783005229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw0S472VbIa2Epj4+rpDhhQtLilen1Fr3p2NhJkYZgk=;
        b=GPrwmW2rF7/ueEQZCLdFvFZtppGzh9Otjns3JPw7VdgjCZdJNHlxNRoJWKVokvLQpa
         +FD4JmUVNfsX3tmCXH7nd/ktS1FxzD6UrMOAaacmk45joiQkoZR4iCohMFuc1+9chRFn
         Cr/Xj5BnLNaIHgkkVrW5rWwlp6VrKWAXYQg+dl5QPVhQ/vRSOYrP/L0Q2n7z2cExalsf
         sKF62MnNgt0Tqf5JV6SqG1mjW8iimvJ1UItrtoisLAR0MgrTWHJqzT4xC8M5Bs9FhWjH
         /idJBBnbIl5L1Uectb7YjjsFd8TodfRifoljs7PNqJHQsmO0zBOLT2jukuPaxoSFghrT
         QFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782400429; x=1783005229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw0S472VbIa2Epj4+rpDhhQtLilen1Fr3p2NhJkYZgk=;
        b=lJRONsZYK2DSDQM5Lj0uWaQtQ8FVffICxbBANMmljzvohr7nHhzJjHtEljZSlzC9GO
         H3N/wyC+X5ZSuzPWf2UVhwZwvxa9WxtWeh+I/LmrPoLVSx/D0sS1Q2EO80dNB8zlawca
         xq+j4hv2Lp/fjsYLcVpREb/boldCJkG8kSFjvopW2HyG3YE6LUwesKMw1PCUP1o0F6yQ
         B24D6ss4x66NtDQHOmFO79LsBCtt/dx3YkPTQRBtoCRf/su9ApTS4iVhw0HvlPmwZtVW
         AI7ooV7RLAkctkQHUJRjH201Kem4BDGHDeZ6itC7U+ULvLEbgulQibi+ipxNkprfpHMT
         UWbg==
X-Gm-Message-State: AOJu0Yy+LyZeJtfP6aHk2UFcNQhnJmnZQCjuPzwvPOL/wHED1+JveyFB
	6vQ76uSQO/VRZKeYZyMEGrTpZoxZzVoy+UIk0Bew35SuDgn48X01UJM9JWjF1Q==
X-Gm-Gg: AfdE7cmV9z8zpXvrUC9ITZOsThqlS9Rt4oPc/SSCKctwcWmXM8SvCkNWBQiv1JueHJk
	oU2IOtD/C0CVFFSMu8ehSVmxqNdrNrh4RPgzcOYHht8/aqI73fPu0BjIzeuXkdjmQLc/JHo0P4x
	BOeMluj1b9Xrvdx3xy2ozYWur2guE39E+Kh27MNpwjmJtBQDO0cg96bqdusfad+20fBXd4pr+KF
	KN1Et+6ZvuN0ssdIrucNp8xNbF+wYGs57WxxqG8QZYNi2X/HXYk5RCE2b9zgCvyJbtYINzsjHxR
	PXULLefaIXIMmKH/nMKUoMO18kWFDYsU7x5afbSqYt15nNI5LjsLLifvSFTeaUuhqMhlsO8jEm4
	U+yWwxckOWfqQYd08/XJaho2G+z0aLTrgTj8wzZ1B8OOz/ovdCML0kGOpk7eL5tOewKHdhOdDD7
	U1YMl+3UO4KnjVfrrE6riWuo0TUGyG9IqrG3DIOjzN97T+r6ldv+5VZWCby3ypeeGDKUDuuw==
X-Received: by 2002:a17:90b:3f84:b0:36b:293:68d1 with SMTP id 98e67ed59e1d1-37dfa26c46cmr2968473a91.16.1782400428903;
        Thu, 25 Jun 2026 08:13:48 -0700 (PDT)
Received: from cchengyang.tail151456.ts.net (36-229-33-6.dynamic-ip.hinet.net. [36.229.33.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3b0ee6esm2213244a91.6.2026.06.25.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 08:13:48 -0700 (PDT)
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
Subject: [PATCH sched_ext/for-7.2-fixes] sched_ext: Convert scx_arena_grow() to use scx_arena_to_kaddr()
Date: Thu, 25 Jun 2026 23:13:11 +0800
Message-ID: <20260625151324.27505-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_arena_grow() was left open-coded when 2e05f2fd0dd7 ("sched_ext: Add
scx_arena_to_kaddr() / scx_kaddr_to_arena()") introduced the helper.
Replace the manual bpf_arena_map_kern_vm_start() fetch and #ifdef guard
with scx_arena_to_kaddr(sch, p).

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext/arena.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext/arena.c b/kernel/sched/ext/arena.c
index 5783694ec21d..b0e6a0be4913 100644
--- a/kernel/sched/ext/arena.c
+++ b/kernel/sched/ext/arena.c
@@ -70,8 +70,6 @@ void scx_arena_pool_destroy(struct scx_sched *sch)
  */
 static int scx_arena_grow(struct scx_sched *sch, u32 page_cnt)
 {
-	u64 kern_vm_start;
-	u32 uaddr32;
 	void *p;
 	int ret;
 
@@ -83,15 +81,8 @@ static int scx_arena_grow(struct scx_sched *sch, u32 page_cnt)
 	if (!p)
 		return -ENOMEM;
 
-	uaddr32 = (u32)(unsigned long)p;
-	/* arena.o, which defines these, is built only on MMU && 64BIT */
-#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
-	kern_vm_start = bpf_arena_map_kern_vm_start(sch->arena_map);
-#else
-	kern_vm_start = 0;
-#endif
-
-	ret = gen_pool_add(sch->arena_pool, kern_vm_start + uaddr32,
+	ret = gen_pool_add(sch->arena_pool,
+			   (unsigned long)scx_arena_to_kaddr(sch, p),
 			   page_cnt * PAGE_SIZE, NUMA_NO_NODE);
 	if (ret) {
 		bpf_arena_free_pages_non_sleepable(sch->arena_map, p, page_cnt);
-- 
2.43.0

