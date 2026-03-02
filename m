Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDC331A65
	for <sched-ext@lists.linux.dev>; Mon,  2 Mar 2026 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442889; cv=none; b=n82YTL4uG20OU9LLZB8p5j8HhwmkLds0fBpOjZQefjZh4nnoiuR9xp8XrSAi+VS+Z35h8DTgD6Qz4HiVb1jGl7cQHPnBOTodGPTZVIGC+k2zJAhJJorW4i7GQSsfoKd2BZkp/A3Sx5LarmFgUIvzJc8FOzn9pmJ6pT7jBCMdBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442889; c=relaxed/simple;
	bh=jkHaHLPHXNUp5xINEGydB1QE2vGw3qTz1fuWgd/pyQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJf2OWqXU4O25/6paCnaZ9VfpQEtXBdndVMzov3xQ3h3IaRwreKadsCqPKdcUpw9En0RBAFJZ+YbbfMUuGyL2/1q5vrPy1NJWGqZ2JaiDx70A2iVqWH8RDN8/pH5TY6Ii38OtcLLXH5uoktnLbKw5oiIv5B38cxz8kAtGEuHBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxh6P+dq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxh6P+dq"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1444686a12.0
        for <sched-ext@lists.linux.dev>; Mon, 02 Mar 2026 01:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772442886; x=1773047686; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6eLhm2/d8jded2I+Y9ZlUdy+WuZDx9ghyfh4XuLKOk=;
        b=Hxh6P+dqkRDRbue9Bg0qdw4OxEetZEEXqEN8CSW1fui16Isv8npcz7+80gW0B8vqNT
         0l31i8gQdpcd7bs4Gm+WGFoRpkgra+DX8apnGJp2Ay7El+MBs9KZ3a7Msunw/dqxYS8g
         5B/0lsV4bVNye5rzyyjS/aG83RqCQIyyH9suVjVMYaCEaLmOH6u2s22yAe8C3VVYoN3a
         59sj8D6/3bTJ7lUBphH2B9eW1Su+qm7m2KyovfSukoQ9d+iewn/BJPhO1iKkpPGLKrED
         48yGTd3v3qTcShBX9Cthxt6AaA0EtYgND7WRw43vBNPPfLo06srXzMDZnxpx2gbjI12U
         SMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442886; x=1773047686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6eLhm2/d8jded2I+Y9ZlUdy+WuZDx9ghyfh4XuLKOk=;
        b=unRcKiehFyDZ8GDJ4Yu/4cs60xHmuMumedIP716fy0q8U2x3olvY/mEc86aFFESYk+
         KBxoGH7QvxJAwRdDwphC3aTf68goyveVyAUIXvKg1pF3rekjz/fPMDAW8zAkbPrQjaHC
         JWqiBKpY3ycCc+bB5j3FpeYQtGOkqxJr45oUynRa8XlySJHxUHSrZKwt/T50QvRluBIk
         i8mYRB6tgmbF4sIY9HKTFsysmZ40bP1Rmkqmf0///Lwc68EcKCShA174vCv4NqxvLq+h
         aGY7QyxLu9kFPoCcp+He/ZCUd9TLspQTazHkp1i/UU5LS3oNiPV3dAp12oTn6OQdqXXO
         rPdQ==
X-Gm-Message-State: AOJu0YzR4k6NHTFXJFR107zkbmY6NYvs1232JzJTMiMhoM1yQk9BkAoy
	I//Yq+d6C8DVcoBO9lIHQ9lsMGN3ZppGGfQQ4HN/oxgPsDM6ac34mhX4w2DISbfJ
X-Gm-Gg: ATEYQzyVguGDk1UNDfHgv8/ZEIdHCFRjdqfkAz2LtdOl9S0YTzhwDfIYX1glTI2ASo6
	d9s0UbI7IVPxT+4oWVXxeY1UCWjuoYicdeeYdNmnbl3k24epIoQBHNODRJRSfFdJZfm3+EVBhg5
	Tqc6aI9hxM4/m4HjuM0RnzDK2S6DQiC3EaJjPOyyofwa6VZyXB42CMjT3Q7+QYfC0oeuZVz4wCU
	7jJ1MgXVSBogpUzqczU6qdn3Go12d4CkQt0QWwPJfxzco/psvwSEUkaxhmOYFvcK42OndTDMNl3
	xZyvHXj8yU0/M9tjWp47zcphp5otUS2GmuxH/zW6Jzd83yQ3OcuAhr59G2Bd7nymzQ+v6gacrT/
	HPrzkTusCtE9Kds0ohQsg65SeEu9Oqis1Y8HxBJ1u6NajN2bQ98CgZ4s9ZgQxPvMOeNcuU2f4iM
	zA9mJZ0BXRXteQSbgsvssYcOlfLfM+BpLEXwi+FLfA6o3QLJDJqw0Jt5SRe3m2iLxk8WabTikeN
	7Jv
X-Received: by 2002:a17:902:e806:b0:2ae:5a70:476b with SMTP id d9443c01a7336-2ae5a704bf1mr4858395ad.15.1772442886053;
        Mon, 02 Mar 2026 01:14:46 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae496470d3sm39729525ad.15.2026.03.02.01.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:14:45 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 1/2] sched_ext: Use READ_ONCE() for the read side of dsq->nr update
Date: Mon,  2 Mar 2026 17:14:39 +0800
Message-ID: <20260302091440.3973220-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhidao su <suzhidao@xiaomi.com>

scx_bpf_dsq_nr_queued() reads dsq->nr via READ_ONCE() without holding
any lock, making dsq->nr a lock-free concurrently accessed variable.
However, dsq_mod_nr(), the sole writer of dsq->nr, only uses
WRITE_ONCE() on the write side without the matching READ_ONCE() on the
read side:

    WRITE_ONCE(dsq->nr, dsq->nr + delta);
                        ^^^^^^^
                        plain read -- KCSAN data race

The KCSAN documentation requires that if one accessor uses READ_ONCE()
or WRITE_ONCE() on a variable to annotate lock-free access, all other
accesses must also use the appropriate accessor. A plain read on the
right-hand side of WRITE_ONCE() leaves the pair incomplete and will
trigger KCSAN warnings.

Fix by using READ_ONCE() for the read side of the update:

    WRITE_ONCE(dsq->nr, READ_ONCE(dsq->nr) + delta);

This is consistent with scx_bpf_dsq_nr_queued() and makes the
concurrent access annotation complete and KCSAN-clean.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 136b01950a62..718401f4ff2a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -972,8 +972,12 @@ static bool scx_dsq_priq_less(struct rb_node *node_a,
 
 static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 {
-	/* scx_bpf_dsq_nr_queued() reads ->nr without locking, use WRITE_ONCE() */
-	WRITE_ONCE(dsq->nr, dsq->nr + delta);
+	/*
+	 * scx_bpf_dsq_nr_queued() reads ->nr without locking. Use READ_ONCE()
+	 * on the read side and WRITE_ONCE() on the write side to properly
+	 * annotate the concurrent lockless access and avoid KCSAN warnings.
+	 */
+	WRITE_ONCE(dsq->nr, READ_ONCE(dsq->nr) + delta);
 }
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
-- 
2.43.0

