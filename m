Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726A2F998A
	for <sched-ext@lists.linux.dev>; Tue,  2 Sep 2025 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811558; cv=none; b=h8mGyR+sHqqKzdRbMhhes1su1h+eqJzvJ9C/pWGfDnlJUT3tpMgWtbHluyxp4OGjxjzAjbps27Q5yaneLl21E1UmzYTyyD+BEQqf4o3MC6E4GrBc28IddUjwU1NyIGM/p5pzrvmZ/blyycsEAtx3V1xftPviZota8KQTqSX3/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811558; c=relaxed/simple;
	bh=HeAfnYSkym3pLzxcCJnakQvgZjHhtodKrDBX05p5vpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fb8J3WIxIkF+6PAOAtRqxhEyt7P118D/ZIbc29sNytrCINNYeBhJsPhZfohqoSy/ge6aUv96UzynC4xi3cIMWs7QSaI6b2b3J6mf5TPG66wuaPDxzV/QhYdav4Jt32PZ+ejp+I+VFuNXHmCNdakrzUNL+bsygiRucewmzCGZO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C43AF2A2A;
	Tue,  2 Sep 2025 04:12:27 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.90.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B92773F694;
	Tue,  2 Sep 2025 04:12:33 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: tj@kernel.org,
	arighi@nvidia.com,
	void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	changwoo@igalia.com,
	hodgesd@meta.com,
	mingo@redhat.com,
	peterz@infradead.org,
	jake@hillion.co.uk,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v6 3/3] sched_ext: deprecation warn for scx_bpf_cpu_rq()
Date: Tue,  2 Sep 2025 12:11:43 +0100
Message-Id: <20250902111143.2667154-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902111143.2667154-1-christian.loehle@arm.com>
References: <20250902111143.2667154-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cpu_rq() works on an unlocked rq which generally isn't safe.
For the common use-cases scx_bpf_cpu_rq_locked() and
scx_bpf_remote_curr() work, so add a deprecation warning
to scx_bpf_cpu_rq() so it can eventually be removed.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index dc141144bfd6..987c7dc38545 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7427,6 +7427,9 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	if (!kf_cpu_valid(cpu, NULL))
 		return NULL;
 
+	pr_warn_once("%s() is deprecated; use scx_bpf_cpu_rq_locked() when holding rq lock "
+		     "or scx_bpf_remote_curr() to read remote curr safely.\n", __func__);
+
 	return cpu_rq(cpu);
 }
 
-- 
2.34.1

