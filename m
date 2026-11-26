Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710476;
	b=FFrWgVJlmDhyAvBabdDmvEYJwD46YBDFnR5PwGF9RmScGvOLvNEfUfPWIRY3wJBwO5yZ
	 i+QDnLlUBh2MIbz8nrW2gujKoo89B40/TUZYNeo5I7pvH0WugsmG6CW3Paj+4anEmWKqU
	 XHmdRhKVM4FPHdh2i/Czwe/v+5fggkVC8oSewWtS1/aYqIzUc7QhurxuryeuVMED6vOK1
	 Jbt4ka50jnV/ifkliqEbjAM0aN256VA73coK65X3IHvZp2dSgyCO+7vvWnGbE79MDZ0ub
	 mRqeCGxiUosaIWIAtI68JmiR22DuTqpqRPyjeJwysLmQ1aDmVNiLQjDLdHLRsyJNtMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zx2PX5ffkPJPf6TzIozB55NAQJzc9RQ5Aq9V1KvYSuQ=;
	b=BGttHXJC/yrDQIVwwXFMxQ0c9Ua6c3FoCR/g2opuxQlgbBSUNBZ/fN2+wsAzZZYXQHzd
	 Kt3fzWRj72EFY6QYTqLokByHk4bb0/02VPAZIroD+8ZgJ/1kPPq/xXK+4PrH3xBOWGN7M
	 /uQq6P/KQv90TSIAM7meJE7YTxEit0pfEfLrZ3S6CNnEy5akGwkzsMRyNL4q5KqGRxY6f
	 34oAQcfr0ZJJYOZg5MQkQz91a5U5u1h8M1cv5AZUxMDV2RuWsUXNl09fo9oo5rjZPgvyr
	 ZX5lHl+cCwX0zAvDthsjX0U8VWjWvRTJ8bm8Wf2da42HmYjbCa8Eszpf/WoqCAer8dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AugCr7ty;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2150606A31C
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 16:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2150606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AugCr7ty
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8d1aec63541so287039b3a.3
        for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710475; x=1796315275; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zx2PX5ffkPJPf6TzIozB55NAQJzc9RQ5Aq9V1KvYSuQ=;
        b=AugCr7tyFEFYGU127YiRLOw0VHwddnJ4vMwIj4JksPjVhuHm3amSk6xFNYAmHVAXz7
         0pbHUQRd+7wfOy6mlri+NT4WoEvfyQH49v3Wmqdp2p1SDxZLPxE5jEg0RJFBydddCsLL
         UqF7JsPD6po1IRnBoicA6iFTJ7MRRm9Z3iJBE5qfqbQMJRePKwJzQmDBOmA0AsjS/k9x
         EvcatApBOUXVifUGMJbDHKkFjS4uj7VDLJlcY7/ZCY9QvcWsSCP9UCY997Qf8YJY/LBZ
         MuUeuruJ5C4Fptb6FD2zGoqXjXnt3CI2LDmqmTFXGMK77SAhi+X54bbtOuX7yQU2yazB
         Ephw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710475; x=1796315275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zx2PX5ffkPJPf6TzIozB55NAQJzc9RQ5Aq9V1KvYSuQ=;
        b=QRM5dtZFj5cpVC5lSl9OPvXTR0jxH4qLF+KwL/dmZFaBNldEnvw0Vcmd4LkBhkaO9z
         WWcB4VsNbz5qd0VTLsoscrzeJpeLNVVUpvVjwQuJ6cnwkSvbT5pmyAolJ2+7bgWI1/5F
         deOHHJmm6LUxkQ4OlzDY3c/VuEuyR+93zs1KkmHr2POI5u20q0eLbKDJNpLZ4QjZh27t
         bxe5mikTeDjYI08qB8+eDup5FyjhaSrk7+I7eksxL11YBuVLqyD8e6TRB7DM2Hzuhdjj
         8ghPLSJdWaDd7QYZJx8HykRu+9HkVRYpCjZIChp5rEGHa7ntmzU3F+XRa2/JXnkVgq9y
         znLg==
X-Forwarded-Encrypted: i=1; AL+hErFJZ0rqD7DBowvNUCExYHmZIoyS95+ImwsVwnxD8P2R/RMqKKt6aEi24LNVqRwGIeWsW6NZ/ZXFZ6M=@lists.linux.dev
X-Gm-Message-State: APuU4Z/lbRLlsb+etHew7x/Rpxy/N47NH+0QfAmldPLy0XzGHYkaJVxw
	0NUsI7VGCNrZV9sU19uVRxtFkU/p2nW95+uqeoI57F72iNJo0m7VE+X0
X-Gm-Gg: AZFdTZfQLtLcqDhFhoIsF+GZyY5ywPhxBqGKWo8vqk5BYNnFDUrWvO3zu6EdTI0CdkZ
	C2yfLDJIK/MYAGsuWZtcWTm5nd0oiEG/zdYdGORR2ypWwAnYSmGuJLBLnFoM8VQZi+996gEvUPp
	/SKqh5xTKcDtI5AEMx3/xIIN7TFJaYYFWBc1e+nrFqe3lr17UOyP1io2y7eHYirgnI/xTVthQcE
	NaRPu4BiDcNrJhxll8g8odeK4wn15or2trvD7C4rAa3KaYueDIWY19Ga0pOVVfXrLncOGFpMZfx
	imZsnBn6GctvteUTRmGUUcqKI8ksfKVJPWe33agG0lgtr6DF2WCPpKTBQs46DxFlsoBFaPnFqYN
	a2ZlC3SexiOzjsp2FkQGzmtuA1bGDdD7j5IKKQJms84IrgnMpEewYbDxjKUpGi+d1FwOZC2sOMV
	ueKrd67GN42hScoUF2XfAii9jIJr3GYfA7fGVFmgScMzNlYK+WUSRRHpst3xnehzPPehm8jXuOL
	/xFp+wh778ghiUuqYJcYplxmBzlkUrUmpgKog932baAs41c9l+tBXv7kDTtbTCHnLBgxQYBBdXy
	rnghPT0ddEuagMWXTJou5alXnhSS6oI0pz1ZjnSXKklPalx6EEs3f036SHyiqkYBlToLmVYFWQg
	Wrf5BgQiESiIpVta9fINqr6n0hjw7vvGcUQ==
X-Received: by 2002:a05:6a00:14cc:b0:886:a52a:316f with SMTP id d2e1a72fcca58-8c8792b6925mr19988696b3a.4.1795710475202;
        Thu, 26 Nov 2026 08:27:55 -0800 (PST)
Received: from cchengyang.duckdns.org (1-164-86-80.dynamic-ip.hinet.net. [1.164.86.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f83dsm11037097b3a.39.2026.11.26.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:27:54 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kang Chen <k.chen@smail.nju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	sched-ext@lists.linux.dev,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 7.3.y 2/2] sched_ext: make DSQ iterator stay drained after NULL
Date: Fri, 27 Nov 2026 00:26:58 +0800
Message-ID: <20261126162700.22257-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126162700.22257-1-yphbchou0911@gmail.com>
References: <20261126162700.22257-1-yphbchou0911@gmail.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kang Chen <k.chen@smail.nju.edu.cn>

commit fcbff7b56a881bbe041b6c5ba12831a3c1ac1bb4 upstream.

nldsq_cursor_next_task() unlinks the iteration cursor when it reaches the
end of the DSQ.  A later call sees list_empty(&cursor->node), starts
from the DSQ head again, and returns the first task of the same
iteration.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats the result of later next() calls as the
constant zero.  A restarted DSQ iteration therefore hands the BPF
program a task pointer while the verifier believes R0 == 0.

Remember the drained state in the cursor flags and return NULL on every
later next() call.  The cursor has spare flag bits and the BPF-visible
iterator layout is unchanged.

Fixes: 650ba21b131e ("sched_ext: Implement DSQ iterator")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ chengyang: drop __SCX_DSQ_ITER_HAS_REENQ, which 7.3 lacks ]
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext/ext.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1049a0914d60..6db6ca912bb3 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -492,11 +492,13 @@ enum scx_dsq_iter_flags {
 	/* iterate in the reverse dispatch order */
 	SCX_DSQ_ITER_REV		= 1U << 16,
 
+	__SCX_DSQ_ITER_DRAINED		= 1U << 28,
 	__SCX_DSQ_ITER_HAS_SLICE	= 1U << 30,
 	__SCX_DSQ_ITER_HAS_VTIME	= 1U << 31,
 
 	__SCX_DSQ_ITER_USER_FLAGS	= SCX_DSQ_ITER_REV,
 	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS |
+					  __SCX_DSQ_ITER_DRAINED |
 					  __SCX_DSQ_ITER_HAS_SLICE |
 					  __SCX_DSQ_ITER_HAS_VTIME,
 };
@@ -10255,13 +10257,24 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it)
 {
 	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+	struct task_struct *p;
 
-	if (!kit->dsq)
+	if (!kit->dsq || (kit->cursor.flags & __SCX_DSQ_ITER_DRAINED))
 		return NULL;
 
 	guard(raw_spinlock_irqsave)(&kit->dsq->lock);
 
-	return nldsq_cursor_next_task(&kit->cursor, kit->dsq);
+	p = nldsq_cursor_next_task(&kit->cursor, kit->dsq);
+	/*
+	 * nldsq_cursor_next_task() unlinks the cursor and starts from the DSQ
+	 * head when it is called again.  The verifier relies on an iterator
+	 * which returned NULL to keep returning NULL (see
+	 * process_iter_next_call()), so remember the drained state.
+	 */
+	if (!p)
+		kit->cursor.flags |= __SCX_DSQ_ITER_DRAINED;
+
+	return p;
 }
 
 /**
-- 
2.56.0

