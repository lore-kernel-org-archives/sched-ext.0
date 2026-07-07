Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BB18A6A8;
	Tue,  7 Jul 2026 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383160; cv=none; b=OXiB5EJDBJbdo6y4G7nYkjpHu+kzWBWI69BjIBJX4sqitxxR96/Xj/DIjd/ZF4rpJICNCj9acKYm6s9d3K92uA2hvlxpn6uekKyeXHoYEPunFVVbOJQ11KTvv4x4RK+EzhHwJkjXrTbeVY2wE3/C2lSTQ1WZ8x6DErEmWGgS5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383160; c=relaxed/simple;
	bh=tWSAn+gLPo6QyRKRat7UuxhjP0IUgtl7TOesjwpq0FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOCVPUhv/h3NHcQ3u9QgDw1vgRkTH5UPU7JoezI2saVE2mgBJmQwpfEg9KN5r2oSCdDof6HIirRSJp7ta+kG3dfR02k20NDrwlENkbHtdDaGdaLj37L/76Rd0IskC+QA+4VzIw4O5nUfs0bViMtr+Ne092ydTNmgDnYOG87CF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgJjOrSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgJjOrSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126471F00A3A;
	Tue,  7 Jul 2026 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383158;
	bh=eHrouy5BCa2Pc/7gOfuw+oBzpZi8n1ia45HjwfR/J0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bgJjOrSFHP4djfGTbGrnsilDLc0M/NcXgxO/aSbA3hGfffiKf73J8FFYILtv0WwEu
	 ++sZPloMyk586Sfuk8oFBAcHRs31kkZ2bCg+zKiQqEl3cIyuoBJrfawtf8LsWhpq9y
	 jq0GPggANOl4X7OImNyBfVrFEYhizYm5Xi464IKW0f8SZtHPuGqyhMaG68gm6SxhMv
	 tVB0nuKry3QPEMzfis4pboAJP+KCGRlJ+uyx1rFbpO5Wa3z6pyM15aN1gXAYht8N91
	 1vYW9PgEzwwLC5CCrMNvHNq56g3dB+fl5vLbmfXWdCuU3ldxJuRSf4pGd+uHYT49Tn
	 GQdIaIPqPetsQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.3 08/36] sched_ext: Make scx_bpf_kick_cid() return void
Date: Mon,  6 Jul 2026 14:12:01 -1000
Message-ID: <20260707001229.1410929-9-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707001229.1410929-1-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_kick_cid() returned an error code, but the value conveys nothing
actionable and no caller consumes it. The kick is asynchronous, so a
successful return only means it was queued. An invalid @cid is already
reported through scx_error() by scx_cid_to_cpu(), and a missing scheduler
leaves nothing to kick.

Make scx_bpf_kick_cid() return void to match scx_bpf_kick_cpu(). The
cid-form kfuncs are not in practical use yet, so the ABI change is safe.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c                   | 11 +++++------
 tools/sched_ext/include/scx/common.bpf.h |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index bd3cb59b1dbf..187754d0c3c8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8533,10 +8533,10 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
  * @flags: %SCX_KICK_* flags
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
- * cid-addressed equivalent of scx_bpf_kick_cpu(). Return 0 on success,
- * -errno otherwise.
+ * cid-addressed equivalent of scx_bpf_kick_cpu(). An invalid @cid aborts the
+ * scheduler via scx_cid_to_cpu().
  */
-__bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
+__bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
 	s32 cpu;
@@ -8544,12 +8544,11 @@ __bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch))
-		return -ENODEV;
+		return;
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
-		return cpu;
+		return;
 	scx_kick_cpu(sch, cpu, flags);
-	return 0;
 }
 
 /**
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index bd51986c4c42..e7b3ba491c5e 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -104,7 +104,7 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
 s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
 s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
 void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
-s32 scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
+void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
 s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
 s32 scx_bpf_this_cid(void) __ksym __weak;
 struct task_struct *scx_bpf_cid_curr(s32 cid) __ksym __weak;
-- 
2.54.0

