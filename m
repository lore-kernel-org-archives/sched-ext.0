Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30732F60C0;
	Mon, 10 Nov 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808198; cv=none; b=TBqWDEDC3qKHvMZTd1yiOv3qjo+HcgZ7GK8DkfqzddFV+xyPa5ZHfl7Vi0oztmDLpkNLDdMb0d5iyOLmLZWpD1YffwcuW2NAt0pVP1716Xvs72fVO9A1IhaS2PW9REPdSs5TNUfcSgyTVTj/qyD1vzJphdc6V0CMGuvHK04r6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808198; c=relaxed/simple;
	bh=H5PKEBoHV3HMMxx7TTlepJ6CAJEwkpwJkeXhwF2qtRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAQCdAzlRcoBYgtBBNKzn5Hxrl6Y6HwOELBeDJobmFZ2aIQ+DRWqkoyQ/Iq/A/K5NJeOC1d5l9ejx8xKf2yube0ucKOPpFf117N+cplbYyOfaTz1rS7GTKnsGDkXjmi/n2UrkJ0NBk4X5/HDyRtf9EIm8klUTxFOCTxOo/mA5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKeG5noB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKeG5noB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F89DC116B1;
	Mon, 10 Nov 2025 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808198;
	bh=H5PKEBoHV3HMMxx7TTlepJ6CAJEwkpwJkeXhwF2qtRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKeG5noBM/BRny02DEbXnzQHt1Cd6fGY+pEaOcoZ9JTEQa/8lnNk0UduTrTc9uXiP
	 c65Xk72zSK3li/Cz51amqJyvObyjyc1kj/b+7FICaODesbyg6avKYCDAUaxIqSANG5
	 JnBtJxMPkjt02geJsYhzYF6XByhKpu8gGrl/0meh9Fretd8l26EpWiRFYGw5rdttVb
	 lWCM4Lk9HxBYo6aqILLXKp55WQ06Qut9ks1wbV9XiPlXXNa70NF58ude9q2UEJ72AK
	 sjcli5YExmV2BEbRN76+nxqtCgJYvbuzd0DqaAekBnNsgZWB1Duapceu90B66yB8a+
	 idRyy6fU51VBA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 01/14] sched_ext: Don't set ddsp_dsq_id during select_cpu in bypass mode
Date: Mon, 10 Nov 2025 10:56:23 -1000
Message-ID: <20251110205636.405592-2-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110205636.405592-1-tj@kernel.org>
References: <20251110205636.405592-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the default CPU selection path used during bypass mode, select_task_rq_scx()
sets p->scx.ddsp_dsq_id to SCX_DSQ_LOCAL to emulate direct dispatch. However,
do_enqueue_task() ignores ddsp_dsq_id in bypass mode and queues to the global
DSQ instead, rendering the setting unnecessary.

Don't set ddsp_dsq_id from bypass. Just return the selected CPU, which has the
effect of waking up the picked idle CPU. Later patches will implement per-CPU
bypass DSQs to resolve this issue in a more proper way.

v2: Removed incorrect bug fix claim about dangling ddsp_dsq_id triggering
    WARN_ON_ONCE(). dispatch_enqueue() always clears ddsp_dsq_id even in bypass
    mode (Andrea).

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <andrea.righi@linux.dev>
---
 kernel/sched/ext.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 652a364e9e4c..cf8d86a2585c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2521,12 +2521,8 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		s32 cpu;
 
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, NULL, 0);
-		if (cpu >= 0) {
-			refill_task_slice_dfl(sch, p);
-			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
-		} else {
+		if (cpu < 0)
 			cpu = prev_cpu;
-		}
 		p->scx.selected_cpu = cpu;
 
 		if (rq_bypass)
-- 
2.51.2

