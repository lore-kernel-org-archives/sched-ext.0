Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F43C8731
	for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469523; cv=none; b=saWmSE06ICZx+ByGP3Opsqeim8GHHZsozytvPaYO4zSbcD39QRsaYOCipteavauVAN2ZpTa3oLOOECAWws4XC+3f4EAkVLv4iuAH2pBLwp4vFmE8waIhvNlHYuou/SUfVDrwbyj7W59iZ2ebgM018Jzw+GNlLfC9+LkSajewoZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469523; c=relaxed/simple;
	bh=Xc5XsEe+HqabDAHEherMMQgWjJe8cvvVdv0TNGM/raI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZCp8q9Ad1OvqmlW9LDw461pfKrfkHqAkLL762QV9gYOkj7SmO8uIm953bxxTXU4+97rERMDaHpl4idOcxi1LSWpXxdj96D4MTlplVk9UNmXsqvoKuEt0OOBf7SoTVEWQssctAgtdywf3czj1YjMVsoskzauf0qXyaaoNVg5L9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQibnCCs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQibnCCs"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b23fcf90b2so120172025ad.3
        for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777469521; x=1778074321; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dktCnbA0y4BBAre0ZWy1IJR8TT3ClcRSkT3qvVMefa8=;
        b=jQibnCCsEk6pGuxJj9naMtrfUXW+laEGliwd62Ajem/BFwtG+gkQD/Jm3JISGifvgS
         y9LoS7/B/JQcyojkWwkcmiSADk29pVtipBK8+xEwHq12nuYcJzOfsnTjP6pcCpT8FbNv
         HGHsyTtlhmNLw1PRjoch/rQrDe6DR+b5BM84YiTIfJjNJaXbPj+a5IeIUzNw0hgneQLp
         GY/F38Lthpx05QVG/VR5VJD4jkLhUav+4rJp5TdoFO+kRyDd1RUBqjV4cErbwzIHPnm/
         vJw7FsNKUBMPULl35cYDQs4Tix9BHShwYc6FSYprxBCugojEWA/EGOGlhCAk1DgmFe0P
         fQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469521; x=1778074321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dktCnbA0y4BBAre0ZWy1IJR8TT3ClcRSkT3qvVMefa8=;
        b=HyrxmbtXHHc2Fa2PtyTkFizeC20W1RuuOmLqCbTbWt6hVwUJl5eF2ruf9AFyjn4Iwd
         VykyPDwn41PnsudqALHsWL1aEGr3asQEWm/9YsLhcxaUGWgEySwmcgOQ7bN+m4CfH0AQ
         Tl+bPcDsxoG3kKX7369x78Meurcrto5AeCNL23Y5GSzvXFDELx8cf8elklCFbnzix9jL
         FGuv2ciMxek1db2RX+IhcEcUN1E5RaUB1ujBTt9EWwqu0paBEejWiIGw6WUkpIeU+qAD
         +wtmJ945fyg9VroauRSnCx+9V57MNcqjiVDNNVhevHEm7X7BuzoC+H1BZcVAFxSBwoth
         pKog==
X-Forwarded-Encrypted: i=1; AFNElJ9J02YYg5812Jhw1zJjlVKqxWm/3zvaMmuacx/zQkQb4P6e4XSu0DVHttrd52rz7ElX0qc6K6EUzrQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxiuni80C9kujVC+R1CiEIjcFmYUtDBggkxX9sCF3rhgcjm4uAZ
	cdPR37QkhIrsX3Bs4MCblSAQ57fXZV28COjmsjqJpp4I2sqMkANqO8c2
X-Gm-Gg: AeBDietil8MK7btIiIxR25KldGYOaXq4zv68dgMOlWOAIHwOQVu94yYkh7hvMEcR2M6
	Rw7MeRM556auve7yM4o07/raFDuAer0bPT4WVqDjih24BgHFw6EUomhRmkQGkW61tds0gdkR+o5
	zDgW0p9XwcWeVDpdPGNzcYS7kcHUfKMalysZVk7e47j6ZBrFmWKJpDQOl4FKzhwfUBaHDnj0DFL
	RlMs3nRd7KXfefSGkEHttrFwdnrzH1KYWGf9GMX/E3tZQEdScK01KJGox04a++q1YGlzg2pnUy1
	l1iZtBKihrhAfdQWtuaEaaHZQXQUXfB1rxGuSwclKtB8kx31kEVK/teZbNIVvq8yenOyh/bf+3B
	Xp6RqmqOskVfBwInQKVipnfeFTNmsGC1Hw1L5y78WVZjemiKDh9I5GEI9uAnf703I7MzBrnAigt
	w4LhA/O+kyojwMneaMAbfVicgep7e7HquCIPmucmoEeCbBFz88cBBwyzKC5hMHq5u7gyQN7/TEb
	+hQjvSMjVuw6Q==
X-Received: by 2002:a17:902:c406:b0:2b0:66f7:f7cb with SMTP id d9443c01a7336-2b97c3d455amr74069305ad.7.1777469520962;
        Wed, 29 Apr 2026 06:32:00 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98895dbcesm24166985ad.63.2026.04.29.06.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:32:00 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched_ext: Fix sched_ext_dead() race with scx_root_enable_workfn()
Date: Wed, 29 Apr 2026 21:31:55 +0800
Message-ID: <20260429133155.3825247-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In CONFIG_EXT_SUB_SCHED, scx_task_sched(p) returns p->scx.sched instead
of scx_root.  scx_root_enable_workfn() initializes tasks in two steps:

  scx_init_task(sch, p, false)   /* state=INIT, p->scx.sched still NULL */
  scx_set_task_sched(p, sch)     /* p->scx.sched = sch                  */

Between these two steps, a concurrent sched_ext_dead() can call
scx_task_sched(p), get NULL, and pass it to scx_disable_and_exit_task()
which crashes in SCX_HAS_OP(NULL, ...).

In sched_ext_dead(), skip scx_disable_and_exit_task() when state=INIT and
p->scx.sched is still NULL, and reset state to NONE.  In
scx_root_enable_workfn(), after scx_init_task() returns, skip
scx_set_task_sched() if sched_ext_dead() has already removed @p from
scx_tasks.

Fixes: 073d4f0667b0 ("sched_ext: Refactor task init/exit helpers")
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f7b1b16e81a5..1872af65b103 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3887,9 +3887,21 @@ void sched_ext_dead(struct task_struct *p)
 		struct rq_flags rf;
 		struct rq *rq;
 
-		rq = task_rq_lock(p, &rf);
-		scx_disable_and_exit_task(scx_task_sched(p), p);
-		task_rq_unlock(rq, p, &rf);
+		/*
+		 * scx_root_enable_workfn() may be concurrently initializing @p.
+		 * scx_init_task() sets state=INIT before scx_set_task_sched()
+		 * sets p->scx.sched.  If we race that window, p->scx.sched is
+		 * still NULL; skip scx_disable_and_exit_task() and reset state
+		 * to NONE so @p leaves SCX cleanly.
+		 */
+		if (scx_get_task_state(p) == SCX_TASK_INIT &&
+		    !rcu_access_pointer(p->scx.sched)) {
+			scx_set_task_state(p, SCX_TASK_NONE);
+		} else {
+			rq = task_rq_lock(p, &rf);
+			scx_disable_and_exit_task(scx_task_sched(p), p);
+			task_rq_unlock(rq, p, &rf);
+		}
 	}
 }
 
@@ -6937,6 +6949,17 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			goto err_disable_unlock_all;
 		}
 
+		/*
+		 * sched_ext_dead() may have already cleaned up @p while locks
+		 * were dropped in scx_task_iter_unlock(); skip it.
+		 */
+		scoped_guard(raw_spinlock_irq, &scx_tasks_lock) {
+			if (list_empty(&p->scx.tasks_node)) {
+				put_task_struct(p);
+				continue;
+			}
+		}
+
 		scx_set_task_sched(p, sch);
 		scx_set_task_state(p, SCX_TASK_READY);
 
-- 
2.43.0

