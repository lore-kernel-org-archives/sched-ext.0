Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859414;
	b=zyhFzcyaz4Thp//dC+7vNPxjFBvEafhyv2/tyMyNvrvNCwnnckQe2+7fTWy4qnNc8bDf
	 wP3i0hFBjaPBL1UT7AXTCgCfO/zoIWTFMw+/zJVLc/7GoKo4GEZBNU2YVT0FoEEedw6Mp
	 jGa9FxtiLnAaJQC0U+r4otB8XL/EXWwMiXr893xVwc195fRt5X+J/lPqt2D56G+ejOKbJ
	 7MspxXE1eQURTFvwolGzJtEwreTGm7X726ui1u4I88iXS+iIRfzvG2pcZtpizUI/ci6LD
	 BVqF/m5Vhlw1djxQqAHXAfzxbxJr+sGlo8hP6sGTxnszFkstc8KiRpCTWmjSWTotUzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859414;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=VDyU0RzFw5XhVgtF969cBIIIGjCobkQTfAtkDKO6N08=;
	b=jAgH77aHiYniQIxU/IZuuCQSfXeUPJw03chljGWheMvkwLf+BFmtoNfPk+2QJuLnX9Aw
	 lQlRTnafHlSVep57fNWspFAw25lGzwmT88qVNaEDTS9ABYLM5C8rQN+8xcrFGcQ3aVz/D
	 7OhWS+CboNfLMJ3sj4q6T2cMIT+aJXHIliNzLUP5IIbGJ3/F/0ImYZDRYZxtrLiNK13n3
	 DeAJN00SqDE6nS44psUsqi303dl7H1lL9VrsNkTzy78UvBqo2oN8emLDkOr59c1uhN/6R
	 CNgZMItiPKqlYfeLo2mnr0YHNUpaiwkiaVz4Xr6G4scXhXPF+ojkPGzODoEWKujOrzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HXvKi0sx;
	arc=none smtp.remote-ip=113.46.200.218
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD6606D801
	for <sched-ext@lists.linux.dev>; Thu,  5 Nov 2026 06:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76BD6606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HXvKi0sx
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VDyU0RzFw5XhVgtF969cBIIIGjCobkQTfAtkDKO6N08=;
	b=HXvKi0sx4ZEbupdiEZTUCD4UsD7eSWx3gzqeDm3z+roYTgQojaO/2CM4tJwZ410AsceCVwkHR
	fnmvJuU1LragrH5cPT3YHsYaXJ++ts06KM8q3jn99kdajyMhQ3m1GrEXuS091J28xmtDgJEwsoZ
	I7liaFoegOyTyO+HRqflxls=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jKsWj1kxNzpSvl;
	Thu,  5 Nov 2026 14:16:17 +0800 (CST)
Received: from kwepemk300016.china.huawei.com (unknown [7.202.195.98])
	by mail.maildlp.com (Postfix) with ESMTPS id C2C1D4057D;
	Thu,  5 Nov 2026 14:16:43 +0800 (CST)
Received: from huawei.com (10.67.174.191) by kwepemk300016.china.huawei.com
 (7.202.195.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 14:16:43 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <sched-ext@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <tj@kernel.org>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <tanghui22@huawei.com>,
	<zhangqiao22@huawei.com>
Subject: [PATCH 1/4] sched_ext: Extract no-topology CID construction and table finalization
Date: Thu, 5 Nov 2026 14:50:10 +0800
Message-ID: <20261105065013.784398-2-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261105065013.784398-1-zhangqiao22@huawei.com>
References: <20261105065013.784398-1-zhangqiao22@huawei.com>
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

scx_cid_init() interleaves table allocation, the four-level topology
walk, the no-topo tail and the shard range finalization in a single
~230-line body. Start decomposing it by extracting the last two stages:

  - scx_cid_build_notopo() packs the possible-but-unassigned cpus into
    shards capped at min(shard_size, SCX_CID_SHARD_MAX_CPUS) and
    records the online cpus that ended up without topology info.
  - scx_cid_finalize_tables() derives shard_ranges[] from
    cid_to_shard[] and publishes nr_shards.

The counters are passed by pointer. Allocation, diagnostics and
cleanup stay in scx_cid_init(). No behavior change.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext/cid.c | 120 +++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 51 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index a5330b760ecd..b6be8806a7d5 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -165,6 +165,71 @@ void scx_cid_retire_tables(void)
 	call_rcu(&tbls->rcu, scx_cid_tables_free_rcufn);
 }
 
+static void scx_cid_build_notopo(struct scx_cid_tables *tbls, u32 shard_size,
+				 u32 *next_cid, s32 *next_shard_idx,
+				 struct cpumask *online_no_topo)
+{
+	u32 notopo_in_shard;
+	s32 notopo_shard_cid, notopo_shard_idx;
+	s32 cpu, cid;
+
+	/*
+	 * No-topo section: any possible cpu without a cid - normally just the
+	 * not-online ones. Pack into shards of up to min(@shard_size,
+	 * SCX_CID_SHARD_MAX_CPUS) cids so that every cid has a valid shard
+	 * assignment and the hard cap holds even with a large @shard_size.
+	 * Collect any currently-online cpus that land here in @online_no_topo
+	 * so we can warn about them at the end.
+	 */
+	notopo_in_shard = min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS);
+	notopo_shard_cid = -1;
+	notopo_shard_idx = -1;
+
+	for_each_cpu(cpu, cpu_possible_mask) {
+		if (tbls->cpu_to_cid[cpu] != -1)
+			continue;
+		if (cpu_online(cpu))
+			cpumask_set_cpu(cpu, online_no_topo);
+
+		cid = (*next_cid)++;
+		tbls->cid_to_cpu[cid] = cpu;
+		tbls->cpu_to_cid[cpu] = cid;
+
+		if (notopo_in_shard >= min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS)) {
+			notopo_shard_cid = cid;
+			notopo_shard_idx = (*next_shard_idx)++;
+			notopo_in_shard = 0;
+		}
+		notopo_in_shard++;
+
+		tbls->cid_to_shard[cid] = notopo_shard_idx;
+		tbls->topo[cid] = SCX_CID_TOPO_NEG;
+		tbls->topo[cid].shard_cid = notopo_shard_cid;
+		tbls->topo[cid].shard_idx = notopo_shard_idx;
+	}
+}
+
+static void scx_cid_finalize_tables(struct scx_cid_tables *tbls, u32 next_cid,
+				    s32 next_shard_idx)
+{
+	s32 cid;
+
+	/*
+	 * Fill shard_ranges[] from cid_to_shard[]. Shards are contiguous
+	 * cid ranges by construction: base_cid is the first cid landing in a
+	 * shard, nr_cids is the count.
+	 */
+	for (cid = 0; cid < next_cid; cid++) {
+		s32 sidx = tbls->cid_to_shard[cid];
+
+		if (tbls->shard_ranges[sidx].nr_cids == 0)
+			tbls->shard_ranges[sidx].base_cid = cid;
+		tbls->shard_ranges[sidx].nr_cids++;
+	}
+
+	tbls->nr_shards = next_shard_idx;
+}
+
 /**
  * scx_cid_init - build the cid mapping
  * @sch: the scx_sched being initialized; used as the scx_error() target
@@ -193,9 +258,7 @@ s32 scx_cid_init(struct scx_sched *sch)
 	s32 next_cluster_idx = 0;
 	s32 next_shard_idx = 0;
 	u32 shard_size, max_cids;
-	u32 notopo_in_shard;
-	s32 notopo_shard_cid, notopo_shard_idx;
-	s32 cpu, cid, si;
+	s32 cpu, si;
 
 	/* CMASK_MAX_WORDS in cid.bpf.h covers NR_CPUS up to 8192 */
 	BUILD_BUG_ON(NR_CPUS > 8192);
@@ -351,40 +414,8 @@ s32 scx_cid_init(struct scx_sched *sch)
 		}
 	}
 
-	/*
-	 * No-topo section: any possible cpu without a cid - normally just the
-	 * not-online ones. Pack into shards of up to min(@shard_size,
-	 * SCX_CID_SHARD_MAX_CPUS) cids so that every cid has a valid shard
-	 * assignment and the hard cap holds even with a large @shard_size.
-	 * Collect any currently-online cpus that land here in @online_no_topo
-	 * so we can warn about them at the end.
-	 */
-	notopo_in_shard = min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS);
-	notopo_shard_cid = -1;
-	notopo_shard_idx = -1;
-
-	for_each_cpu(cpu, cpu_possible_mask) {
-		if (tbls->cpu_to_cid[cpu] != -1)
-			continue;
-		if (cpu_online(cpu))
-			cpumask_set_cpu(cpu, online_no_topo);
-
-		cid = next_cid++;
-		tbls->cid_to_cpu[cid] = cpu;
-		tbls->cpu_to_cid[cpu] = cid;
-
-		if (notopo_in_shard >= min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS)) {
-			notopo_shard_cid = cid;
-			notopo_shard_idx = next_shard_idx++;
-			notopo_in_shard = 0;
-		}
-		notopo_in_shard++;
-
-		tbls->cid_to_shard[cid] = notopo_shard_idx;
-		tbls->topo[cid] = SCX_CID_TOPO_NEG;
-		tbls->topo[cid].shard_cid = notopo_shard_cid;
-		tbls->topo[cid].shard_idx = notopo_shard_idx;
-	}
+	scx_cid_build_notopo(tbls, shard_size, &next_cid, &next_shard_idx,
+			     online_no_topo);
 
 	if (!cpumask_empty(llc_fallback))
 		pr_warn("scx_cid: cpus without cacheinfo, using node mask as llc: %*pbl\n",
@@ -393,20 +424,7 @@ s32 scx_cid_init(struct scx_sched *sch)
 		pr_warn("scx_cid: online cpus with no usable topology: %*pbl\n",
 			cpumask_pr_args(online_no_topo));
 
-	/*
-	 * Fill cid_shard_ranges[] from cid_to_shard[]. Shards are contiguous
-	 * cid ranges by construction: base_cid is the first cid landing in a
-	 * shard, nr_cids is the count.
-	 */
-	for (cid = 0; cid < next_cid; cid++) {
-		s32 sidx = tbls->cid_to_shard[cid];
-
-		if (tbls->shard_ranges[sidx].nr_cids == 0)
-			tbls->shard_ranges[sidx].base_cid = cid;
-		tbls->shard_ranges[sidx].nr_cids++;
-	}
-
-	tbls->nr_shards = next_shard_idx;
+	scx_cid_finalize_tables(tbls, next_cid, next_shard_idx);
 	return 0;
 }
 
-- 
2.43.0

