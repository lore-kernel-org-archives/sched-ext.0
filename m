Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC81334C27
	for <sched-ext@lists.linux.dev>; Mon, 29 Jun 2026 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743761; cv=none; b=C3mA/vGwto5ncZWIettMyDomZaPBJo8hgYKJilsT05W2bZUkFONVFpdS4gCUcVFN2eqImkHjwA4qAJx7ZcctFzyxiiKME/UEMsgeHA51TK9VE+B76RQM8goYfwbZ/Zu8DqaVRuNoaTGLT/xOgudIdH8A9itD4H7aNTjUpG92/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743761; c=relaxed/simple;
	bh=nYotg/oMnEwgr67+hFQJptrL8tKl/VP+ELNYMZH5YkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKBrVM0BUsXWpw2XBKEtloncM92IflkLUwfE1w4B0JIW8quX3C+2XwmLjGhg9cUtfkFWoaNwTCunfMPEC38UDdtVI8mXZ7gyP1RGOPxVHJ3fCLUm38ese/9tAY3/2mX46F0CbjCH4a8OOeicwLHHfikXKpU8hCymZ71YnKtZTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe4faddA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe4faddA"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7cfa17fedso29157375ad.3
        for <sched-ext@lists.linux.dev>; Mon, 29 Jun 2026 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782743759; x=1783348559; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4CgtzhdE7FSCVvBzs/QMtRxXyWvbiWrccUzUgFn4gw=;
        b=fe4faddA8aMV36IwcZYHC9JJeA89ikShB5k9dQ0bLDxkPeFRloSe7ufJoxpxXoPzk2
         FwXIng7aK0DydTCLOKGY+paZu/mZbNB9CI8QxfrOs7Kl2E6l942qoJRF+l1ai/T4/BMq
         l6Z8pB1+rvjxobFyhYvKXfKQdxBAKsWo07MZ3mK6BGDoVrbbv0Xx8ptbryDDtl3ia7SA
         UgPmtDejCQHmcGnH2isZJk/x9IKLJKQT1Hpxr/5yLlLmgURyOxUc6UnuOZslferqDfgs
         EEGzqUd57xUe8QdBg+z3FvvEi0Ji/VJ6J1OmemnAFEBKYhbUD61WLSE5b0zUDfws5jRx
         dSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743759; x=1783348559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4CgtzhdE7FSCVvBzs/QMtRxXyWvbiWrccUzUgFn4gw=;
        b=AvS+HnM8LvvjgwZRrIfIFrEk5KVHbfnvnpnhvbL+QmsiXEykIX5cFs5ssTvg2RdQvi
         nk3qohWmayX4QwCTErU9506q9VmeI6HiWHMM7vLq2KSlcm7zZX7SpvqaO/kLYphxGC3d
         neI4JlBykv8Cqmist2A88GIctR+gxVWzW1IXioTK239g1sgDd4EQajy1s2J2hsiIGbTC
         M3JHPrbKu3TuHi3s+LYuMbStCCyw7qAHMN4gZkz6x3T7GCeCvNgCZMLUY7lkvBLy54aQ
         VLW+OtlW8wd9wch1sbdJLzKBAhEuyT1eNetSe0iHYuV/bigjL/YEkxEIqw0jrPp9vccO
         0MTA==
X-Gm-Message-State: AOJu0YziSDS22S2eLfVuXNfwb3xcrPgqSYtvIE1/qu8TfRFqa1oYBAMa
	70h1pdLLy2aukhhbYPFuE9RZfOBEzVQVShuQ+iQLmbeOLbhKciNvxZ9vGeTiSQ==
X-Gm-Gg: AfdE7cmICv+QDIFYCjeA3P8W/j44rF+bE0hERz4P0MzkMCsuayZKSBan7aR5oFOLAaq
	sYv4vHy9YPGQ5HvawQKncPUtUg4SKwRcQPQPmO+DOF68Ln1aBZakZL2KgzAYZKB9wNqEIn80Ru2
	MpqaZSSbzSFS4l8ryGmlnQD3ZqJ4pG2mMmwKyO2EIKLLrtsCY+WZVl3XROaYlN6Y+xH/710WuJR
	itfeuPvv3hcTbuVLuLw0IP2GpdTiK2qHCtxCkFbP9gP4YNsbfpFAiJdXSwFnDyRLLLhteCIbPnw
	1f5M6dTEDT8NnA9FRm4JXdXxOfmv1zbKPQWdl7OBDw5JWoO3JVPU8/L4CVbIRF5d9gkAfH3GNsQ
	phr1PrzBak2onjfTzTldwHRSb+s3T6dPiJCR8+kGDFl49zWidNGTskiH5Dl1RBnNAg7qbNnGJaE
	pk4/IwZ1z0wg6ysfOQ+r9qe8e3Yjkt2pNFteeaXB8sXsH9rvI72soUEmWgTsRfKT1nDOUvsm7j7
	X0=
X-Received: by 2002:a17:902:ea04:b0:2c9:f107:cb1b with SMTP id d9443c01a7336-2c9f107ccd9mr37396815ad.38.1782743759228;
        Mon, 29 Jun 2026 07:35:59 -0700 (PDT)
Received: from cchengyang.tail151456.ts.net (36-226-206-10.dynamic-ip.hinet.net. [36.226.206.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9b43af119sm46785805ad.48.2026.06.29.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:35:58 -0700 (PDT)
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
Subject: [PATCH sched_ext/for-7.3] sched_ext: Replace open-coded event lists with SCX_EVENTS_LIST
Date: Mon, 29 Jun 2026 22:35:11 +0800
Message-ID: <20260629143532.15014-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three sites enumerate every scx_event_stats field by name:
scx_read_events(), scx_attr_events_show(), and scx_dump_state().
Adding a new SCX_EV_* event requires three separate manual edits.
Missing any one silently drops counts or omits the field from
diagnostic output with no compile-time indication.

SCX_EVENTS_LIST(SCX_EVENT) in internal.h becomes the single
authoritative list of event names, with NR_SCX_EVENTS derived
from the struct size, so all three sites stay in sync with one
edit instead of three.

No functional changes.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext/ext.c      | 64 +++++++------------------------------
 kernel/sched/ext/internal.h | 17 ++++++++++
 2 files changed, 29 insertions(+), 52 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9c9cb9d08bca..57acefdd9573 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1004,16 +1004,6 @@ static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
 	trace_sched_ext_event(#name, cnt);					\
 } while(0)
 
-/**
- * scx_agg_event - Aggregate an event counter 'kind' from 'src_e' to 'dst_e'
- * @dst_e: destination event stats
- * @src_e: source event stats
- * @kind: a kind of event to be aggregated
- */
-#define scx_agg_event(dst_e, src_e, kind) do {					\
-	(dst_e)->kind += READ_ONCE((src_e)->kind);				\
-} while(0)
-
 /**
  * scx_dump_event - Dump an event 'kind' in 'events' to 's'
  * @s: output seq_buf
@@ -4989,19 +4979,9 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	int at = 0;
 
 	scx_read_events(sch, &events);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_SELECT_CPU_FALLBACK);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_DISPATCH_KEEP_LAST);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_EXITING);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_REENQ_IMMED);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_REENQ_LOCAL_REPEAT);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_REFILL_SLICE_DFL);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DURATION);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
-	at += scx_attr_event_show(buf, at, &events, SCX_EV_SUB_BYPASS_DISPATCH);
+#define SCX_EVENT(name)	at += scx_attr_event_show(buf, at, &events, name)
+	SCX_EVENTS_LIST(SCX_EVENT);
+#undef SCX_EVENT
 	return at;
 }
 SCX_ATTR(events);
@@ -6651,19 +6631,9 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	dump_line(&s, "--------------");
 
 	scx_read_events(sch, &events);
-	scx_dump_event(s, &events, SCX_EV_SELECT_CPU_FALLBACK);
-	scx_dump_event(s, &events, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE);
-	scx_dump_event(s, &events, SCX_EV_DISPATCH_KEEP_LAST);
-	scx_dump_event(s, &events, SCX_EV_ENQ_SKIP_EXITING);
-	scx_dump_event(s, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
-	scx_dump_event(s, &events, SCX_EV_REENQ_IMMED);
-	scx_dump_event(s, &events, SCX_EV_REENQ_LOCAL_REPEAT);
-	scx_dump_event(s, &events, SCX_EV_REFILL_SLICE_DFL);
-	scx_dump_event(s, &events, SCX_EV_BYPASS_DURATION);
-	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
-	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
-	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
-	scx_dump_event(s, &events, SCX_EV_SUB_BYPASS_DISPATCH);
+#define SCX_EVENT(name)	scx_dump_event(s, &events, name)
+	SCX_EVENTS_LIST(SCX_EVENT);
+#undef SCX_EVENT
 
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
@@ -10333,26 +10303,16 @@ __bpf_kfunc u64 scx_bpf_now(void)
 
 static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *events)
 {
-	struct scx_event_stats *e_cpu;
-	int cpu;
+	int cpu, i;
 
 	/* Aggregate per-CPU event counters into @events. */
 	memset(events, 0, sizeof(*events));
 	for_each_possible_cpu(cpu) {
-		e_cpu = &per_cpu_ptr(sch->pcpu, cpu)->event_stats;
-		scx_agg_event(events, e_cpu, SCX_EV_SELECT_CPU_FALLBACK);
-		scx_agg_event(events, e_cpu, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE);
-		scx_agg_event(events, e_cpu, SCX_EV_DISPATCH_KEEP_LAST);
-		scx_agg_event(events, e_cpu, SCX_EV_ENQ_SKIP_EXITING);
-		scx_agg_event(events, e_cpu, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
-		scx_agg_event(events, e_cpu, SCX_EV_REENQ_IMMED);
-		scx_agg_event(events, e_cpu, SCX_EV_REENQ_LOCAL_REPEAT);
-		scx_agg_event(events, e_cpu, SCX_EV_REFILL_SLICE_DFL);
-		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DURATION);
-		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DISPATCH);
-		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_ACTIVATE);
-		scx_agg_event(events, e_cpu, SCX_EV_INSERT_NOT_OWNED);
-		scx_agg_event(events, e_cpu, SCX_EV_SUB_BYPASS_DISPATCH);
+		const s64 *src = (const s64 *)&per_cpu_ptr(sch->pcpu, cpu)->event_stats;
+		s64 *dst = (s64 *)events;
+
+		for (i = 0; i < NR_SCX_EVENTS; i++)
+			dst[i] += READ_ONCE(src[i]);
 	}
 }
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 75522a5f28f4..b03fdb382af7 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1051,6 +1051,23 @@ struct scx_event_stats {
 	s64		SCX_EV_SUB_BYPASS_DISPATCH;
 };
 
+#define SCX_EVENTS_LIST(SCX_EVENT)					\
+	SCX_EVENT(SCX_EV_SELECT_CPU_FALLBACK);				\
+	SCX_EVENT(SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE);			\
+	SCX_EVENT(SCX_EV_DISPATCH_KEEP_LAST);				\
+	SCX_EVENT(SCX_EV_ENQ_SKIP_EXITING);				\
+	SCX_EVENT(SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);			\
+	SCX_EVENT(SCX_EV_REENQ_IMMED);					\
+	SCX_EVENT(SCX_EV_REENQ_LOCAL_REPEAT);				\
+	SCX_EVENT(SCX_EV_REFILL_SLICE_DFL);				\
+	SCX_EVENT(SCX_EV_BYPASS_DURATION);				\
+	SCX_EVENT(SCX_EV_BYPASS_DISPATCH);				\
+	SCX_EVENT(SCX_EV_BYPASS_ACTIVATE);				\
+	SCX_EVENT(SCX_EV_INSERT_NOT_OWNED);				\
+	SCX_EVENT(SCX_EV_SUB_BYPASS_DISPATCH)
+
+#define NR_SCX_EVENTS	(sizeof(struct scx_event_stats) / sizeof(s64))
+
 struct scx_sched;
 
 enum scx_sched_pcpu_flags {
-- 
2.43.0

