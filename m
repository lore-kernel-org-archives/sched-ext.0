Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573956;
	b=LyX5UriL78y1tfq7+jNGR9h7xYXjTEF+QwdzvVRk+BeBOw8FMZU0A1bsRMJTtmEBbkjt
	 Cp/BTC1i4NnKhQh2cv/cVGayxfxXIo9kMFRK7Sz6x7Sos5zVpn8IoO4LHUMbFHRnsp40i
	 x22fkJf5ZpmivSrul17TmbE1KLb7nPNLNcdcv2Oa7PLT2DVqe7AM8SDEwJFU4umL9z29l
	 en/NUmVVuRe1jowxPikwHoDWgrOvjwewapjad6In3+2JiWGodMjrtzs1wZhe6suojPrKe
	 TC7RXl/lO9TqRP5V+vbDEw0iWYZ7NgrcS/YZVWjlF2yOXxw7AoBQbuRWKZWNjRdJQdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573956;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=4kUy8pQDe8Y+ktdmnYJodtwCCgw7k+jPfy3QplRjOkU=;
	b=npY9KKfzKQsas1nIKHvlQmZiRxODs5NCynVsgEElWW3F63CR4kveF9NfhYqp1sYKeDvw
	 zVGoPIdEoEyb3fOI6L1NGuszIgoPTbD+n/Dd9+XIeqIFTUwwU72kZrlpOEdnjXzPGp+ez
	 iVf7tHQ2i+J45VpH35h+jzomaH5Ui3w/Z/u9qSxAeJCGgf8Q0zF9zRzHc/cWdRuajbDbB
	 001YPU79es6P3rqlSj81ZagK2PiG1c+C+uAgmDWrNmoERB4eME5jx3pE4Vmf51c9voqvX
	 ET+GYzdA8Fo+9/IQEty1M8zyyiNrfW+vUwT/QmDwVt47HDwOPizvJlY6tFycn+QSj4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Is8fbQV+;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479E606A322
	for <sched-ext@lists.linux.dev>; Wed, 21 Oct 2026 09:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A479E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Is8fbQV+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4k
	Uy8pQDe8Y+ktdmnYJodtwCCgw7k+jPfy3QplRjOkU=; b=Is8fbQV+uCShUhdgzs
	N4eVVCI5OGO7DrsYstffsnIOQ+x8195c/3KvSKxOarJPP3tUpAbQsoq+vmPFu2tF
	537ftS8KFrVr642jbE4eQFsA2x3syPyF1D6broiIZ9lKtU2hKHJdGEBrvJwg7k4u
	bhtdEpQ5b8mw2SNsX7Tq1I3ms=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_3nugdhqzHqWBQ--.60434S2;
	Wed, 21 Oct 2026 17:12:15 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH v2] sched_ext: Reject oversized automatic CID shards
Date: Wed, 21 Oct 2026 18:12:14 +0900
Message-ID: <20261021091214.1713830-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_3nugdhqzHqWBQ--.60434S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4kGw1UGrW7CFy8trWUArb_yoW8ur48pr
	ZFka9rKr40gayjyw4UG34I9r4UWan3Ca12qFyDGFs7Gw1UGryrtr1ayr4IgrnFgrWYgryI
	qr1v9asYqFyUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRsmitUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hFtzGrYgfEskQAA3l

Automatic topology packing starts a new shard before adding a core when
the current shard would exceed its target size. However, a first core is
always accepted so that cores remain indivisible. An indivisible core with
more than SCX_CID_SHARD_MAX_CPUS CPUs cannot be represented without
exceeding the hard shard limit.

Per-shard state uses fixed-size inline cmask storage sized for
SCX_CID_SHARD_MAX_CPUS. Passing an oversized shard to alloc_pshard() can
therefore make cmask initialization overwrite the following fields.

Reject an indivisible core larger than SCX_CID_SHARD_MAX_CPUS before adding
it to a shard. Existing non-empty shard splitting already keeps the total
within the hard cap, while an indivisible core may still exceed
cid_shard_size when it fits within the hard limit.

Report the oversized core and the hard limit with scx_error() so that the
rejection is diagnosable.

Fixes: e2c841b91bf9 ("sched_ext: Add CID sharding")
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Tested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Hui Su <sh_def@163.com>
---
Changes in v2:
- Report the oversized core and the hard shard limit with scx_error(),
  as suggested by Andrea Righi.

v1: https://lore.kernel.org/lkml/20261021064946.1445728-1-sh_def@163.com/
---
 kernel/sched/ext/cid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index 4b08866d75f6..3d0687184b44 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -287,6 +287,12 @@ s32 scx_cid_init(struct scx_sched *sch)
 				 * empty shard.
 				 */
 				cids_in_core = cpumask_weight(core_scratch);
+				if (cids_in_core > SCX_CID_SHARD_MAX_CPUS) {
+					scx_error(sch, "core with %u cpus exceeds max shard size %d",
+						  cids_in_core, SCX_CID_SHARD_MAX_CPUS);
+					return -E2BIG;
+				}
+
 				max_cores = cores_per_shard + (shard_local < nr_large ? 1 : 0);
 				if (cores_in_shard &&
 				    (cores_in_shard >= max_cores ||

base-commit: 6c377d19d4a5116d9bec5203aa3c6c11523e7898

