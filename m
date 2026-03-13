Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E053148BF;
	Fri, 13 Mar 2026 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401477; cv=none; b=rQ1Z59NRbjL3Vm70BwEuh5VdAVPnrakma3bCXV/6fhsZvWiNLgigDniWdsM3Sk3UXzo7Eb3EOEYzlOww8RbiXc7v97vd/5cPet9bNl3r0hSsorwDJwyUyFyg6VAOHEQMLRgBO731P1XlSpKfFSlIlovqfVDxe74sZnUiDdq1tS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401477; c=relaxed/simple;
	bh=d00ENr/6/B9yDaHyi1wNImA7rrKgIvC5apvkeOazA9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5H2+sKGblLuuGOnO4mwFqCBoNkmR0G/weifmsEvvhIr1fpMieLT3bnWh81ROQIiwPQdoNglE8ZNlpVnIptyPORoSrBUlvuK+306O4UuyAYJ9iNh+iNxQqtOser2DMUWEKMmvTlQUo51WANbmzGJdH0fuMXs6EkZJ+VktYIabdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVFIGU8M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVFIGU8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65371C19421;
	Fri, 13 Mar 2026 11:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401477;
	bh=d00ENr/6/B9yDaHyi1wNImA7rrKgIvC5apvkeOazA9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVFIGU8MBqgeNuy2h6IqWyM+wVFqllw8S8q9wXrgU5qFIuGwOpT19Nw/f5EpJ6v9+
	 tcByuFpLakXztdN5IlE/5Q7AYNzbf2rEvxGxLWj8CJt5T90f/Ay+2IvTCCppuPNWte
	 39XvWDg1eA5ZB2KwF5646D0clZnjXsjMClGws4h3+aX/Y6MwX2HhGwOp/UOU22zJ3i
	 hpFlrC3ZODStpkPut+EKkBqMZ26XfiAMYq52qRs83m9AQQNswavHkv8MYxv4kCMwc0
	 uk8DNRZpczv+DfTtjruaxwLMkDEAkamIz8E7bF2U/ggQPwd/3WjON0nO1NZuh1MM6S
	 KEQF7s+4YOGXg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] sched_ext: Add scx_vet_enq_flags() and plumb dsq_id into preamble
Date: Fri, 13 Mar 2026 01:31:10 -1000
Message-ID: <20260313113114.1591010-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313113114.1591010-1-tj@kernel.org>
References: <20260313113114.1591010-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add scx_vet_enq_flags() stub and call it from scx_dsq_insert_preamble() and
scx_dsq_move(). Pass dsq_id into preamble so the vetting function can
validate flag and DSQ combinations.

No functional change. This prepares for SCX_ENQ_IMMED which will populate the
vetting function.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 774c012831e6..2f59265b9b57 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7530,8 +7530,13 @@ void __init init_sched_ext_class(void)
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
+static bool scx_vet_enq_flags(struct scx_sched *sch, u64 dsq_id, u64 enq_flags)
+{
+	return true;
+}
+
 static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p,
-				    u64 enq_flags)
+				    u64 dsq_id, u64 enq_flags)
 {
 	if (!scx_kf_allowed(sch, SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
 		return false;
@@ -7554,6 +7559,9 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 		return false;
 	}
 
+	if (!scx_vet_enq_flags(sch, dsq_id, enq_flags))
+		return false;
+
 	return true;
 }
 
@@ -7635,7 +7643,7 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 	if (unlikely(!sch))
 		return false;
 
-	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
+	if (!scx_dsq_insert_preamble(sch, p, dsq_id, enq_flags))
 		return false;
 
 	if (slice)
@@ -7661,7 +7669,7 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id,
 static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 				 u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags)
 {
-	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
+	if (!scx_dsq_insert_preamble(sch, p, dsq_id, enq_flags))
 		return false;
 
 	if (slice)
@@ -7788,6 +7796,9 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
+	if (!scx_vet_enq_flags(sch, dsq_id, enq_flags))
+		return false;
+
 	/*
 	 * If the BPF scheduler keeps calling this function repeatedly, it can
 	 * cause similar live-lock conditions as consume_dispatch_q().
-- 
2.53.0

