Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7A329365;
	Tue, 11 Nov 2025 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888706; cv=none; b=GtH/6/3VCfM2tCUegb11lU5Gv64aJ6n+MCq1E9lqZ5sdKurw+YPHmt8YQbrWDcr9hqAl258OjL0oreT3kDkIXR5HJBVeGlNvZVn9eyQchq4PBZyoxBHhkTXzTRMB6Lzyct4SpwVCRIOG/3cblC2t3+lpoF+vcsIuPoJ8opSpSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888706; c=relaxed/simple;
	bh=Rj9xU11nUcVVSN7qaa4oqKkyX7BxMlKBKzHBEIwTw9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk4wSjstV8IBVD1+YWiBVtjqdjwLXpU2aCgPxpZIh+YDwlcsm0Ek08zsh/lQ+PCMRxN1K/7lsz8RrcMw0N7hcrMTuHNqDcjE+7sLfdsurQ6fzVWvU6rjQz6CKeM6D8DWSEyykHP22TT6wWME6DEA5TlqSVndffO1b/QLCg6gg34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKLh4E2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKLh4E2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D53C4CEF5;
	Tue, 11 Nov 2025 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888706;
	bh=Rj9xU11nUcVVSN7qaa4oqKkyX7BxMlKBKzHBEIwTw9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKLh4E2WYArmVhTfPk8MPgObNraa65Z1gajI5fNIPpulte3KXHP4ekNDr7QhnaO80
	 ijeygqPrzP7BxRWWeSXSA5MG8LEvmrJ8wysRU2lxRLsm5obCY6qCr1Rb4j/Qdo2wlU
	 gKqUZC7lLXLBNaHGhd2dK8Bkabb0tLYnSlI+q1GYXSaq8TyFmYqo3Nz9u+AVhCivLM
	 qDxM1Dg4+/vgoLD2Ih/UfUiNO2L1jC1FyUUr2vCmGxtvX/AKszGk3a5qessV9NlBVw
	 onT4kMB/ZUOTX1z/iGSNTmy3M/nLUNZpgVqX+BSajshcLLLhTULfMId6eOWO1q+mQ2
	 TCmPY4Gisbotw==
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
Subject: [PATCH 08/13] sched_ext: Make handle_lockup() propagate scx_verror() result
Date: Tue, 11 Nov 2025 09:18:11 -1000
Message-ID: <20251111191816.862797-9-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
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
index ad5d3902e99d..85bb052459ec 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3659,6 +3659,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 {
 	struct scx_sched *sch;
 	va_list args;
+	bool ret;
 
 	guard(rcu)();
 
@@ -3670,9 +3671,9 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
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

