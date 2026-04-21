Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62D3876A1;
	Tue, 21 Apr 2026 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755990; cv=none; b=aukoXhx5c/P4KzJieoaZuidO3wA6yRCZt7UPOi7/kyqErwZY6dK+8UDnl51sPupo567fuCo2vWJCb2NRBBKJQiRGUSg349/q3PHsTrn48G+EUQ/jy99zSVvSglTF3XA62WpU9MgpdtzSPln2t1Xw2AssGu761tHtgZN93Nu5iG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755990; c=relaxed/simple;
	bh=MkShJCUyIq45d6Oi6fbwc1JW8IOfaARy/GQIe/CSUsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUFbyO/UEqyUqpoUlTFnoFN7NVDhuZCw/RduiG/rIjF/1rJGThpwBt92kCkzHGwvdd1y8O/x6hDFU0zHhwHVNsDkzhltBx/0YlhqX9njtIZ+ZonpiljZXVYqctGsSFdGkY626dNZ1t7ALvI5o5vA+UqmE+iOPWigeB30wKDJZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtt8p80N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtt8p80N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A76C2BCB0;
	Tue, 21 Apr 2026 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755989;
	bh=MkShJCUyIq45d6Oi6fbwc1JW8IOfaARy/GQIe/CSUsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtt8p80NkE2FsODt8jD8pXdH8NEDsm4dHEMlcidMBzKOV8hPOW/pkaFPxiHWr0+Ve
	 Nl0JPyyEAYupFvO1chHfIiM2Mq/fbpuj77VQLkLFYP0QKv80qN5OwGnLzXtIYgh3vE
	 Kjr/dWSpBjppMSkcCpOFQV7AG7ZqdGQTUuMJwxUdpmHZPcNnRH1ZBioLViB7UVaYlV
	 4v+HL1e+KyDlis40RP0CUv1fBeU+04Pgi3fIp5kI6V6NVb7W8Mesep3b246khRxUWO
	 3/xm6KOwGyfl1PtuQfpbsPsfk8yx/JDekCoHcYn9zB/HoQaa6b3pGi4XmkCOQH/XLw
	 yOeuoAG9yaQ8Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/16] sched_ext: Shift scx_kick_cpu() validity check to scx_bpf_kick_cpu()
Date: Mon, 20 Apr 2026 21:19:32 -1000
Message-ID: <20260421071945.3110084-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
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
---
 kernel/sched/ext.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5571f5995dd8..9e802d73f205 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8673,9 +8673,6 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
-	if (!scx_cpu_valid(sch, cpu, NULL))
-		return;
-
 	local_irq_save(irq_flags);
 
 	this_rq = this_rq();
@@ -8738,7 +8735,7 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
 
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
-	if (likely(sch))
+	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
 		scx_kick_cpu(sch, cpu, flags);
 }
 
-- 
2.53.0

