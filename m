Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9133E0C59;
	Fri, 10 Apr 2026 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843512; cv=none; b=b0jHMNAOpbgdf7Z5hWzsKIJ8ExHdyiJqMpWGvj27nGeFuoKjdk6RY9YwJsdBdsGmc1tdBHW/pJyu8fx/GcN7wyWcXLz0XOopqL/uurrC8xZNAdzprTWP3ed6JTTRvHzlvO1fqNJPQ193s0S2pZolvARjLMhhJSnz6JYjt2myX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843512; c=relaxed/simple;
	bh=HIkdyNvrGk02oKOPbZLR3HkxryjVNurQWm8vL5ddT4s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=LwNi6W0bTd/JGzgeLWdLSy4/Xn7bv53fYZ+aTHwaSSXDLUHx2pp0hhGM1MHptd7SXUh9pw6eOF7uoEItzKzHqASufwPRWxq1oGjFnNWgJQbCsiXVmnS3qJncOjuVWPcheXDDjm7tuQgWl306KKlwN211hhGalZPvP8fw6jZ7z4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJwEtVGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJwEtVGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD327C19424;
	Fri, 10 Apr 2026 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775843511;
	bh=HIkdyNvrGk02oKOPbZLR3HkxryjVNurQWm8vL5ddT4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hJwEtVGn4M2pC84ZrO5etUF/YumMx1FbRF3wP58oL7wucyMiwcP0I3CZeG9vv57NL
	 71YygxfX58Pmvi/qSe0tqE6LYCVViiMt7IP8Rrs5OeN5bT/STn+WgbsrDPQzy5TR5n
	 BMyG3HZcRgQKaJzpn8Lc6HB8J5aUmzaVuqfwWZGHCNmrk5L+0BZdJ9Wi48OGbtmWlQ
	 6YOHFbvQLy0cjcnS8MK9KXXNBnKE2m9k342JGslAITEYq4hThb4Sz+flnvlkvnxaG0
	 szQsSGmpmjCnBkWqgN93nXiIaIqEZFGXV/xzFtgNorm5MFs7Irb0yom+RoRhbzgfCV
	 Qdd+FqG4r7tag==
Date: Fri, 10 Apr 2026 07:51:50 -1000
Message-ID: <648d8d8decaf8a671d6cfe4c17bc98b2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Juntong Deng <juntong.deng@outlook.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] sched_ext: Track @p's rq lock across
 set_cpus_allowed_scx -> ops.set_cpumask
In-Reply-To: <20260410063046.3556100-4-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The SCX_CALL_OP_TASK call site passes rq=NULL incorrectly, leaving
scx_locked_rq() unset. Pass task_rq(p) instead so update_locked_rq()
reflects reality.

v2: Add Fixes: tag (Andrea Righi).

Fixes: 18853ba782be ("sched_ext: Track currently locked rq")
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3360,7 +3360,7 @@ static void set_cpus_allowed_scx(struct
 	 * designation pointless. Cast it away when calling the operation.
 	 */
 	if (SCX_HAS_OP(sch, set_cpumask))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_cpumask, NULL,
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_cpumask, task_rq(p),
 				 p, (struct cpumask *)p->cpus_ptr);
 }

