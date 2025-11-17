Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09FA32721C
	for <sched-ext@lists.linux.dev>; Mon, 17 Nov 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384013; cv=none; b=XkgLGedtVsyraad6R5kzPg3zO1ptIGGM8WtaKD8vBYrUkFFv8lpX5GLwRINDDGz/7w5dlNUCHVC47xf4lA7yhkXKvTcqCu2pLa+w+lm7IH80laTosW6AmBUhX0eTWioT1tV3hWDQqqtmjto9grWWW2dTGzvgbrilnUK0drky5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384013; c=relaxed/simple;
	bh=/kpQpvlYJPvcSZkI3pab8KS3SY9zhU/qLB0PelVX3+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JufljHG3igYd6+LjO34dp11GHkI+5/bo8QOFCbgFKEMk5nHqjiHv3uAQP2t6Ud5Il6KoxM+SzDPC/u0tOtZjTp8/xEVgPXj5OPRlQJfDISPZ+6OxLqpE2w5x+0+jX+46EKL9ZZXyOU7hwaTT+PkGv6UUOTa2CJVuw3tB7Kz/amM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iqZ7Q3jk; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iqZ7Q3jk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763384007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAy8cmz2p+czQC2sX+kbLgrJS6zsZipV2vS2Etsh/R4=;
	b=iqZ7Q3jkqAB48fLN0E5wMX84m9374hJhcsTzbUoYZ2pEMK7GmPCtE4/g/kAunlLlhQvY9U
	NBvwRfEsbkWYurJzB1HwaODOR2UT1S8tDaAmZ1ifDMtIrNz3GUfGRYGzFHq/PsSfSFdLn1
	iWtPCRgFwjpH0wWH5k62czrdLnas4UU=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev,
	qiang.zhang1211@gmail.com
Subject: [PATCH] sched_ext: Use kvfree_rcu() to release per-cpu ksyncs object
Date: Mon, 17 Nov 2025 20:53:11 +0800
Message-ID: <20251117125311.107687-2-qiang.zhang@linux.dev>
In-Reply-To: <20251117125311.107687-1-qiang.zhang@linux.dev>
References: <20251117125311.107687-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The free_kick_syncs_rcu() rcu-callback only invoke kvfree() to
release per-cpu ksyncs object, this can use kvfree_rcu() replace
call_rcu() to release per-cpu ksyncs object in the free_kick_syncs().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c8de9ec70d75..fe94daea7889 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4161,13 +4161,6 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 	}
 }
 
-static void free_kick_syncs_rcu(struct rcu_head *rcu)
-{
-	struct scx_kick_syncs *ksyncs = container_of(rcu, struct scx_kick_syncs, rcu);
-
-	kvfree(ksyncs);
-}
-
 static void free_kick_syncs(void)
 {
 	int cpu;
@@ -4178,7 +4171,7 @@ static void free_kick_syncs(void)
 
 		to_free = rcu_replace_pointer(*ksyncs, NULL, true);
 		if (to_free)
-			call_rcu(&to_free->rcu, free_kick_syncs_rcu);
+			kvfree_rcu(to_free, rcu);
 	}
 }
 
-- 
2.48.1

