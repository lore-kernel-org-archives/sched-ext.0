Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E832FB988;
	Mon, 10 Nov 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808207; cv=none; b=EHcvykYSxWhCOZDNwf2NSEEBYsfy5z4ackf+6lbNUwZSjxxnlIZqg7+jmDN4H339+xQMTjG87CtqGVA4tHp+7DPc0Fqr0WwRunpKn8Cv5b5GFunZx8PTsOxbuSj4jw2Bs5+x74tU6itNNYRWV4jAcqso1wiyS6rD/DhHi6EBYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808207; c=relaxed/simple;
	bh=Jv0u3ue0egDnAR0khs+Q2Z6k3C9BNC2Unti4P5wKYV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNzNBNWfWQiWOHfOpY9AQ2d+MIWb1aUeS3TpKLmRqA0u5J5PMcGwjm0G+A4rkY7o6HaMMxUVNBPeAMgzT69SXv/0FjFYO5sgYKMBMlzjETCP1X3xGT4GXUE5Dwf2b4pOkGckI6UMEvzoxI80snWjv8aGt3F6p8fs8oiHicmogEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jguXJPWo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jguXJPWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA68C4CEF5;
	Mon, 10 Nov 2025 20:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808207;
	bh=Jv0u3ue0egDnAR0khs+Q2Z6k3C9BNC2Unti4P5wKYV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jguXJPWoBz7lDPN77Caif4mJ/nrmLqnw/sGUhKvZcUpSX4OpMWdjfWhQzob+M33R5
	 yo4Q/fzn2d/g1X+2AZ3sLgNYEOD/doqsEL5/IC22qLVVkmagYQQ2xA023bkm44ogyV
	 WfUv3xB53sK+nmuZGIItFSdzP/Dz9yI6clIFqSqLOahNTdTEXiCIllWM/0jIvRKGAK
	 vttFDtKrCiForATsPQZ93xBqYZsq4+2DyAHdfXaooh+pt2GlX/tG5JImrogylPisdK
	 QvkRwu/xvAQf2SNdtSNnUMiQwUg64/1kIzrfoZ1VaSozFYdtcnAAd26QN3fjN8qEMH
	 5+EwLbccBvAQA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH v2 09/14] sched_ext: Make handle_lockup() propagate scx_verror() result
Date: Mon, 10 Nov 2025 10:56:31 -1000
Message-ID: <20251110205636.405592-10-tj@kernel.org>
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

handle_lockup() currently calls scx_verror() but ignores its return value,
always returning true when the scheduler is enabled. Make it capture and return
the result from scx_verror(). This prepares for hardlockup handling.

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d9572bf99b5b..566ef100e2be 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3655,6 +3655,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 {
 	struct scx_sched *sch;
 	va_list args;
+	bool ret;
 
 	guard(rcu)();
 
@@ -3666,9 +3667,9 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 	case SCX_ENABLING:
 	case SCX_ENABLED:
 		va_start(args, fmt);
-		scx_verror(sch, fmt, args);
+		ret = scx_verror(sch, fmt, args);
 		va_end(args);
-		return true;
+		return ret;
 	default:
 		return false;
 	}
-- 
2.51.2

