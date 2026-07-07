Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006A331A5B
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415014; cv=none; b=POJ3xiQ4rnYZWDEd/M9Bwahcev7QbnMt6C123D52Y8bHfmESi+acg/BNkoemOz8TdOLhHDLJgQzjOhtsWSQgfvHOmkW/qAj/hAuk46/Ce7aMG2cLZM8vdfWY/CCu/IzqeMdVeYlk8yntPNA+DYc6zze5vW31djAo6GFLa9lmA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415014; c=relaxed/simple;
	bh=qle7DWb5doxUSSdOrlYmIys+OvnBytxh8Nh53T/++8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5ilFFlvKVbbHeb1ZALtRRRErwTDJjwg8XqLr1998RxsBxZODWUm+PgzTRqJ6u1j0jfaoH0CNi5BJcC8KOyf6s5I89u6vF+w2i0iVHMXYiNWTcCg34MmVHpi9nF7R/+kPrYiRdLXc577ysOOz94jpC77lYE7l1PoYj/81z/1IDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=likewhatevs.io; spf=pass smtp.mailfrom=likewhatevs.io; dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b=OLWY/Fr0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p9ToHoKd; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=likewhatevs.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=likewhatevs.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b="OLWY/Fr0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9ToHoKd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 622CC1D00128;
	Tue,  7 Jul 2026 05:03:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jul 2026 05:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=likewhatevs.io;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783415012; x=
	1783501412; bh=xhV9ax+upipIFGC7gzN3+Rsuy761VCjlTtOxXjH1fE8=; b=O
	LWY/Fr0ZHbClS6cjvy5eFL5be/JywXzPPr2zdxhonMHr3nNFHKBKzLRHNzS+fc2Y
	8nat/q9NQVvwGEjYnWchGEqb91pxXwBWazNyQR+mUf9NI8QGmJ2mkDOGN86onvSJ
	aDNslErg5bz8w14acxl2bt/J1y2zhtcMluV3lUZEWAIjxgelioGhREGX1vMZhgE9
	kfy0mtOHHuwjoZr8gJIMGBQpnNeINEB5ZeahNrQ8jBpIlgqTxS9dJoThrnkX8FqO
	DXWMZuranm5Q06/nZdW8nPErXK5fG8+SZD3evnUCfLcj5pjKfLpexGzdLJ1Pb//H
	RnbCX8ZtaoGH7TUQxjwqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783415012; x=1783501412; bh=x
	hV9ax+upipIFGC7gzN3+Rsuy761VCjlTtOxXjH1fE8=; b=p9ToHoKdltT+Cahi6
	EVoUfaRMi1Kmh2bRsV6hfyn8wvdBJUIX6opbYrwWW8bk+9lmanLEiBimjBX8m0mC
	vEwStlwdA3qShWOIGrAtmVDh1IGQZsKqtNSDCa9oATrDsXKCdhG6pTV31eYiEWSp
	9jkAQL7S3+ZsofvDoGf1ygUAW7shOAsR/PH9awPEnZ1N7WtmsAfGxYzK8oRTvhaG
	DuVSSn4ExY08/uqLuRgpdLRwWB6pRWTGBkls+tsL3VeoSoXUfMe3rdOc4pK1VTUS
	SW+NxwaTMsKdyB0ELgQgVcSn+sFhSZPXJf1k0gYhIoEXXGMwmSgPUgJkR2QXIYP8
	wsk9Q==
X-ME-Sender: <xms:5MBMam6KUTLeD04ZclzLibgiJ0U8EZwW_n3zAHtT_LiXk4cHuErZGg>
    <xme:5MBMatvSnom23qJhyVYGU7VbBi8VmEPdsZanx33YkJiEWDSdXciRTtgXFV1Z63wk9
    riIR-b_rLTe1hams9Uii4grn41rXoLtawXTZ_P7iebi_Q5jtpH-Nw>
X-ME-Received: <xmr:5MBMav6-NUO_QrNfVb-QUEPaKpq1bHTbvcynVXq6fMIK7VJurn0WTnL67Jo5znrcZ0CLxyfUf-DEKw>
X-ME-Proxy-Cause: dmFkZTEUIU5JxyYoA6BXLwQvJEw0OZOSXZ3yNBxz1VJ212ZjaotfzbUINXiKuzPEtoqzv0
    /kuA2p72WmIY8+GzanX/s+wWPhws99iRocTasrR9/BDGLLRiEg0x696rbp9Xg9JeJ8/NJS
    I9YNo3OyYwiaBmvoU4Vn35AAPjwyNEApFTP1syL6Q5k7R4Z/fTkoti0tztQAM+D8FPkvCv
    OT+KE09VRU0JKxzINp2ec1s79jX43xd1WR5fPw53S1dtMLrtSMSIRp3xqeSqdWcKBrT/M2
    NrzjHb/q8u81nJFx9YzMNHdyh782IM0ORzVIZu+8GlwvjcUwqOxR2deMJO8cADv1w1TrPS
    x8TMJdjGVHq8On1F4uqJHIJvbUt1UY9+kIAiJZcRs6aOlLblVA6Ne/BydQd4tsX1L2yCBn
    xNCioJHGBcAISjZEutn0yHMZ0UQ3CE+1IglGbWYcUg3CiQivv6uERBySQoTWHxqQidpV2A
    Ne3QVkLjSnG0IWzzO7uh75l9aOTlc8YAnA9361glC7rwO2POdMw9liCTYNQHqQ3Se9jKPw
    i5DUTGK1sr5KmkIDCh6tAzSwwrftXNBsGkqO8lSVo2g+w98r7Bj44F6JQaMj9oF/WniB7H
    nVcKozejMReE95zFh/dUy9bR80wC29O/oRMcBgUciOIsKvPNPCX5PPLiRvuA
X-ME-Proxy: <xmx:5MBMagXUOIyWMwIB-k9G3a8EL3_ZEKSaTHiloDJYhqwK4cBpcehfGA>
    <xmx:5MBMap_XNRV7Pf6IUingqusAKia9nhed7VoJ7bjBdo8aLMD-6XMqug>
    <xmx:5MBMakmPZisG9phHZrBq9uux86_OEFBgVsOIfOAkiHYs5GVXXV4hjg>
    <xmx:5MBMavUqxafx0VkDXmKGnvENGzxHEQh21qV62nriduAXIQWA0aGkDw>
    <xmx:5MBMakNJTiU2IHXRblq7G6Tj8f6czQoGWn1AV8cNCzsg3hp_nuizVsnd>
Feedback-ID: i7f194913:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 05:03:31 -0400 (EDT)
From: Pat Somaru <patso@likewhatevs.io>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pat Somaru <patso@likewhatevs.io>
Subject: [PATCH v2] sched_ext: Add tracepoint for scheduler exit
Date: Tue,  7 Jul 2026 05:03:14 -0400
Message-ID: <20260707090314.2567145-1-patso@likewhatevs.io>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260512055632.1096713-1-patso@likewhatevs.io>
References: <20260512055632.1096713-1-patso@likewhatevs.io>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_ext schedulers have state in BPF programs and kernel. scx_dump
provides kernel state and BPF program state on error, but this is static
in what it can provide.

Add a sched_ext_exit tracepoint in scx_claim_exit() so that BPF programs
can dynamically inspect scheduler specific state at the moment of exit.
Pass the exiting scx_sched so attached programs can read its state, and,
since exits propagate through a hierarchy of sub-schedulers, identify
which scheduler each event belongs to.

Signed-off-by: Pat Somaru <patso@likewhatevs.io>
---
v2: pass sch to the tracepoint and record name/level so exits in a
    scheduler hierarchy are attributable (Tejun)
v1: https://lore.kernel.org/all/20260512055632.1096713-1-patso@likewhatevs.io/

Tested by attaching to the raw tracepoint and unregistering a scheduler:

  # bpftrace -e 'rawtracepoint:sched_ext_exit {
        $sch = (struct scx_sched *)arg0;
        printf("sch=%p name=%s level=%d kind=%ld\n",
               $sch, $sch->ops.name, $sch->level, (int64)arg1); }'

  Attached 1 probe
  sch=0xff1f39c90f1c7000 name=mitosis_1.1.0_x86_64_unknown_linux_gnu level=0 kind=64

 include/trace/events/sched_ext.h | 23 +++++++++++++++++++++++
 kernel/sched/ext/ext.c           |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
index d1bf5acd59c5..ce1179478e8b 100644
--- a/include/trace/events/sched_ext.h
+++ b/include/trace/events/sched_ext.h
@@ -84,6 +84,29 @@ TRACE_EVENT(sched_ext_bypass_lb,
 	)
 );
 
+TRACE_EVENT(sched_ext_exit,
+
+	TP_PROTO(struct scx_sched *sch, __u32 kind),
+
+	TP_ARGS(sch, kind),
+
+	TP_STRUCT__entry(
+		__string(	name,	sch->ops.name	)
+		__field(	__s32,	level		)
+		__field(	__u32,	kind		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->level		= sch->level;
+		__entry->kind		= kind;
+	),
+
+	TP_printk("sched %s level %d kind %u",
+		  __get_str(name), __entry->level, __entry->kind
+	)
+);
+
 #endif /* _TRACE_SCHED_EXT_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1a0ec985da77..6ec774435cd1 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5730,6 +5730,8 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	 */
 	WRITE_ONCE(sch->aborting, true);
 
+	trace_sched_ext_exit(sch, kind);
+
 	/*
 	 * Propagate exits to descendants immediately. Each has a dedicated
 	 * helper kthread and can run in parallel. While most of disabling is

base-commit: 57194a3172ba0123e8f37c4574a8e2863ab67622
-- 
2.55.0

