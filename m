Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8F344021
	for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482199; cv=none; b=DI/y8IL/CGieuoBQkcers0BIg6XC4bI9FvtehbyHpvwdJlknrVBy+ULyVcewEfPc3Js7FxdiSJZn+9QWCNbqt0viRlNcxnH2efSBbpSBiRhBwGTfiZRNFIsnn53BhXmkp6We/HEWQt1I+S4exCGbya8N74Jid1CW1JfF2yC85Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482199; c=relaxed/simple;
	bh=JVSJA95XSNzWk7VNTlsiBX5wLy3Z/V8V18VoSC6FQnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwX1yVXIuX4pQ9AB+vzU+3fnHQjCuBle19Gq0XVdJaXLchoOjfaPdTafWpTBazI+qjagK+1vvenrdirjE7vx4jS+k3iJ2iaRpiqmGONEAiH45qIFZtazFSpxjB676GLk3xfGj2Vpgr15UNrwNvziyiQ6q35WLIJ3lLWn3byzMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddKtepYa; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddKtepYa"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c2af7d09533so357155a12.1
        for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774482197; x=1775086997; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0e5DC58r0Jexfc/OwoQOpmCJSQcCUiUEwsRF0lcEEb4=;
        b=ddKtepYaK/YX0dSdYHSe2KEYO8/8+hBjCUeP3ZuG/GHrAo41K3GVyuZv2ln5ufbQ9Z
         LzZpP2+823ByhbiF8IPaeaPcc2jdHG8t6syNaEs1cf/gljVlzWqa2+DbjxSfqbJbauuG
         A4YJGZjMyU3rDiTyhZajxCnpF09HcsPWMuqvgHbTseZVVmHFIhFjIPOv12WPGmhZQq+Q
         rF6R8ISlp0g67CXCsaRnAtexLzR3+p3liR6xlSnb0kOXgFtbOV6+1Sfb8R0r3MUyD0j4
         D+ehvFy89fuuzRFPZvkeuQtR3QMm6JOxjfBfypkBeyKHrivyarUweRx5U8hIQz/+rcRC
         Bx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774482197; x=1775086997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e5DC58r0Jexfc/OwoQOpmCJSQcCUiUEwsRF0lcEEb4=;
        b=N1i0tnlxZ3e68m1J7Iz1YxrrpCnYU5YQTjvxpkmTEpfeyVEAAjZ9F1v8BCS+D/0g1x
         4ygOgXj09dpZfPjKHkrmKfdODSo4Oa6zGgf09guiWVfAcvAQm40vwTagzpQbVsMb96ge
         J9b75fD9vkTJWTtC5T9YLmOuawO+kK6nxuhrm6kzXH3yGw6lSoBWqq7NtmzLjfsmUC3G
         W3c61dzV8ntaU/bH8J2hNPsbMbVKn3j7EFbaPpJPNKTkoWnhy5Kmp35BMWLF7Mvg/VsK
         ZCg0VFhZluSlwNaZMp4Avqa8xE9Cmtc6d4yCWYNx2bQ54u11+QzPIBaxRx+E99iMI0qh
         8q2g==
X-Gm-Message-State: AOJu0Yxoc1pZL6dkQtEtpkgOmCnHdx6PXcJKZtKKjNWBb8/PLIQh4FL9
	6R4clDW8FPhfB58g9VZTc2qV9hZCIemGzoYOPPk86QzO3tdo/EvMet7Tm9mxEA==
X-Gm-Gg: ATEYQzwWvq8nHKxN7RddVUO7ABgxQ1r63ytPpzSnNTsgPpNJIjCysUuUm/j6L8Fa09j
	vfcVOHCFVP9vfCQiK5oXziWrnjneml72NKE+hApGJxvyqJ3xYoNWCqiCu3Z79bmD1+eIePIN4qF
	zHn6Ico/QqdkeDd3hrnetLDef4il1vh4njxXKIxuMfSTrehMEWRzxHNowJ4C/iFN999zyv6XzqX
	wVyEZq9DBESDVo62Bcla1eaFywTYjI8cRdLns55L7MVd4tKdH/NQ0GGODLYbLHUcoJKasni79sd
	M4Ne06UxRQAYh0Gw9p2r2C0ndgCak+6QwMBr9dDoah8+cQkCUjXBHaem1KiY8b5Wl1FBgt4i1Fc
	nh7onFZ3QWoGwkNrzYOwYcXEImQNHNDqRH0Oukn/HyR1wpD9foz1acDLCleGiagydPG1ODuqKHU
	VSCBgPolbOGeZciWonxM3fJFu6bS0Q4rL+T6DP4w+w6rd7ERhio21UYP9+Ab7tg4+dKF+ptAGWD
	vw=
X-Received: by 2002:a05:6a20:244d:b0:398:b16f:7045 with SMTP id adf61e73a8af0-39c4aceecd7mr5671802637.29.1774482197404;
        Wed, 25 Mar 2026 16:43:17 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c767382bcecsm511785a12.13.2026.03.25.16.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:43:17 -0700 (PDT)
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
Subject: [PATCH] sched_ext: fix NULL deref in bpf_scx_unreg() due to ops->priv race
Date: Thu, 26 Mar 2026 07:43:11 +0800
Message-ID: <20260325234311.3614764-1-suzhidao@xiaomi.com>
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

