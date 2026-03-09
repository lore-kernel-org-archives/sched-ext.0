Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940B368972;
	Mon,  9 Mar 2026 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773087096; cv=none; b=SRkX2rP9wup8wXliQZNyN7ez9VHyzEH/QkN4FaLQxY1JYsfhQCu2GwEDf3KVmMDyO4rjFJ6nolKcUS3UM9fKLewM5P1ZDiSfrH9RC5HaOUmSl+OdoP0zgdeKYg2kkHoqiX+NANVnlf8IE5AFgnOKcYPL519lgx/x2pfFSONziAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773087096; c=relaxed/simple;
	bh=ellmXv4nIDwSA/6iPioXqr0ZcFvZ7BncbST9RBzoBaU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SBR4ahq7mXKlropUIQXNbIBScpuWBCbNrovX41AIprElzH+i4CGDOcA/W2hqgmFnyocQj/e1K1ZIzN/5hzEbAg/ht/tRfUq2dHMQO+p5CqKBej8OEggSXng4QovBXRCBKuG6ZtoTFYVkGWBC6EP4cvFoxhLZkjzN1MPW6X4OI+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz2AfswH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz2AfswH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ABCC4CEF7;
	Mon,  9 Mar 2026 20:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773087095;
	bh=ellmXv4nIDwSA/6iPioXqr0ZcFvZ7BncbST9RBzoBaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sz2AfswHC0kmebJPvHKs2F5dY4w9nwbYRwHGFt6bXZqc54qw+d7SkxjFF1CMHgSlu
	 +dyFs44ze3HYgaUGKdguE+XXit+4tBwS0R8mGPHpW/QsppT0opqPuaGPLLWLNZb2VL
	 0ZxXaHsIkpgsPXDCYHKj7h0uK6OwlbiM4Ukr8vcl/+Wax1i4zHgI1mt5j2qgGy0U8J
	 T4sifT1KI2mtVuAssuLP2HknaE8K9Z0vuuXsyde0DH38cCM7uF8EvYKbTjDJr7g5eM
	 h/Wjsnon6Jm9XzMySCno0N6Vlu5DN/8UMa7cAA4JnA8wPyB/GxJ1DTdtFlXtFr6EA1
	 qH8ZPgBBdQNaA==
Date: Mon, 09 Mar 2026 10:11:34 -1000
Message-ID: <24708ac607dca437285ffb5aa94c2736@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Mark Brown <broonie@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev
Subject: [PATCH sched_ext/for-7.1] sched_ext: Replace system_unbound_wq with
 system_dfl_wq in scx_kobj_release()
In-Reply-To: <aa8WSH-ILSebstIB@sirena.org.uk>
References: <aa8WSH-ILSebstIB@sirena.org.uk>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

c2a57380df9d ("sched: Replace use of system_unbound_wq with system_dfl_wq")
converted system_unbound_wq usages in ext.c but missed the queue_rcu_work()
call in scx_kobj_release() which was added later by the dynamic scx_sched
allocation conversion. Apply the same conversion.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Marco Crivellari <marco.crivellari@suse.com>
---
Applied to sched_ext/for-7.1.

 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b35b98020f3b..07476355bfd5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4546,7 +4546,7 @@ static void scx_kobj_release(struct kobject *kobj)
 	struct scx_sched *sch = container_of(kobj, struct scx_sched, kobj);

 	INIT_RCU_WORK(&sch->rcu_work, scx_sched_free_rcu_work);
-	queue_rcu_work(system_unbound_wq, &sch->rcu_work);
+	queue_rcu_work(system_dfl_wq, &sch->rcu_work);
 }

 static ssize_t scx_attr_ops_show(struct kobject *kobj,
--
2.53.0

--
tejun
