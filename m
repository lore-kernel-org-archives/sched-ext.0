Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446043;
	b=qf1jTAYujsnb9GrD/zyXLTb4ez8UOcc1T2EIBPBWnNRbOy9FA3ZjnfJOHszVGxE/jxbp
	 8HcpbquQtf41CyiRoPn3HgGdWCMtL/V6AkQ/s2LQp1wnbRYf2xsrbDuJ5Dk2vO9AoaHL8
	 fRQXpq0bcbol5GoxwvgJudQVpVfl+KK8dxYb7eGNp+SMYPXYwnhL4wAomozwaJ3Khx7cc
	 VaqKmrHiGR1ojdK+lWNm5YnH8IdJuSE3PEhwItbNBpoT7GOq2bVl0g4KyVaodDlVrVkNS
	 KNWZIPtl3vQlJcItW1/SB6HQv1r7ktDX2zcsVjeLH4Z8YyC/vVzdH19BtOyZwEry88g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5bhB0j7PZndj+krPWvFm+PmAXvCQo2vJ9BSvfaD/GZg=;
	b=a+d600ieZ75OcfEuZB8UPlZujxOQTZ4YCPZ9emuNxVclrC1dIOeE8mnxBHMsVDzNtRCZ
	 O4nKLGHiUOyl/fjPilMXBQscRnESYuw9e2AaMDAWghw75ptC3HGo1WDuSniCJCARBh29O
	 Tgep/w8LzG4R61wx5Xm1xLO2aIk2XfFxqEHxJTYhHiV10vHW15BwRr2CLDS9+rwOVAiCu
	 LbvB1E7yWLTjSP9+HvCvWWHC0LX7glXGz6IAHEA5o1xwopuqmdC16ntuVp1iH+l2fbVap
	 MOf15aeotxh6wBzUu3hruT6gkPkPtnKy7oFthe4yZRI9iScJSCKE6/X4BCyT7sjDK1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aCZgOVJZ;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE9606A680
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 15:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7CE9606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aCZgOVJZ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb64c99bb8so26782055e9.1
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 07:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795446041; x=1796050841; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bhB0j7PZndj+krPWvFm+PmAXvCQo2vJ9BSvfaD/GZg=;
        b=aCZgOVJZNNc1dlNKQSh1lR2RHkm3E93m7MEi8dR4fGqlJBEpF2zU5AkmZTxHhgCw0h
         QHeRwQwxQJBs42tEJXywAQ4v5ozRavWa4BCwZUkD+/M+LGhamU6wSYa+dU4dWbhJ1VIX
         c/NeCDzu059pOwnhHRqFFP97lFMXjWwWFpL7TLkmVz12pKIhZ7qdJVBNfQvVIyhcoW0u
         /Y35Lm26GTjY3LZDZHanZOGPKTdoGvv58fslO8/P9BxhnLwgW5N7DVYgGjgEkldc37NH
         qF12AtjuyCYuFP+BVF1PaI9VVJTaSbaLsDil+pGh/2rR5gtQFM5/Vc7kECqOqjOp3Hu6
         28sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446041; x=1796050841;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bhB0j7PZndj+krPWvFm+PmAXvCQo2vJ9BSvfaD/GZg=;
        b=hkIa6T7a/wsMQgNmoHrdmlEJFMKKfwIBW/VlL6KKx/TmqbIZEAgTXWWxdRCkhzbcDw
         P4/5ixAcIksOU+0ewOd9PZvba3Uh+lyM7z9GmbrSFySyRWHBHWuI0+nC5U/heEAbOsPh
         dtw6WtwP0Lf9n5UgVpMjf+AfYiy1vsgDDc1RPemZYT1QVvzP5pqKbCUvxv0/5qNVb/3O
         S277QyQ5nhJKT+2ngHF4K4mARrKdTBTXkKJRhQ7zkM5BOCH5VfLohjk75UNaYNhPk+I+
         BpO8P+sGFF7rb8JtfV3HgULZ/ZQcJvk8FapgdgggWtjZ76y6E6EtlwZIauGUuJYTmFuq
         2Q1g==
X-Forwarded-Encrypted: i=1; AL+hErGAq+16z2ZeLzriomK3jZjZHEnh3WpkOBKen3eSOr/14tGYjWbfkurRIIsAhj368Qa0zH84lv6Np8o=@lists.linux.dev
X-Gm-Message-State: APuU4Z8DIFh0IueSP2gtvRnG0Zoc9P6NplVlHAgIS2GHy9rO7uBVE1Vk
	B/HvXkeM+3S5sYeWaI/Fo90hA8MHeVAfsJ6stPXsz1kCqRoEoxDrr2A5RRyCMslnsV+KVkK9Z2Z
	99sh8JeFmckmTlg==
X-Received: from wmoi24.prod.google.com ([2002:a05:600c:4818:b0:4a2:df9b:ef74])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d09:b0:4bb:6b59:aac3 with SMTP id 5b1f17b1804b1-4bb88816050mr251406095e9.29.1795446041138;
 Mon, 23 Nov 2026 07:00:41 -0800 (PST)
Date: Mon, 23 Nov 2026 15:00:38 +0000
In-Reply-To: <20261123145927.577162-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123145927.577162-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123145927.577162-3-jpiecuch@google.com>
Subject: [PATCH 2/2] sched_ext: Take rcu_read_lock() explicitly in sub-cap kfuncs
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Ryan Newton <newton@meta.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_bpf_sub_grant(), scx_bpf_sub_revoke() and scx_bpf_sub_caps() look up
scheds via scx_prog_sched() and scx_find_sub_sched(), read the cid
tables and, in revoke, walk ->children while holding only
guard(irqsave)(). They can be called without rcu_read_lock(), e.g. from
sleepable ops or bpf_timer callbacks.

This works only because IRQs are disabled and none of the RCU checks on
these paths require rcu_read_lock_held(). A plain rcu_dereference()
added to these paths would trigger a lockdep splat when called without
rcu_read_lock().

Take guard(rcu)() as scx_bpf_sub_dispatch() and scx_bpf_sub_kill_bstr()
already do. No functional change.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/sub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index d2a20114eaa2..45aaa333f9c2 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2870,6 +2870,7 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 	LIST_HEAD(to_deliver);
 	s32 si, ret;
 
+	guard(rcu)();
 	guard(irqsave)();
 
 	ret = sub_cap_preamble(cgroup_id, caps, aux, &parent, &child);
@@ -2999,6 +3000,7 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
 	LIST_HEAD(to_deliver);
 	s32 si, ret;
 
+	guard(rcu)();
 	guard(irqsave)();
 
 	if (sub_cap_preamble(cgroup_id, caps, aux, &parent, &child))
@@ -3092,6 +3094,7 @@ __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out_
 	struct scx_pshard **pshard;
 	s32 si, ret;
 
+	guard(rcu)();
 	guard(irqsave)();
 
 	sch = scx_prog_sched(aux);
-- 
2.56.1.750.gf70dc682cf-goog

