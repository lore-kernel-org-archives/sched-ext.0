Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345B43CE69
	for <sched-ext@lists.linux.dev>; Tue, 11 Aug 2026 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457645; cv=none; b=FJDepYDxKBxPewMT6tfdm2yvautF/2I7jUPgBdLKURvlWVFz1GJ3SMdxvsy3J/kYypI2uNHvVAvrlIkXEo47Z7U20PirfApYafWzY0rHrrj7Rbk8rYeR57pEG2JcC2iYJtuU8JDWK3sJLXlh832UXie1x1diGKQCvvgiiuhHqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457645; c=relaxed/simple;
	bh=JotZ2xau8mAN2tR4U7+23HdeiUKQKBxFHUJQFHYwxwQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bpn9DLprFzDOoT1hPocEkSKYPV3Q1OCjcIBrjV4AfgQWaswzsGlxp+5RhPyfWXvOih5Rws5E6e18oMNAdpvaAn9lg/FoHRE/RFYo5+pnimVhkJighKBC/cPh7pSE8hx/KSiftKZSx3hC0ZFgrGkUmeRdpz0DPfBKhFkvEZG7G4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGcKIq3E; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGcKIq3E"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15fed5653eso197821366b.2
        for <sched-ext@lists.linux.dev>; Tue, 11 Aug 2026 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786457642; x=1787062442; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R1OJbwEkT9wgwkVybNm7HK0Xy2ztcCHJVSG06MAs0zA=;
        b=VGcKIq3EwVTNOkDvwJmlH/SibppjkCiFPgyHK78Ebt2nwC5Y94O2IDuXDGK7n2CeDZ
         9tO48hx1SLY2Rdr2xWXNgWQOS/Q6d3sA/PI/83KXFazegsKs6GnXh6mDeBumMsaihicR
         HKGY5SIktzSI6syKIhpcaDRsM/clyN4HSEHKmEYdmzmPJR2Um5AquRIdCJ0IewDUVDaB
         snpVpgwL4q850pn0csUyol8KRf2fdoei9PUTYzo/qEwJfDet67EHq2zFFk7F60077zi8
         FfGn7J/BZod6WUGNf/jnvw/on5/2HzSWOkNgZv0w1tehw2+Fd06S/FZKhUTNUoXrZCUz
         2X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457642; x=1787062442;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R1OJbwEkT9wgwkVybNm7HK0Xy2ztcCHJVSG06MAs0zA=;
        b=HEmgitIAorkykfaC+NQ5CltnmHz/3qT+yJwSDKj+BC5QGEvVwvG3z4FmgUFMWD0EVr
         SnMocnq+yRhZiFGeyJtJdVfU+XF5Oc09a7K7fSO3+2LD9fK1bbDgBtF0CvIcSyFuGrPU
         QGXPgnCW9n/dk1/K3WnPR/lRZKCtOhAVWub3NGhuxSefm0EjkW8gbOuRJLvbFXHutmp3
         qK27M4rF8ZHJRCBHQGRzVhKzKv7C5JoCFlgwFB1OWbhR/s+u7D/PMazCI6ARGixkGuGq
         orD13shD1wS+xMzwPhqW1stLSF5yAxWiuPqnK6puAQuWYKuDUk9UMryuZwIzSEyKF+X1
         1ENA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7BKLWgjfz07FF8UfplkwBxR9h+rdjb+JkZsbrnlwu27Ywc9wa2e6alKrZDm5Ul4/CxMpyFpyhIN0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwPCH6ObjQFaD9aGFDeFRgpzXOp/OnFCj2gtze1qeNQOTwg8jKl
	QyYI3dVMc4z5CIlllrpIn/ZQIvk4K2Pp9N/sevYAiAiVk6+U5I6GCfv/JIbbAArSXeHsWguVhS+
	DYl4qLySiORUVFZM2TQ==
X-Received: from ejed9.prod.google.com ([2002:a17:906:1749:b0:c12:718d:1964])
 (user=michalblk job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f59b:b0:c20:295d:6574 with SMTP id a640c23a62f3a-c20e605337bmr193175366b.12.1786457641579;
 Tue, 11 Aug 2026 07:14:01 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:13:58 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811141358.2767765-1-michalblk@google.com>
Subject: [PATCH] selftests/sched_ext: Fix flaky ddsp failure tests on busy systems
From: Michal Blaszczyk <michalblk@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Michal Blaszczyk <michalblk@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The ddsp_vtimelocal_fail and ddsp_bogus_dsq_fail tests skip calling
scx_bpf_dsq_insert_vtime() if scx_bpf_pick_idle_cpu() fails to find
an idle CPU (returns -1). On loaded systems, this results in the tests
skipping the very assertions they are meant to verify.

Eliminate this flakiness by falling back to prev_cpu if no idle CPU is
found, ensuring the illegal dispatch operations are unconditionally
attempted and tested.

Fixes: a5db7817af78 ("sched_ext: Add selftests")
Signed-off-by: Michal Blaszczyk <michalblk@google.com>
---
 .../sched_ext/ddsp_bogus_dsq_fail.bpf.c       | 20 +++++++++----------
 .../sched_ext/ddsp_vtimelocal_fail.bpf.c      | 13 ++++++------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
index 6f4c3f5a1c5d..7ef9de7b27eb 100644
--- a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
@@ -14,18 +14,16 @@ s32 BPF_STRUCT_OPS(ddsp_bogus_dsq_fail_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
 	s32 cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+	if (cpu < 0)
+		cpu = prev_cpu;
 
-	if (cpu >= 0) {
-		/*
-		 * If we dispatch to a bogus DSQ that will fall back to the
-		 * builtin global DSQ, we fail gracefully.
-		 */
-		scx_bpf_dsq_insert_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
-				       p->scx.dsq_vtime, 0);
-		return cpu;
-	}
-
-	return prev_cpu;
+	/*
+	 * If we dispatch to a bogus DSQ that will fall back to the
+	 * builtin global DSQ, we fail gracefully.
+	 */
+	scx_bpf_dsq_insert_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
+				 p->scx.dsq_vtime, 0);
+	return cpu;
 }
 
 void BPF_STRUCT_OPS(ddsp_bogus_dsq_fail_exit, struct scx_exit_info *ei)
diff --git a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
index e4a55027778f..82dca4cdc0a6 100644
--- a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
@@ -14,15 +14,14 @@ s32 BPF_STRUCT_OPS(ddsp_vtimelocal_fail_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
 	s32 cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+	if (cpu < 0)
+		cpu = prev_cpu;
 
-	if (cpu >= 0) {
-		/* Shouldn't be allowed to vtime dispatch to a builtin DSQ. */
-		scx_bpf_dsq_insert_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
-					 p->scx.dsq_vtime, 0);
-		return cpu;
-	}
+	/* Shouldn't be allowed to vtime dispatch to a builtin DSQ. */
+	scx_bpf_dsq_insert_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
+				 p->scx.dsq_vtime, 0);
 
-	return prev_cpu;
+	return cpu;
 }
 
 void BPF_STRUCT_OPS(ddsp_vtimelocal_fail_exit, struct scx_exit_info *ei)
-- 
2.55.0.679.g6767b8d81c-goog

