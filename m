Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972C378D94
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492116; cv=none; b=ImOmNPQVUr15KksJVc3n8cCGTRrRi/NlXmjvvx3/jWQ3RfOTwKdcqgfrcpTIB000pUu9b7WAsiz5H6C9hdab9i98yku5dgdd6Tl7TVibKNvp8SNIscV+jSCVGYlptMOu8ZGN6I4FOc4WB3U/+XgMUNahyi7y4NccDuX+TVMDzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492116; c=relaxed/simple;
	bh=JVSJA95XSNzWk7VNTlsiBX5wLy3Z/V8V18VoSC6FQnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0mxuaNMWH/unq7wybYNA204/moMkxK5FOIQ4p32ADjqp/avA4b0LcJzRM7AWWyi8eC1Ut58fD+NUX080dXUi3Mfc4/Km2kDda1f3pp5IZcSibnxGneFp7p9PkTlKQGtxRx+UQchg0McroeVF1d0yp96RPE2iG7j7M/3vprrxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pURAcWme; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pURAcWme"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0586d5bb8so3293365ad.3
        for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 19:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774492114; x=1775096914; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0e5DC58r0Jexfc/OwoQOpmCJSQcCUiUEwsRF0lcEEb4=;
        b=pURAcWmezMiz72Drg5D4P8KEqxqhdx4zspJoG+89bK4z7Qz7ciEhZyW5geN1jX8gCS
         3hClQHkjyd9hqhzXL+/er5NPW4CL6o+mFuo2qILG3Mq74sGWn9ZhXaQhxVLb6NrwEWur
         a6kngHa4fdRvCM/Lx41ZHauUwuJcrLjjfPGaeV3jStUVsliOK1/lgCvbGwVzWxXi8V23
         4M9W2M1KNgbgBJF8GcczFNOU5Olo6YKdc6WNQnt+6wW10Euesth9pi8MuK5fgYh36Kme
         veqXljVbMi84ezAjARYrexpurLnPerlbUXo9LEtZUHh0vqEa5B7kR2+LYDcZdVDyfnE+
         zl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492114; x=1775096914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e5DC58r0Jexfc/OwoQOpmCJSQcCUiUEwsRF0lcEEb4=;
        b=rYZl4EERzQY+kg+0A7W4ATCh2RByFSraGKUejlsTG9PDntpvc5cdTWmFQLNrSEuhMt
         JfRXvWqTuwTHk1z0HWVfTIsZqm6hs6iXyZlKlr3r0o2bzj2eA86DXLYgOhfHXvpRmL7m
         zEgK2vVN6/cTYbYM64vM3dYFiyZJLVdb177nBoMX443yCkQzAPj+q/NmwQjtKR/lQisG
         4flor80ong3ecmEXObp2Ck6D/EQD7d7xliKRZlP2ApPvQbxAlMBOse19wqoETh5MuPdO
         oLT8t+IEEjRDup802chwsVcOYmFbhzzURn6KWLrWSTbScq0UHDeThNHoquIyhI/p6UjZ
         Q2LA==
X-Gm-Message-State: AOJu0Yw1FIoFYZ5ruMFuq5SlNlEs0oLerfuc3sP1DBe1RMkPsIj6S+5F
	2tuBi/S2myosWFcG8V2Mg1XNXxi29tgZhuvLYWXwLgQeZIUd5PdM6v9H1MJQLw==
X-Gm-Gg: ATEYQzw7D6ySui+mUrqQ9+PciFPca8oQuovgjUqvAFtQIeBiw1EzlFWCh3DirOnkKTm
	TxgC/w3fJDdt5lUKB95dSWhfGSoP47I8BLVlwu8JmtOQ3BZ/8SIpjTrEScp+mJGoJyWh5wExBGu
	yu7JgXUML3FrT2ZZEes0Lv/fcRyQAMjEgNKJmae6LX+KfSFLQwK0RBh0fl4hPSZT+qwPSWUWwvm
	Bfq5fo39kODREUGr7jk6qney2WUezR67b1gEfBuh1yLOGJQxb+5AufNT3CBVfZ9Mfu/KZVJH1ff
	bbC/hWB86htizuca/Ule4SG+iUPNXE7lSreoCZk0+82aWRMGb2ASrFS20JJbbDxxsm7x0KgPkS7
	khd/6rZ3JRil1fMhHZYVsEPI/0ZgO26xxY/8PTHe5b3p8JK7jm+hfjTci3i4MJWDWw3UwKeka63
	RoKffJGM9nPG2BDaHF96XtZHEpfBlwMXZ523REp4Hg5yz3akTjFcz6TtoD5+VY7b3UQmRIIpdH6
	Bs=
X-Received: by 2002:a17:903:37c3:b0:2b0:4fd1:ed69 with SMTP id d9443c01a7336-2b0b0af4ca9mr64262265ad.24.1774492113740;
        Wed, 25 Mar 2026 19:28:33 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76f184sm12969355ad.9.2026.03.25.19.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:28:33 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 1/3] sched_ext: fix NULL deref in bpf_scx_unreg() due to ops->priv race
Date: Thu, 26 Mar 2026 10:28:25 +0800
Message-ID: <20260326022827.3826287-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reload_loop selftest triggers a KASAN null-ptr-deref at
scx_claim_exit+0x83 when two threads concurrently attach and
destroy BPF schedulers using the same ops map.

The race occurs between bpf_scx_unreg() and a concurrent reg():

1. Thread A's bpf_scx_unreg() calls scx_disable() then
   kthread_flush_work(), which blocks until disable completes
   and transitions state back to SCX_DISABLED.

2. With state SCX_DISABLED, a concurrent reg() allocates a
   new sch_B and sets ops->priv = sch_B under scx_enable_mutex.

3. Thread A's bpf_scx_unreg() then executes
   RCU_INIT_POINTER(ops->priv, NULL), overwriting sch_B.

4. When Thread B's link is destroyed, bpf_scx_unreg() reads
   ops->priv == NULL and passes it to scx_disable(), which
   calls scx_claim_exit(NULL), crashing at NULL+0x310.

Fix by adding a NULL guard for the case where ops->priv was
never set, and by acquiring scx_enable_mutex before clearing
ops->priv so that the check-and-clear is atomic with respect
to reg() which also sets ops->priv under scx_enable_mutex.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 551bfb99157d..01077cc2eb62 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7372,9 +7372,22 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 	struct sched_ext_ops *ops = kdata;
 	struct scx_sched *sch = rcu_dereference_protected(ops->priv, true);
 
+	if (!sch)
+		return;
+
 	scx_disable(sch, SCX_EXIT_UNREG);
 	kthread_flush_work(&sch->disable_work);
-	RCU_INIT_POINTER(ops->priv, NULL);
+
+	/*
+	 * A concurrent reg() may have already installed a new scheduler into
+	 * ops->priv by the time disable completes. Clear ops->priv only if it
+	 * still holds our sch.
+	 */
+	mutex_lock(&scx_enable_mutex);
+	if (rcu_access_pointer(ops->priv) == sch)
+		RCU_INIT_POINTER(ops->priv, NULL);
+	mutex_unlock(&scx_enable_mutex);
+
 	kobject_put(&sch->kobj);
 }
 
-- 
2.43.0

