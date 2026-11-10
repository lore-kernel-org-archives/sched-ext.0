Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299864;
	b=JEbwOgfHZuhLdneOKdq7ldH12xzHCoR2dFnTyIIQiZi6iigVabHR02BpVL+2hlBOoC1V
	 /z7CaSN1R/kXvBYT6v7QlPt2inr/sB3qCXO62el4DJEP9m1gAqZ4bNO3fzyqi0AUC2sXa
	 NMejljAeXC2sA4HJFRaK/S8OchN5kdQsGSEeCKDILIs/5gg3pznLQ6u40Vyu0yf3N4FUM
	 ecRqn61+oLpVBBuDfCpZNFYd9lCVMZ10oZpEC77IlKsUDvCyAc2A4/i2shToXc4LGVid/
	 kFufU41Fw/6SDSl/i32r4esNu9ljL79ES0fLFYddUW5PCWyjZIhIu5m/KBMymHWmnOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299864;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=xcznGRn/OZcAdbGGXa1jkvkh+IzNXspdo8My4ZGyOlY=;
	b=pSZQ/N8FI8UyKCqGaH3kq9BZKf6zysu/yVPnWlAUiArWw743aRXUQu3XallgYYbS18uo
	 lMR2kTGc1AXvm0L0dVpdZCcd2QmwR4BteCvmTF7IqqLCHyBG+3GNFbDji1obuBUcgrPiW
	 XPfCovfLF4fKC6bDkvTQgcB+vIDN1b3eMVP0eJ/U7XrFzKZa46o4r5B7uLxyF4RBsMNX0
	 IRuLD8Icllq+GZFNNNsYbXeMMMjWxMH1HzPrYPfS16AkPhDQS09qXjwK8Hoxzeb5bXqkm
	 rQU5Jv0vq535n0tjW6srXLidP1+Nj6/ondDTQstZsjEwCKlQ1yvk1nLEeMfhXlix9uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zFEUb924;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B08606A321
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 08:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15B08606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zFEUb924
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xcznGRn/OZcAdbGGXa1jkvkh+IzNXspdo8My4ZGyOlY=;
	b=zFEUb924C2dfk8jUOyUrf+zpr7CDH4ND25x6aJBNZvNuIOKxTiWYoZRFy440j6Z+eotk5k70y
	6WFa3/j5up58YMe6pbdmCALEj0RV3vayFwUexew4lqtJRySmSX3JXbevfX91bJhFaEVhIZDnOj4
	SBhQVZh+y8qyNUOHTxIuTlw=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jP0QK6q8LzKm8W;
	Tue, 10 Nov 2026 16:37:29 +0800 (CST)
Received: from kwepemk300016.china.huawei.com (unknown [7.202.195.98])
	by mail.maildlp.com (Postfix) with ESMTPS id 5229140561;
	Tue, 10 Nov 2026 16:37:39 +0800 (CST)
Received: from huawei.com (10.67.174.191) by kwepemk300016.china.huawei.com
 (7.202.195.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 16:37:38 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <tj@kernel.org>
CC: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>,
	<sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<tanghui20@huawei.com>, <zhangqiao22@huawei.com>
Subject: [PATCH v2 sched_ext/for-7.4-fixes] sched_ext: Fix partial-SMT core counting in calc_shard_layout()
Date: Tue, 10 Nov 2026 17:10:42 +0800
Message-ID: <20261110091042.1805197-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk300016.china.huawei.com (7.202.195.98)

calc_shard_layout() counts the cores of an LLC to spread them evenly
across shards. A core is counted when its cpu is the first cpu of
topology_sibling_cpumask(), but the cores scx_cid_init() builds are
the siblings intersected with @llc_cpus.

The sibling mask may contain cpus outside @llc_cpus - siblings which
landed in another node or LLC unit, or offlined siblings on archs
that keep them in the mask (mips, sparc64). A core whose first
sibling is such a cpu is never counted, so cores_per_shard and
nr_large come out too small and the shards end up uneven.

Count a core at its first sibling in @llc_cpus, matching the cores the
build loop constructs.

Fixes: e2c841b91bf9 ("sched_ext: Add CID sharding")
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext/cid.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index 8e04a8494e11..0cc397055f57 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -64,7 +64,13 @@ static void calc_shard_layout(const struct cpumask *llc_cpus, u32 shard_size,
 
 	for_each_cpu(cpu, llc_cpus) {
 		nr_cpus++;
-		if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
+		/*
+		 * scx_cid_init() forms each core from the siblings in
+		 * @llc_cpus. The sibling mask may include cpus outside
+		 * @llc_cpus, so count a core at its first sibling in @llc_cpus.
+		 */
+		if (cpumask_first_and(topology_sibling_cpumask(cpu),
+				      llc_cpus) == cpu)
 			nr_cores++;
 	}
 
-- 
2.43.0

