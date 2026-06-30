Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719832C957
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828429; cv=none; b=K2GAkmBeUBLIGwS/EOOp6Upta79fz5+y4VWWnG4C2+bCCdN05M0DS1awbnctOqsn3uM8aNHBiubPBVs9/lGs58WEB/4XzBstvzUZe13h8WHag2DG+dvc5fbPF7BSdAexx7hHeHanrYzmol97wWFaaOkZuNxCUgRz5EXccq3D3MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828429; c=relaxed/simple;
	bh=4kNfCRrtZn2Gdi36rLiybByGu73JJRxevRkkBFj4t2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFdoXuy0Nd3uNGd8pHvD6roMyZ1P5TRhgnCbt76Md4z8eF5nua6bFtx3BfOSTQVW66psSoa9KnHqsIdqhNgUm6XNIfADiRSdwYRbkX0mFXmOp8hUp+wsrL9ZE/3BKFvcstQxcjt3aRxM9+I4Rap3WJwVnBQtVCDRxUUSd/CKZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auroM8gS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auroM8gS"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c998fd549a8so780312a12.2
        for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782828428; x=1783433228; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/SDPFfo/983VwJwhGCyeUJyDXQJZkCg8/YfjRXLvW2U=;
        b=auroM8gSj24dKBGAQjGrzBsQBxaX0ra0J9YLQn8jINy2qWqnM6iHgIbtG8eNKBMBnI
         BIFVaJTYEK7R27QrMM6Z/FX1fONX3F7pVNqakthtI4K/30qvg8+jZgEgAiPF2IvO6cUs
         K+aKl3yfCPX47eX3qNatiJWVIBdP1A+GhYwKsPvRYiMoYJEXIYO6TY64eTqnhVbaC2xz
         34HtbgrFBG/wDUf33eucC315MDcGCsm6EtHgA6TDOeSSKPau7jtrsq3VtbB4AlKRE7ZF
         CMdQCDwDukEXjlNIOSW745jIOZvKNSoGleZrEmBf9jUAvD9Sfa8vk1AOyocm3t/e/cOv
         YsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828428; x=1783433228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SDPFfo/983VwJwhGCyeUJyDXQJZkCg8/YfjRXLvW2U=;
        b=Nf7Znw6g0fCNsmQzCPPbJbSEZvQXd9XloTq+VQ/qZ9FVb9OPGH5zawvY/Z3sCLutAm
         FygX0+qJGWjwibW0GuLZWYBQIXiXOVTshs0uIBpYv9BUU/bJ2nhidMkWllMhO/Zc+7Or
         gqCVfjIqATV+Ax4DMDuy8cfMH+i741e7KZ7RF9gnwpN0L7xrPcRTd81VrHpfC8QNhs/M
         cYnKoiwWfPpeI5nFUoPUBFplQcpttUs+tL3VQY/o3l4iXLQj+pWRPYTGPqFFM8EwRscQ
         MeIFR7pNZMA/zeW7dMe/s/6ohhfRp8oC2PWh38QAGuQLi+tTAlD0Gt3KvUNdq/Swn00K
         1TaA==
X-Gm-Message-State: AOJu0YyNq1g1DClxuQYy40Sy87J9HH74ZPLBz4K9e+2xutndoGnRjH/H
	bdAWueh6+ctLWUNHN80Z+gDVboTga9o8oAAlmSAlXylnhnuCB/A0sdAO0PcT1Q==
X-Gm-Gg: AfdE7ckqhfCRbKQ2DzBNrEDbm2gqg914eDoWigkRUwwLoOXliOqFxYM16uAp1XxE38j
	GezKGJ3sA2oNYZmz/ttTHt+r6vOBoDumrJwqSm1RA4PwO6QWr9NQ5fao9ozurEg9BoeyJtdisNG
	T0xm36d+6/bxpIvobFrr0cjhXVMRV1HSatCeSGSkg/rM5pFJ2Xu2L7+sIem5BmF7JxK46ZZZD2d
	/yO+fVueS9lKYmakZrCLXFeRpLHnWTUQcbOyYhBg1zm9O53GlrBD3sUQSAcTp3BRofEQn7fl41Z
	zA47P2DFriXfLSLA2ipbaChADaQFZBXpixTpq25JedMqucki9Tov7E99Sw0q8bZ23BrCUJJB/RN
	66lpxSEKKbju+8+kKZ8jsET/45doqtCEdyY86DuQvF9ksYEw+x5idr9TZOOHwbmEoWxGxc4vMW6
	mpfvsq93BSQ90NwvPkMnLNKTeZ24KIyNeflYXHM5KT/qjaealxZyOkzSAiYli3ThEmLk1XgPTXg
	Zc=
X-Received: by 2002:a05:6a21:6f09:b0:3bf:ab02:439e with SMTP id adf61e73a8af0-3bfdc35db83mr516582637.27.1782828427620;
        Tue, 30 Jun 2026 07:07:07 -0700 (PDT)
Received: from cchengyang.tail151456.ts.net (36-226-206-10.dynamic-ip.hinet.net. [36.226.206.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bc04ee046sm1538999a12.27.2026.06.30.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:07:07 -0700 (PDT)
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
Subject: [PATCH v2 sched_ext/for-7.3] sched_ext: Replace open-coded event lists with SCX_EVENTS_LIST
Date: Tue, 30 Jun 2026 22:06:23 +0800
Message-ID: <20260630140645.8855-1-yphbchou0911@gmail.com>
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
authoritative list of event names, so all three sites stay in sync.

No functional changes.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changes in v2:
- Use SCX_EVENTS_LIST() in scx_read_events() too, matching the other
  two sites. Drop NR_SCX_EVENTS and the s64 cast loop, which assumed
  struct scx_event_stats is a packed array of s64 (Tejun Heo).
- Link to v1:
  https://lore.kernel.org/r/20260629143532.15014-1-yphbchou0911@gmail.com/

 kernel/sched/ext/ext.c      | 61 ++++++-------------------------------
 kernel/sched/ext/internal.h | 15 +++++++++
 2 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9c9cb9d08bca..0c51f9826a77 100644
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
@@ -10333,26 +10303,15 @@ __bpf_kfunc u64 scx_bpf_now(void)
 
 static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *events)
 {
-	struct scx_event_stats *e_cpu;
 	int cpu;
 
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
+		struct scx_event_stats *e_cpu = &per_cpu_ptr(sch->pcpu, cpu)->event_stats;
+#define SCX_EVENT(name)	events->name += READ_ONCE(e_cpu->name)
+		SCX_EVENTS_LIST(SCX_EVENT);
+#undef SCX_EVENT
 	}
 }
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 75522a5f28f4..0256931a379a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1051,6 +1051,21 @@ struct scx_event_stats {
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
 struct scx_sched;
 
 enum scx_sched_pcpu_flags {
-- 
2.43.0

