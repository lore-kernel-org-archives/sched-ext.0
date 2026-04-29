Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F83A8742;
	Wed, 29 Apr 2026 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451034; cv=none; b=rEx9A8qviue6IIQCHdui42YidLw/LiL8hZ02d6ECyArhI9IoBfoxBwSTLGNUo9rJWAhV7+CbgdcfcUb2vvLcVzZD+6FhIqTcZuYByTGbW3jgMS9MagdpTTwXkgFO/vNCXXlNIzXLW5H4GfxnwG+7SJmiOGPMxHSrM2+QpPa1EXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451034; c=relaxed/simple;
	bh=BUWb8P5Z5iyh7MtWWO+vkPjmuYYg2DGB3or3mMpZZ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVux0fPPWNXcX4WAh3hNJRU6ZxsfhaI0US92DUW3zE0u4nUWygycalhMHdlmLzhY+LmBdFM9YRnrvpo1UgvTjveq9pJiOmWlfgO9/Gd5vBqbE1NLXz4gIxgWayFCtEho1CTtsttsTOe46b64fuGxQTMF8dRhyhS4X++zRyINL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gli4DiHh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gli4DiHh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XE9lihpf45ac+Vxml6PEmw0N0ER3hi/2ljTrLLByryA=; b=gli4DiHh8e9icQ/35JE4OM3k0u
	oQKs0OERkznMWWBgbXjFWn8nT7TdkRLbrBY+PnLdf933+32EUMmQgBA3ZD248yHG/k3V2e1teNbQ5
	jyUMMiJfq/r+pRROp8gYRIsCREAEiKGy8vvym0umR/hGZVRv738NezFSNz+DzIuX4J1jLO09HGuf+
	ZrJBoHobqVyZlKzV6FsMc0l5Dm15VOJIPj8nU/7ZKpICHowKkNdXYFJxJ1rzUH1e36uW+ro8o+/lt
	Ya/lhuoMroUWRkZ+ZqkebL6GsQUSRo2+tz96HBueKv2VYP8V7s0AxOO1PoIJ0Of1vIEZSxZaZAFtK
	b+1F1GGg==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wI0Cx-003ojt-Dx; Wed, 29 Apr 2026 10:23:47 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] sched_ext: Expose exit_cpu to BPF and userspace
Date: Wed, 29 Apr 2026 17:23:18 +0900
Message-ID: <20260429082318.420146-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429082318.420146-1-changwoo@igalia.com>
References: <20260429082318.420146-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend struct user_exit_info with an exit_cpu field so BPF schedulers
and the userspace report path can see the CPU that triggered the exit,
matching the kernel-side dump.

UEI_RECORD() defaults the field to -1 before the CO-RE-gated copy so
that running against an older kernel without exit_cpu stays
distinguishable from "exit happened on CPU 0".

UEI_REPORT() appends "on CPU N" to the EXIT line when the value is
valid, surfacing the most diagnostically useful piece of exit info to
any sched_ext userspace tool without needing to crack open the debug
dump.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/include/scx/user_exit_info.bpf.h    | 3 +++
 tools/sched_ext/include/scx/user_exit_info.h        | 2 ++
 tools/sched_ext/include/scx/user_exit_info_common.h | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/tools/sched_ext/include/scx/user_exit_info.bpf.h b/tools/sched_ext/include/scx/user_exit_info.bpf.h
index e7ac6611a990..98cab643c8d9 100644
--- a/tools/sched_ext/include/scx/user_exit_info.bpf.h
+++ b/tools/sched_ext/include/scx/user_exit_info.bpf.h
@@ -32,6 +32,9 @@
 				  __uei_name##_dump_len, (__ei)->dump);		\
 	if (bpf_core_field_exists((__ei)->exit_code))				\
 		__uei_name.exit_code = (__ei)->exit_code;			\
+	__uei_name.exit_cpu = -1;						\
+	if (bpf_core_field_exists((__ei)->exit_cpu))				\
+		__uei_name.exit_cpu = (__ei)->exit_cpu;				\
 	/* use __sync to force memory barrier */				\
 	__sync_val_compare_and_swap(&__uei_name.kind, __uei_name.kind,		\
 				    (__ei)->kind);				\
diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
index 399697fa372f..56a02b549aef 100644
--- a/tools/sched_ext/include/scx/user_exit_info.h
+++ b/tools/sched_ext/include/scx/user_exit_info.h
@@ -39,6 +39,8 @@
 	fprintf(stderr, "EXIT: %s", __uei->reason);				\
 	if (__uei->msg[0] != '\0')						\
 		fprintf(stderr, " (%s)", __uei->msg);				\
+	if (__uei->exit_cpu >= 0)						\
+		fprintf(stderr, " on CPU %d", __uei->exit_cpu);			\
 	fputs("\n", stderr);							\
 	__uei->exit_code;							\
 })
diff --git a/tools/sched_ext/include/scx/user_exit_info_common.h b/tools/sched_ext/include/scx/user_exit_info_common.h
index 2d0981aedd89..76e2a055eb4b 100644
--- a/tools/sched_ext/include/scx/user_exit_info_common.h
+++ b/tools/sched_ext/include/scx/user_exit_info_common.h
@@ -22,6 +22,11 @@ enum uei_sizes {
 
 struct user_exit_info {
 	int		kind;
+	/*
+	 * CPU that triggered the exit, or -1 if unset (e.g. running on an
+	 * older kernel that does not expose this field).
+	 */
+	s32		exit_cpu;
 	s64		exit_code;
 	char		reason[UEI_REASON_LEN];
 	char		msg[UEI_MSG_LEN];
-- 
2.54.0

