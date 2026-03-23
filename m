Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35B2D7DDB
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264330; cv=none; b=Ciu0foH19pfVh1DAwREYeMUA98YSMnbCy5IOmBUrVwML3txvmTFRh1eURi9edSZnk8Bzz1yhd/Zp4AMJJtQUa7w9fnzZuXVvzNvbIldCi1Sji+wA2uHBrAgexQ9BAQARV/VbttbXjCcyy/pLmCOUFTGyufYJMfNzVcOR2mwL+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264330; c=relaxed/simple;
	bh=GgZbs/hJJ9+C0EI6g6bfoVfhcQXz8do37FgrICco6B0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7Qs0XjpU+qcrlEb/5F49srNfwHUgqC5z5IiSwesDOpRCz+EJxC+qN+1W/irPnf5BJIubQ+G89LwHKsv+tHbCTIprE3WCBQo6NqICgUrGHEbwc1S6YZbg3RkaaEnuQnSyiH6/qDwznSXTOxyhOWVMcsk2gCTyLojQfAoSvBaUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NctN2eog; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NctN2eog"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c742882d2a4so1119388a12.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774264328; x=1774869128; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ubmWKc0BiM6q6L0w/SF40L8FLc9qxmV9T43nLBakcJ4=;
        b=NctN2eog2kxrT/wzzuwZ9xxgETb+lJu8355S3Olzel79VxIg9654+WH8CgvxlzaiWt
         HpJDglWoMPIf2S6EdhNKCGfPD1/uI/pymmWcxGVxMfEZD3gRya6hEFNBow0jwSn5inJg
         2dTw2fh0+wYzKiU9VDVMf6qCYOteKHz3cnuwA6AjA6tNlXOxDcIc15jEM3S/1BxB9FTu
         /XC6nL5dWmZZwjEeMFrkNk6XJCDMZ0qSNHOYEStjjXwvvHWLT3w0s/tse5AkS9RKveSB
         K3a6CwbLMV8t0lYb2hLBHZiYZr7QZU7fTPfG+yXMqpJ0OozZiJ4BRU/ey6wv+jjt2hGu
         MzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774264328; x=1774869128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubmWKc0BiM6q6L0w/SF40L8FLc9qxmV9T43nLBakcJ4=;
        b=kpD9reOPq6+kicFKXGWBcEWm69FnO3qCJH1Uy/ZZj7kl7oSDt1mo0b9y5nL1wxzXWG
         HMpb5qDYJWKyDz0HfWoSvFLlaBOVbO/5ivn6qoxrXxr+wZIu1RSHmaV1eZ/o4MEbTKcP
         BuKwhiuiME43FybG09vxaqr3NHSHOak8UMOhTQPWbv+k2WylyXMGJgX28iEEpXtRb506
         pk2jBkHwViatZFMYR/YZSMi6SSuGirWXrC6aNCT3RNeLDJWIamfXmekLzEU/22qDzyad
         z/MWaGLYRNh41D31S/VYDmhgtXEeD1o1et0dXv+O6tEg5oYldUt+aPZSTUz6L0dYSVm9
         b7LA==
X-Gm-Message-State: AOJu0Yw5IMaMrEQPA0lfrHgqO0D3m0HnOzThIF9G73CuCfB9xs09JgMR
	1qy7Aoer4kyRsDOcvenG6IeALOj9YdpP9jdmYMCIsp3dGfxKPmGz521lhyCFsw==
X-Gm-Gg: ATEYQzxjUP/gh0g1Rw351WP+RH/qGTaO0cgJLeNsjfgGtV1Ti11roZyFDamDbl00yX4
	x7UJgLKHCfyLHET7qiwx2LpoU4+CCA/fR6++SoWoGJjjSuFY46RjDpN+NuJZWpjWFGRkxEdK+k9
	XOtLN7l6roifd1NUAAMzoUS6blf+TbiIyWmR0UI14uKNWNc/hlvGPPqhQB8Xf9O2DmihmQm+qRf
	NylGkzE5oD/XK+Mj81FgWJ1E4H9jn3ZaV/k7KlhRT8QzjZHt1gU0AsFl+gLyuIIAOna9cuic+7B
	tzL52td9ZWqilrqyiBHo3o+kjW8maNq246bF8N4FZ8dkvO7OuS8KraaeI77L4foWeNS+rHKhCG1
	sFcX59Csw8rHd7Yzp5SdsAQcWaPT0JymNxyDhfIw7GBt1spn9pPGfxfDkaELBzK1txUe2CWAor4
	6A+PqDmoPB1PbkL0mpWfxBR5YSjF4+q+5UW5bI72jlR4krtS4iAGyeHobyFpc8OBKfGVNgPkqNW
	ec=
X-Received: by 2002:a05:6a20:6a0c:b0:398:7853:70ea with SMTP id adf61e73a8af0-39bce9f1048mr10805228637.15.1774264328089;
        Mon, 23 Mar 2026 04:12:08 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74665ca206sm8559228a12.18.2026.03.23.04.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:12:07 -0700 (PDT)
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
Subject: [PATCH] sched_ext: Use READ_ONCE() for bypass_depth in scx_bypass()
Date: Mon, 23 Mar 2026 19:12:02 +0800
Message-ID: <20260323111202.3960280-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In scx_bypass(), pos->bypass_depth is read under scx_sched_lock to
update per-cpu BYPASSING flags:

  raw_spin_lock(&scx_sched_lock);
  scx_for_each_descendant_pre(pos, sch) {
      if (pos->bypass_depth)  /* bare read */

However, bypass_depth is written by inc_bypass_depth() and
dec_bypass_depth() under scx_bypass_lock (a different lock):

  lockdep_assert_held(&scx_bypass_lock);
  WRITE_ONCE(sch->bypass_depth, sch->bypass_depth + 1);

The read side here holds scx_sched_lock, not scx_bypass_lock, so the
two sides are protected by different locks, constituting a lockless
concurrent access. All other read sites consistently use READ_ONCE():

  L1237: if (unlikely(READ_ONCE(sch->bypass_depth)))
  L4083: while (likely(!READ_ONCE(sch->bypass_depth)))

Add the missing READ_ONCE() for consistency with the rest of the code
and to make the concurrency intent explicit to KCSAN.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 72a07eb050a3..2654690e3661 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5343,7 +5343,7 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		scx_for_each_descendant_pre(pos, sch) {
 			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
 
-			if (pos->bypass_depth)
+			if (READ_ONCE(pos->bypass_depth))
 				pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
 			else
 				pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
-- 
2.43.0

