Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134837AA95;
	Fri,  3 Jul 2026 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065727; cv=none; b=btLEyhxTvhw0ClyyKh7bkUU8wFBiVoghZX6/0DSoO42hKkLJ+L9coVIhYCp9VQovSjF2AjnSvVcJ9SsMbY9mqV6PwDhgPkxpppaIuRZ/bVBfjFDHYroj3v1mEpkhFaOxX+U6DtfjJpg4Hoy7M19bvYoqVT1WEpV60K7nDtXl1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065727; c=relaxed/simple;
	bh=3Oz3aIulZ4KaWjzaL+aqvmdNxvUxfT1JVkpC3mtEMU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irBEtfGfSPnqwSsR+wgFc9qAgVSQY+gF6PjINU7ELaC+vaxhp3iGbGdcpYUFqdqaSjKrSgwhmleQrjXKyQbF0Zde2IcWq+G9ppIK6WXR4vlnokxO8m+UrCkzUbHf4oP96VqGK31iiZDkmI9FxmuSAe57TzIsXV7PqGeSqlF831w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbzROl8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbzROl8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB251F00A3D;
	Fri,  3 Jul 2026 08:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065726;
	bh=bLm0WvuGyFKu9syPryGfrrs0Slq4TVwNlSkZZUkv1uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SbzROl8w1ny4S9u9W9ZwL7bVWzaCzNak4gfdUqdgThF4wfylbyoy/7js7t/Ks/MPa
	 4MLh7swoL3mlnN4kqihuvNL7JtMJDnp0uKysNzjED1KxlK5bF8cHD8W0gbK74HzNz3
	 EgyRCI+rOIN0Rxyav8NRcbuB2wmxz/pQb+wTxDod2igg6iQJtKHz9yUXAC8ShoYipm
	 0E/XwyBnLbRwxGcQ9nXqSzyJ4fhYMKpYzEAz88vzWGqS+TPIMY2GTe7SpBw8io56lz
	 aCTrCpdY+GI9sxp8fUCizKvNjk5bkbfKR1PwlylB2BOMPQ8yEJzgpYXOj5SZutrtYM
	 MMaktct3jzIow==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 06/32] sched_ext: Make scx_bpf_kick_cid() return void
Date: Thu,  2 Jul 2026 22:01:33 -1000
Message-ID: <20260703080159.2314350-7-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
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
index 4a93ed72e5aa..13af43bca850 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8541,10 +8541,10 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
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
@@ -8552,12 +8552,11 @@ __bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *
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

