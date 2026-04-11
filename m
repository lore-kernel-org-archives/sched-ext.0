Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FA313AA2F;
	Sat, 11 Apr 2026 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907238; cv=none; b=g176WK24e+W3nMeKJK0KDVHVRbGe1kxbPOhBYmfZuGGJ6yI9Z6LLEpf2FqG4Z6KLT1xLHwcrL6JZ7JBRgnqlVSWr5kBolJvrQTFRUKMZBKiw7Ipw0275EHvigVlVwXEWcdcKWkswifMXIxkl2nDoriXzdBXeNCK8VCW4VsEoVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907238; c=relaxed/simple;
	bh=Zm8WEHCFfrppW0HJIYCmNmWAob/4nlad/NDUog5TX9U=;
	h=Date:Message-ID:From:To:Cc:Subject; b=HGhbc11igt8rvsPHo2vKQ07pV+XzmkZaPnvM2w8goWPB2Ld4/ZLM7RfiEbZudo2MjPRzGwZeCSlKq2NBx/e3sqr4E82dGFfP6J7NfUbRkLFU7M/nwDy/2ZcO7uMXHqCs8077nJ1+0IH1CnLg6GNTRhwa89tbgDK2YM/sQoshkRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3PyyWiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3PyyWiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E05C4CEF7;
	Sat, 11 Apr 2026 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775907237;
	bh=Zm8WEHCFfrppW0HJIYCmNmWAob/4nlad/NDUog5TX9U=;
	h=Date:From:To:Cc:Subject:From;
	b=G3PyyWiUbNzVZAcKVOAmK0inL49geX+ktcYKCF3uIJWXbWIp973l+tU6sDzBtgxiI
	 0iVIMHx+TN2oXh4+hw5Nt/lieWLy7geOzxrvbwMC0KmDqf/oU13bAKCN7iw2q4SzNH
	 4HIDWrVN+zlqPQuAOnTa0nPKY3B8zR6e/jIKClmWWZ5c5P3UC6bl+IlKio79/5Bj/t
	 adXx3S97gzSElW+lDS9+q0g4X0k6Vn4TA4WH5A0GBELKXX3/DRkSRWraSnX/L3+edE
	 Z3YJAn1xfwPXb544qElgKeV3jXg4zrdOF1tAgnjfKaSSgr8qJu7RR4SzfgAXYwz7Xj
	 zUEpMNwJ0ucNQ==
Date: Sat, 11 Apr 2026 01:33:56 -1000
Message-ID: <de52a1c5537e2a130d19eb244b7606c1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1] tools/sched_ext: Kick idle CPU for
 pinned tasks in scx_qmap
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_qmap uses global BPF queue maps for task dispatch. A task pinned to a
single CPU can only be dispatched by its home CPU's ops.dispatch(), but an
idle CPU won't call ops.dispatch() on its own. This leaves per-CPU kthreads
like ksoftirqd stranded, causing NOHZ tick-stop warnings from pending
softirqs.

Kick the target CPU with SCX_KICK_IDLE when enqueueing a pinned task.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index f3587fb709c9..09d1624fb869 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -314,6 +314,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		__sync_fetch_and_add(&nr_highpri_queued, 1);
 	}
 	__sync_fetch_and_add(&nr_enqueued, 1);
+
+	/*
+	 * Kick idle target CPU for pinned tasks. Without this, the CPU can
+	 * idle while ksoftirqd is pending in the BPF queue, triggering NOHZ
+	 * tick-stop warnings.
+	 */
+	if (p->nr_cpus_allowed == 1)
+		scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
 }

 /*
--
2.53.0
