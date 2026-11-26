Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728814;
	b=i2OXTJH/2mDDPQpKpTG/MUQIndtYV8psdNJx7ej1/nYw4ftScPFLz016O8llwBTYNMaC
	 h+KEBT9ShBrs6T44M9tGDx+O1pivcPMmVFZt3RoivlWUL5Eo3zGMQKUIGe2hAcm2XwlzG
	 YLk0q5c1x5quu4xrkR3E1wwESMg3kEC8mfF1Ia+J9Vl5TCPX9sK47d3Qu0+1KBSNa406G
	 ZGqi4ik8wh+hqF1wkDqqZTvQJZq3aoE2k3WEAuGNyIO4bnbeQDgsjdVqhEVz/YSduSDUY
	 SXv3vHkcm2SxOv2/W2PoYQipN+egB0bW63aPF7f4Ps1QgB49tJke6shB7N5NTAKnuhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=TJRJZjUyvgZocQAnVjrGig3CO3gFOqtMC5DjldN85x0=;
	b=Um0qXKEb5XPEm6dndAsU/I9ZKjP6Di7jhOeOMXM7Xx+mZgVPMW6fC4nUqwt+kDSL6AY4
	 SoSUANHhUbgU8VWwGdHGoGe5O9ujlI0k/OcmbiZw0ApxnebYkjKsanzDjH541FBZUxlWm
	 ESBT0fUfUTFaaQMEKdQSkuyOB0MEMCMUPKs6waIkg7TlY7nVi+uJLgrLEJJo8JFWmUh90
	 e9bPAoy+sseIarDxuw3XnU/s7CidTo0IydresTWLyWa/jpO8DWZragmbSEbUSmK1VUSfY
	 iS/qz+cT462rnF6BW/syYmiZIZDvd42YLE/7QrOTqJGfhhAz3jd8jZLy467Kzieb3tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J7BAEjqM;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4A606A32A
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 21:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE4A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J7BAEjqM
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso52085665e9.0
        for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 13:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795728812; x=1796333612; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TJRJZjUyvgZocQAnVjrGig3CO3gFOqtMC5DjldN85x0=;
        b=J7BAEjqM2wr8OhQDlk+vV8WuuXuC3AEL47tPOlHQu9pB1asKJI+oeAGa+1IMNIRXaJ
         tkhu0Kb4mE1Ihfp8H0WqJxGFUB5zU4FmPn/Z0Q/gj9DGw6/WcaS2/l1NW38EOMBTP9De
         Aef7nLTQ5WEA5AKtWwxoWiGqBH9nlTmn8Wom/MBBhiuAGHbVR2iBjkFiS5KrObUUzG9v
         w717mUQvQn6z+4mVn2OAg1+O2vFpnkMdJN+U6PzlO9DxXJuanpz03qT3XhT8ov2byucX
         KKbfA/VdqAGvhpDm65F3tJBboVd9z+XQUfQbNDM9tLmDyP27TU53vClsT1Vd+AaYkbKs
         0wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728812; x=1796333612;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJRJZjUyvgZocQAnVjrGig3CO3gFOqtMC5DjldN85x0=;
        b=r7E8DStGr1xhWyhHJws7k7Dnd75N5BvOyEUQKqiM0k0WXcGwq3l/HS0p5cNu2zsfI9
         xNuXyX+swY0jNaakG+m4AHohN6HDZ5WScFqj4Hc1tPcbJn9R9T0yx/Nxm27OHTH4ULU9
         scggYjM1IMNk89X6jsjGa5kwlEy3sbT+i4ERXO2LK045MNOaNhEASdseByF3KE4C2cI0
         swUF5rc4EktDe2T9rsb693+4iH7H/TLFhz3kzeU58GxGx1x1bSDu55tzOaPlmPD0zd3U
         wipeWnpRHGjSjgJ64dWuyS57aFCmOm+iQBalkrhGsuJnu2fx0N2vVS4RRVsCwUceoIzF
         jMSA==
X-Forwarded-Encrypted: i=1; AL+hErGMkhcPRAgp0pNHcsp34X8Nfg9GaJinGWZB6cNHTdxTHirmRJKJGRK3aqlN1XVXBxYq2OfSFJa3tEE=@lists.linux.dev
X-Gm-Message-State: APuU4Z/kDaQqZKyDsEUl0WkGJqmcLD3YGZqenJ1tHyU3RnHS4WBSjkAH
	H0vJur2DoNvu67eWZjOVU+yi4NvhWfNEn9BfY+16RRv/hwVE0TjYFuzWhNOaHqPy5SpmF1nYUqM
	a7PRL0urdkzR+lw==
X-Received: from wmsd6.prod.google.com ([2002:a05:600c:3ac6:b0:4a1:fdd5:9c10])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e0b:b0:4bb:6f45:2a79 with SMTP id 5b1f17b1804b1-4bb88817920mr480195685e9.22.1795728812035;
 Thu, 26 Nov 2026 13:33:32 -0800 (PST)
Date: Thu, 26 Nov 2026 21:33:29 +0000
In-Reply-To: <20261126213212.3930589-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261126213212.3930589-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126213212.3930589-2-jpiecuch@google.com>
Subject: [PATCH 1/2] sched_ext: Enforce SCX_CAP_BASE in core-sched task selection
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Under CONFIG_EXT_SUB_SCHED, a sub-scheduler is only allowed to run tasks
on CPUs where it holds SCX_CAP_BASE (apart from migration-disabled tasks
and a task admitted as rq->scx.rescue.curr). The sched_ext dispatch path
enforces this via scx_task_can_stay_on_cpu() and scx_rescuee().

However, ext_sched_class leaves .task_is_throttled NULL. Under
CONFIG_SCHED_CORE, pick_next_task() calls sched_core_find() on sibling
runqueues and sched_core_balance() calls try_steal_cookie() across CPUs,
both of which select directly from rq->core_tree and rely on
sched_task_is_throttled() to filter ineligible tasks before bypassing
pick_task_scx(). With .task_is_throttled unset, a sub-scheduler task
sharing a core-scheduling cookie with a sibling can be picked by
sched_core_find() or stolen by try_steal_cookie() onto a CPU where its
sub-scheduler lacks SCX_CAP_BASE, running without ops.dispatch() and
bypassing sub-scheduler CPU isolation.

Implement task_is_throttled_scx() under CONFIG_SCHED_CORE, returning true
when !scx_task_can_stay_on_cpu(rq, p) && p != scx_rescuee(rq), and wire
it to ext_sched_class.task_is_throttled. Both callers hold cpu_rq(cpu)'s
lock, and scx_task_can_stay_on_cpu() already fast-paths !scx_has_subs()
(and CONFIG_EXT_SUB_SCHED=n), allows local migration-disabled tasks, and
resolves bypass via scx_exec_sched().

Fixes: 46a85ae6fe5b ("sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3a69100e47f7..a4a93ed97f7b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4261,6 +4261,13 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 	return time_after(a->scx.runnable_at, b->scx.runnable_at);
 }
+
+static int task_is_throttled_scx(struct task_struct *p, int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	return !scx_task_can_stay_on_cpu(rq, p) && p != scx_rescuee(rq);
+}
 #endif	/* CONFIG_SCHED_CORE */
 
 static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flags)
@@ -5959,6 +5966,10 @@ DEFINE_SCHED_CLASS(ext) = {
 
 	.update_curr		= update_curr_scx,
 
+#ifdef CONFIG_SCHED_CORE
+	.task_is_throttled	= task_is_throttled_scx,
+#endif
+
 #ifdef CONFIG_UCLAMP_TASK
 	.uclamp_enabled		= 1,
 #endif
-- 
2.56.1.839.g22a8290db9-goog

