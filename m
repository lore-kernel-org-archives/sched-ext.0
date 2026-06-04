Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A782E8897;
	Thu,  4 Jun 2026 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538439; cv=none; b=i+7ggs3tPPpsjwLlD62HyMFsSE+vkeTdMHoVpQ6Ht+y9efOu6FuhgNN0dQwdLSZ6EOqPkllqKVJmm796/xnaqMjXNeg08BSiIu9rL1tDGytHkE//MBGuNB03W848O8Szl/Oxq44jLLm7OPXa2Ubsj0Y1Kn8lGFT4JjU/A4pBBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538439; c=relaxed/simple;
	bh=rx1UqVZragIe/pEwO6f+GnTQkx9QEzJcLpsX4Pml5ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFeSVPWoXTmfusR4n39mNYNalpQ1canw/1LGWzY7v5j4t7z+XYcy6EUnbTZuKhFTW0cmF0YrFHpmqK8qiqoQeFu1vhP467doU3aRAcQRyOUxYJXks6Gj5v2GvgKU3YmGwhIhPCuuqB+DFxe8DjB2isAhvZrjYAPXlxuX5VdaQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvBQNT1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvBQNT1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68591F00893;
	Thu,  4 Jun 2026 02:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538438;
	bh=XyN3p9AE8ifBXoGgejvwMDhhEAYoSLl5s6ihd7xkC0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JvBQNT1uQPoAqpeu58M1QyYkN7zJi3D3WdYYTmfJLj679lfZCweTupVYjOCn1ux9/
	 KjTFwFv1IIzGnHEICuLOtjQIBDVHXfjfVpRFMdGd529qIKexEI4+c6WSLHYIpvufT/
	 572ssauWdK8z2buytT6EZ6xD6yNKcdG9zXTLSkzywgKrrEwOck8zLG+yhQ99knjHQD
	 L6HUF+6pLIsh7mh2Y5kFgq1Nz1DtN85sIZ/obgmtgHta4C+XvxGSHcbpPykAilywhv
	 7Z6R9be+uZP8LYp1lc56OhiuOIRxQChrCwvGebpuI6BbpzyzM/AqelzXIc+mVv0VbW
	 zdmBjjHGnmOEQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] sched_ext: Make scx_bpf_kick_cid() return s32
Date: Wed,  3 Jun 2026 16:00:32 -1000
Message-ID: <20260604020032.3536466-5-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604020032.3536466-1-tj@kernel.org>
References: <20260604020032.3536466-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch scx_bpf_kick_cid() from void to s32 so future cap enforcement can
surface failures. cid interface is introduced in this cycle and has no
external users, so the ABI change is safe. Subsequent patches will add
-EPERM returns when the calling sub-sched lacks the required cap on the
target cid.

v2: Return scx_cid_to_cpu()'s errno instead of -EINVAL. (Andrea)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                       | 13 ++++++++-----
 tools/sched_ext/include/scx/common.bpf.h |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 32ebbc351564..62769abb553a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9405,9 +9405,10 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
  * @flags: %SCX_KICK_* flags
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
- * cid-addressed equivalent of scx_bpf_kick_cpu().
+ * cid-addressed equivalent of scx_bpf_kick_cpu(). Return 0 on success,
+ * -errno otherwise.
  */
-__bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
+__bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
 	s32 cpu;
@@ -9415,10 +9416,12 @@ __bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch))
-		return;
+		return -ENODEV;
 	cpu = scx_cid_to_cpu(sch, cid);
-	if (cpu >= 0)
-		scx_kick_cpu(sch, cpu, flags);
+	if (cpu < 0)
+		return cpu;
+	scx_kick_cpu(sch, cpu, flags);
+	return 0;
 }
 
 /**
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 5f715d69cde6..9591a6e778ce 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -105,7 +105,7 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
 s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
 s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
 void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
-void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
+s32 scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
 s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
 s32 scx_bpf_this_cid(void) __ksym __weak;
 struct task_struct *scx_bpf_cid_curr(s32 cid) __ksym __weak;
-- 
2.54.0

