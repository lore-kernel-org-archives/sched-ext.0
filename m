Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01595364E81;
	Mon, 11 May 2026 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541501; cv=none; b=p2nUwZbtTWqsGA0HyCt8LuaftiIC/9SlOJ97z6AGBkPl++rIaG0vPSyB7vlKhNAYo8xIeHieSw3jtxaOcg75APROHI+HMoFZ7DmBz2e0jkTJ7yh6mCvdWpbQorc01KChiVPy/AKXjXyTKK+p3rdsj3ZzU/0uGgyBukaVw5WeGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541501; c=relaxed/simple;
	bh=rjbzJJbv4hXR14iBWX+SyJCGlrsoKfCTT304DtWB7K0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ZaAqGTszS1+AiOm2sf/YuaUvYtVkrFMvDSivhnCjcS3MssNzC4ppz73OX4PUUDQ6wRbYtzELrAMshQTt6mbK/wUnseKfCfQx5ZLlvX/vPS9N2U9GIxVycMN5shpDwVXw2813v2iOU+krGzv8QRYvin62os0lJ/mtJgdrL7d4/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkbqrsxA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkbqrsxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556F6C2BCF7;
	Mon, 11 May 2026 23:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541500;
	bh=rjbzJJbv4hXR14iBWX+SyJCGlrsoKfCTT304DtWB7K0=;
	h=Date:From:To:Cc:Subject:From;
	b=WkbqrsxAe2neVtGJXt5roJu+2os1LQ++hqHYHQuwJOszzAb0tHZxOAuViTkZHP8Px
	 ICPyiv1hht9j0YqamA3P4D5biv+7AC91wEzolSUd8QK5s9J3h3qdhsszEqYnCfzi4g
	 ON6+FYJeSgPdOSypZeVZQoBI5xmUY5Xe3G62vZIiVTc6zJV8C3GNq8wkGziQmfmDOG
	 yVxbWrL/RPfBJs3qq7BtmESzhl4hV7JoMeBZaO4434gHgP/m1iKrY0Nc8L/IGK0gVk
	 dTtZ5Zv2asncOf2c7LPcT9j9YYhUqzfAcOTJSRpxe0LSlgfp8LIvwqD20xYKLREbIN
	 8U2RNdP2COf+g==
Date: Mon, 11 May 2026 13:18:19 -1000
Message-ID: <6ec4a29c923e672d0dcb6f3ac037397e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: INIT_LIST_HEAD()
 &sch->all in scx_alloc_and_add_sched()
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On scx_link_sched() error paths (parent disabled, hash insert failure),
&sch->all is never added to scx_sched_all. The cleanup path runs
scx_unlink_sched() unconditionally, which calls list_del_rcu(&sch->all) on a
list_head that was never initialized triggering a corruption warning.

Initialize &sch->all.

Fixes: 54be8de4236a ("sched_ext: Factor out scx_link_sched() and scx_unlink_sched()")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9354da79e162..1fb3329ae2b4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6643,6 +6643,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	rcu_assign_pointer(ops->priv, sch);

 	sch->kobj.kset = scx_kset;
+	INIT_LIST_HEAD(&sch->all);

 #ifdef CONFIG_EXT_SUB_SCHED
 	char *buf = kzalloc(PATH_MAX, GFP_KERNEL);
