Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD874218AE;
	Wed, 29 Apr 2026 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486897; cv=none; b=r/J3nQJMELOSW/NPkGX+x5b64fEeS0MvWGWD7NWJ6RvcsJZKIHPGjVBElAKlGRvRTTq8LqaMid97Bmr0vDTklUyyHVImyhYW0VuZf6HsTev/trBbw/QFU4zMj1xS5Wx9Jo08rwzcv/YOBiDpS4TkpJDbIuLuehg/24sPptaA4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486897; c=relaxed/simple;
	bh=qj/dM9+W0wo4bu9wodRS887+hPm2hlPuF0+XSPinJus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAYx8lxFfn49dA/VmeU5JRyfYMVdPM3wpIYc2Ushy8h/Ctwwm/10TymlfQamAMTGOcvTDZlxNznS3H5KoV9/hVJ5x3nHnFtG2DuuHrwESqcuYws1TgqRRkfyaNpQ0I+XUj/04UwVclXriU+ZZUt3umuObQALiTriNuRHLczDU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cil7i87N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cil7i87N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D86DC2BCC6;
	Wed, 29 Apr 2026 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486897;
	bh=qj/dM9+W0wo4bu9wodRS887+hPm2hlPuF0+XSPinJus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cil7i87NIf2FthajGyxvODxETV158N5VsAAQlcwtT3Ufrhp1otzyWuTX4fKFfXR8A
	 R81u2B/mTBOhsa0bF4eJsL+gYbGrMyIedYqXvxS2wVkkKY/kJ5tNfmdAD6A0x9OVzV
	 8fMivRevFt9uhht/xKdvVKJnAETVSWwasF3gvvdm6QsrSaf5XW+qEaPpzhguPMq3WQ
	 Kwm++lpU9z1mF3Q3ZuhE3HhyyA9tUJ5ozS2j3pL1EzoZ49raoTi6wr+zYhLSZj97nw
	 ogldX7rklvrZ5S+4+bwjSL71Py+SnDY3+7ur/2E9omNhJUeUIsXKCUFaBmIN/lsyCE
	 NaJk1JOoCPyng==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 04/17] sched_ext: Shift scx_kick_cpu() validity check to scx_bpf_kick_cpu()
Date: Wed, 29 Apr 2026 08:21:18 -1000
Message-ID: <20260429182131.1780125-5-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers that already know the cpu is valid shouldn't have to pay for a
redundant check. scx_kick_cpu() is called from the in-kernel balance loop
break-out path with the current cpu (trivially valid) and from
scx_bpf_kick_cpu() with a BPF-supplied cpu that does need validation. Move
the check out of scx_kick_cpu() into scx_bpf_kick_cpu() so the backend is
reusable by callers that have already validated.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2f16dc2b814b..6575b52f4b9d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8812,9 +8812,6 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
-	if (!scx_cpu_valid(sch, cpu, NULL))
-		return;
-
 	local_irq_save(irq_flags);
 
 	this_rq = this_rq();
@@ -8877,7 +8874,7 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
 
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
-	if (likely(sch))
+	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
 		scx_kick_cpu(sch, cpu, flags);
 }
 
-- 
2.54.0

