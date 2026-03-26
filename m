Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227F77F39
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774493569; cv=none; b=ZS9nBzEkkdmzr+/WiOI2S0Vrh4HUIDBnyur48gicw/Em3YmnpBRQMTAUuSL9NSlmaFsLTRO7/ts0zDyGoUo5ochJSnQ2I4NGhfa2odNHp5UM+u0vskrxJhgMv5YYBrfJA3sCTI3PtS11CR7Zv73z3dEbzmevNTceSUWzc+CTx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774493569; c=relaxed/simple;
	bh=khty5Sszo/eSqzH1h82xJX/gdOKL51cSeomVUsXzI8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1FpyVt0UDcchLaAKXxpzruf+H32Q4Gk8T3O573QdSt161CNdu+tyhKi4u4E3vXQ7MPM34FiSKyOT3HrDjmTQGiejRP6W2HbcMpvxCunLn3z4Bb4EOgpdgbvxYy5iojOOXaTMh4IWS+9HbZUFvdIYF8mAo2OKDm/xJokDqoIfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=S8FgRayQ; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="S8FgRayQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Wa
	FIMqAMRfjZN98IBsCFgeXw8MgSPu74dqTVIqSheYo=; b=S8FgRayQfqrSvzdxYz
	EFQCqiD3LiNqAI2RAcEc535niCq6T9btEIfP0fnBwVAxdT4runEgEPidXI5qOxD6
	GO4ujfLJWkHyEcidRJAM64+ZIS4LAlMH8UnFF4ehmhlRse/jrQQewOkMyAuFNv3b
	WtHLXaHpQy2sqp72YcGr4tssI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgCXP91Un8RpxqJrCQ--.24603S2;
	Thu, 26 Mar 2026 10:52:05 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH] tools/sched_ext: scx_pair: fix pair_ctx indexing for CPU pairs
Date: Thu, 26 Mar 2026 10:51:55 +0800
Message-ID: <20260326025155.94581-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgCXP91Un8RpxqJrCQ--.24603S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1ftr18WryUGryUWw4kWFg_yoW8KrW8pF
	Z8t3yUC348Jw45ua4kCr48Crsagrsa9w42qr1fJw1Yv347C3s2qr13JFWSqrZFkr4kJry2
	vFy0gF47K3WUAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U33kNUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqxWIAGnEn1U7xAAA3u

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

scx_pair sizes pair_ctx to nr_cpu_ids / 2, so valid pair_ctx keys are
dense pair indexes in the range [0, nr_cpu_ids / 2).

However, the userspace setup code stores pair_id as the first CPU number
in each pair. On an 8-CPU system with "-S 1", that produces pair IDs
0, 2, 4 and 6 for pairs [0,1], [2,3], [4,5] and [6,7]. CPUs in the
latter half then look up pair_ctx with out-of-range keys and the BPF
scheduler aborts with:

EXIT: scx_bpf_error (scx_pair.bpf.c:328: failed to lookup pairc and
in_pair_mask for cpu[5])

Assign pair_id using a dense pair counter instead so that each CPU pair
maps to a valid pair_ctx entry. Besides, reject odd CPU configuration, as
scx_pair requires all CPUs to be paired.

Fixes: f0262b102c7c ("tools/sched_ext: add scx_pair scheduler")
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 tools/sched_ext/scx_pair.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_pair.c b/tools/sched_ext/scx_pair.c
index 61fd86b44c40..41b136d43a55 100644
--- a/tools/sched_ext/scx_pair.c
+++ b/tools/sched_ext/scx_pair.c
@@ -48,6 +48,7 @@ int main(int argc, char **argv)
 	struct bpf_link *link;
 	__u64 seq = 0, ecode;
 	__s32 stride, i, opt, outer_fd;
+	__u32 pair_id = 0;
 
 	libbpf_set_print(libbpf_print_fn);
 	signal(SIGINT, sigint_handler);
@@ -82,6 +83,14 @@ int main(int argc, char **argv)
 		scx_pair__destroy(skel);
 		return -1;
 	}
+
+	if (skel->rodata->nr_cpu_ids & 1) {
+		fprintf(stderr, "scx_pair requires an even CPU count, got %u\n",
+			skel->rodata->nr_cpu_ids);
+		scx_pair__destroy(skel);
+		return -1;
+	}
+
 	bpf_map__set_max_entries(skel->maps.pair_ctx, skel->rodata->nr_cpu_ids / 2);
 
 	/* Resize arrays so their element count is equal to cpu count. */
@@ -109,10 +118,11 @@ int main(int argc, char **argv)
 
 		skel->rodata_pair_cpu->pair_cpu[i] = j;
 		skel->rodata_pair_cpu->pair_cpu[j] = i;
-		skel->rodata_pair_id->pair_id[i] = i;
-		skel->rodata_pair_id->pair_id[j] = i;
+		skel->rodata_pair_id->pair_id[i] = pair_id;
+		skel->rodata_pair_id->pair_id[j] = pair_id;
 		skel->rodata_in_pair_idx->in_pair_idx[i] = 0;
 		skel->rodata_in_pair_idx->in_pair_idx[j] = 1;
+		pair_id++;
 
 		printf("[%d, %d] ", i, j);
 	}
-- 
2.43.0

