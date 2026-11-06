Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933088;
	b=TZK4jmaZqvWHI6B7liNMWOGO8casrG79zwZGzAGFhxHlGoNvdvHY/6q3GWFaXpZIja5p
	 z9NkGSv4lRZOqRZ/yrbb+ah4x7m9odaHfdg7xM7Esnl/JnrF1aLSyg8s+ddhB/xcYxOR7
	 bwC4dLrjlaweVvIiEoejlKC9KYBYDpjlciPvfRguD3Y/C7ytLQ8p0SNtsKRxgNc51w3b0
	 hQ7YALWmJodNEE3QMOUAIKpG0nB/lT+LJX10Y02rVvMbPmI4i/6aVliCa3LZWx+Us1tGk
	 bavPsDW5+3amRNQyQ2P5zS/Vaz7p3As7lfEoWAKBZQu8rAL8riPmKRLNUknqXkzGvFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933088;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:CC:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=DNSkwc/3EcdS5hqa3NzQ8KzdNccAfF8CD1FAU5JF//I=;
	b=3ZNB3gAoNVKc2aHGpJMgGgHCZi6KfjGTqIl57Wd3iCBB5TCNOHweG0IgQAKuctIzI29V
	 2M3rNPkkObniWYw/67I/7eyit6vR2WvynwWDvOcx6r8lZIZo+ZYNx9fWxBjBc7gWK2N13
	 q3Oo0zJ9hNDhRWEfO85TA/SfmWKwMxB9PuMledBp5Oa24+6xnE4eEZjToQmszZUmFRqHi
	 JByy4U2nHYS3BGgbzMwIgrCkuSWmOpRXgxXWL2fvZ3tN9YY+Ph+cLmLG3cApV+JHl9Rk+
	 6wuIgkQ5pzwaTSkHz0FPwXCHK5q7hRUayUxlgs45q1gQHOJKaWZVxxLEslNd3g+N6QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1gQVDAJ+;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A0606A326
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 02:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 424A0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1gQVDAJ+
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DNSkwc/3EcdS5hqa3NzQ8KzdNccAfF8CD1FAU5JF//I=;
	b=1gQVDAJ+V2pZ6VkCT7rWg8VMd3m56tJLZDTUzhvBr/z9Qwr2mkr43r5MaMBEvLBMRu3zRTqZa
	oOeNb09qnqe6udzw7m6ea7sAQ6T4+csRog/KrVrgKY754vC7Eair8m069l1N3CxBFhvVAWX0kLu
	epF0H7uuQYY5mvuUuLDc1kA=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jLNms2nCrz1cySY;
	Fri,  6 Nov 2026 10:44:29 +0800 (CST)
Received: from kwepemk300016.china.huawei.com (unknown [7.202.195.98])
	by mail.maildlp.com (Postfix) with ESMTPS id 92F1140572;
	Fri,  6 Nov 2026 10:44:41 +0800 (CST)
Received: from [10.67.109.218] (10.67.109.218) by
 kwepemk300016.china.huawei.com (7.202.195.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 6 Nov 2026 10:44:41 +0800
Message-ID: <1eac08a9-b5e9-b353-b9d1-1e2d32802993@huawei.com>
Date: Fri, 6 Nov 2026 10:44:30 +0800
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
From: Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix partial-SMT core
 counting in calc_shard_layout()
To: <sched-ext@lists.linux.dev>, Tejun Heo <tj@kernel.org>
CC: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Hui Tang <tanghui20@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk300016.china.huawei.com (7.202.195.98)

A core is counted when its cpu is the first cpu of
topology_sibling_cpumask(), which includes offline cpus. When the
low-numbered siblings of a core are offline at root-enable time, no
online sibling passes the test and the core is not counted. The
resulting cores_per_shard and nr_large are then too small and the
cores are spread unevenly across shards.

Count a core when its cpu is the first sibling in @llc_cpus, matching
the cores the build loop actually constructs.

Fixes: e2c841b91bf9 ("sched_ext: Add CID sharding")
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext/cid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index 8e04a8494e11..64572e39c865 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -64,7 +64,9 @@ static void calc_shard_layout(const struct cpumask *llc_cpus,
u32 shard_size,
  	for_each_cpu(cpu, llc_cpus) {
 		nr_cpus++;
-		if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
+		/* the low-numbered siblings may be offline */
+		if (cpumask_first_and(topology_sibling_cpumask(cpu),
+				      llc_cpus) == cpu)
 			nr_cores++;
 	}
 -- 2.43.0

