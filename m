Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4380D411A05
	for <sched-ext@lists.linux.dev>; Fri,  7 Aug 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107475; cv=none; b=h4l0EF3zJu21nq0OJ0WG8rAAyqC/Fw8ZHlwRGoRVLjyatFu2fWjhMpBrQBLbO+F4OltEToAcGRUH8niyje9ZBDwj0Mp9tRJ3zVbvyI+AhVHSSSiNRYiw9RJNUs8d2wF1XfhsEC+oB2Sofi3dp73rDHOOUIv5TSrsNkfTA+lKyjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107475; c=relaxed/simple;
	bh=Y9/aekxWQuoAMUmR6BdZp3iMVUakfDh7O5ktnd+DwPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mRHbq692xyKs5RU5rLK1ylE246JgjmWYw7v6OHmM/tBqdG6cfKcrKT3cYbADJGTvYnUoM5IsRk9Xe+Opl4TfVE9RTrWk9wOzSoqiPjTZube1afDz4b/ZdYRkOnypFgSS6YoY3VOsSJah5DMcM56ukiuTCBVfkaxW9iGYDrB+rTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YpXNasDB; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YpXNasDB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4Y
	cHFwfxuPptEHniUxgvrZUbdZPNkJGiJoN2Tgxz3Bk=; b=YpXNasDBGwg7DiErIY
	IyE7rkHbG8U0VJEo2r1O1/lgO1gtdap9FKtdzGwzswgDCi5MGtC7FnJeV/1WLFM7
	spwBXuicnGjwsa4oV4aS0PHmw/D88CzNBlYWe6nKAsn/PHeQAX4XgstGqqarQQko
	GluO+eD7gAJ1SNwAtv0gOZRLg=
Received: from cuijian-virtual-machine.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCHGwAt1nVqgcHtKA--.4340S2;
	Fri, 07 Aug 2026 20:57:18 +0800 (CST)
From: Cui Jian <cjian720@163.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cui Jian <cjian720@163.com>
Subject: [PATCH] sched_ext: Add NULL check in find_parent_sched()
Date: Fri,  7 Aug 2026 20:57:16 +0800
Message-Id: <20260807125716.56531-1-cjian720@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807114534.1253158-1-zhanxusheng@xiaomi.com>
References: <20260807114534.1253158-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCHGwAt1nVqgcHtKA--.4340S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrykXr1xWw13JrW7Kw45ZFb_yoW3tFb_Zw
	sxGF1UG34UCr1DKw17Cw4fXryrKFW8WF95ZF9rKFZ8JF18JrZIqrn5CF95trnxKayIvF98
	Cr9FqF98Cwn7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRibyCDUUUUU==
X-CM-SenderInfo: pfmlt0qxsqqiywtou0bp/xtbC+A64RWp11i6GDQAA3n

find_parent_sched() dereferences cgrp->scx_sched without checking
for NULL. This is safe in practice because scx_sched is always
set for cgroups that can reach this function, but add a defensive
check for robustness.

Signed-off-by: Cui Jian <cjian720@163.com>
---
 kernel/sched/ext/sub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index d7842a609d96..6395281bae71 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1209,6 +1209,10 @@ static struct scx_sched *find_parent_sched(struct cgroup *cgrp)
 
 	lockdep_assert_held(&scx_sched_lock);
 
+	/* no SCX sched */
+	if (!parent)
+		return ERR_PTR(-ENODEV);
+
 	/* can't attach twice to the same cgroup */
 	if (parent->cgrp == cgrp)
 		return ERR_PTR(-EBUSY);
-- 
2.34.1

