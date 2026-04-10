Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB609261B92;
	Fri, 10 Apr 2026 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852456; cv=none; b=Vqkmwdlg9WUHvQ0vnq0EH8Dh6asMNTv7L00uo4BIVKgJ3TUxwF2g0p46MaSjymJbRzxpkXIuDvYKhdXC+3yUQfeCzo+zxASZ1LHEUBPqDDFP9oVTJ9nwUtxyMlz0f38fdiLJ60lXIltg3dzH2NbZi4b9sVSh5Wi8Rr1dwhzZhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852456; c=relaxed/simple;
	bh=aX4RP9fPI+0YLX4MqpbJZL3XfC1j88hD+JnUuLCOxPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmK9jqBxT35pEhZCgtrhuSTnIRzCHfgGl7XGF6ORMvGW/DFXRB53NLxtEy/i1y3a2sPoQplAk7Cr36MTs+iMR7Q/ZW6KJqdjUYz4hf+QMX0KQwl7Ej3FeG88tHmjEB/OC0If7TG0vUn3dmPDiu7gc23YCZJnDts4boDo7xNo1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVk/O9vZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVk/O9vZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81426C19421;
	Fri, 10 Apr 2026 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775852455;
	bh=aX4RP9fPI+0YLX4MqpbJZL3XfC1j88hD+JnUuLCOxPk=;
	h=From:To:Cc:Subject:Date:From;
	b=qVk/O9vZUy58KsuoYO6A6y5WXQqW7GZpP8/hkGu1azXUxvm4xp9X9KKUdsYNv8prC
	 ChRpFyzsQu5ucdnJhmszOr8leIEA8twDCRmMO2EgsKl2+TO5kzyU04Zhlrxrsi7Kjj
	 RifMHx6Q1uzr07nwp+08q6ErwKeuHSq2mvJNa/N4oytxZze+7fexxHpaiXHy3J2SzI
	 GGqSpSqOx1fCL5SGqRqxksBr8GfSEqkY21dK7Uicp7uKCV0QWVcLPIAnb+ykcGOhaW
	 Q0HkUtl+p8c0e/AC+MHfcV8fmBE08OHWYm8lj698sBJ713OFkisiOwD6TmAOvzWIaO
	 f9e8yv/6k80yQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.1] sched_ext: Drop spurious warning on kick during scheduler disable
Date: Fri, 10 Apr 2026 10:20:54 -1000
Message-ID: <20260410202054.4189994-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kick_cpus_irq_workfn() warns when scx_kick_syncs is NULL, but this can
legitimately happen when a BPF timer or other kick source races with
free_kick_syncs() during scheduler disable. Drop the pr_warn_once() and
add a comment explaining the race.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b8dbae251fd5..012ca8bd70fb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7600,10 +7600,9 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 	unsigned long *ksyncs;
 	s32 cpu;

-	if (unlikely(!ksyncs_pcpu)) {
-		pr_warn_once("kick_cpus_irq_workfn() called with NULL scx_kick_syncs");
+	/* can race with free_kick_syncs() during scheduler disable */
+	if (unlikely(!ksyncs_pcpu))
 		return;
-	}

 	ksyncs = rcu_dereference_bh(ksyncs_pcpu)->syncs;

--
2.53.0

