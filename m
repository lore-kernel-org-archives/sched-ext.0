Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489045;
	b=p93m9q7KeedxNJlcsIaE5bCGnLAwD8FLAE/TmbizjlwOsxLzDCtzJUA03f89SNwuCZhm
	 9zFypQ2Zo78CuEGll0ETU3XLRKOj7qNcUtb3A3WdpPN3BDRCDrzqde2PzJPShrH0LMLKI
	 6VykAbibH5gh+exjxcjOq0ukKMAOGFf0lZbleOeDmYUDPZuIIHaeRQ6ZHKaISWoeWVwgb
	 ZEsOSVavVlqY/pyK7Bl0x2Hb5LVK6aVoJQ16wjGSwDLg4Xaitka9NqIoBv9G/QIHRDkQu
	 WKNDfeCBICMJVtG6PFWW2lukow87c8t/Xea0vCkfYc9re9AFueLvAQ2PLK0dlg/rzkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489045;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OlKbhQLab5g4Xms2RrXIIJjBKqXkYeiQOogD0n/L2TE=;
	b=DloKOlSURAwfnwIfxMb4c60twh856YojeSMEtk3B71h5R4EkfYCdNEaW2r93hp33HQ54
	 rF/DOoDqrU/MhOGk9qGXGFY2r3OiJ9UkagxLPGyshvyJpjeivRZINqpmzSQqa3bZP4P9G
	 ukF7LOQ9YDvPlf++jGFjSi/fXTzbIo4leKqGz0L30sGa+2bGdnTOo/8+NKHB7/nor81oT
	 rVt6UhZJslZXnB3cD9jf0jxOFFtnirWRVmLg0p3F2cYycjsVTGBxi8cc8hM4Y7AhMXoka
	 AEH0HpkI7IS9dCyWJom6QTNB6O5xNu7+LlSBuMfKZS6odMe/68xt9rEHfKtixLeLHMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Rd3w0HwW;
	arc=none smtp.remote-ip=95.215.58.20
Received: from mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68268606A8A5
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 13:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68268606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Rd3w0HwW
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Hq87wQzb8e4RRe8KYeLW2df0CMQqxzTx40VCXAv0cGQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794489042; v=1; x=1795093842;
 b=Rd3w0HwWE2M0tztNtshgfPlN3nXDZgbmcDkxCH1cyszoFQ0muKo59mnekgTvIoPF/bqyPJBb
 OIB4tQJtmg7cVk8t/kKT2O2Bse4Z3DCLCF6cUAfqTt7OVbeoy75ylC9vnvSG5obM9aqpMyNnzP7
 tgoSvbNpO8p2US7WSuqT5Mo4=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c01043e0da7dcff8;
	Thu, 12 Nov 2026 13:10:42 +0000
X-Mizu-Trace-ID: c01043e0da7dcff8
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	usama.arif@linux.dev,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 4/6] sched_ext: Reject cid_online/cid_offline on sub-schedulers
Date: Thu, 12 Nov 2026 21:09:32 +0800
Message-ID: <20261112130934.563321-5-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112130934.563321-1-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev>
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

From: Tao Cui <cuitao@kylinos.cn>

A sub-sched's enable path sets the has_op bits for every callback it
declares, and validate_ops doesn't stop it from declaring
ops.cid_online()/cid_offline(), but handle_hotplug() delivers hotplug
callbacks to the root scheduler only, so those callbacks would never
run while the per-cid online masks are maintained for the sub-sched
regardless.

Reject the declaration at load time like the cpu-form sub_attach/
sub_detach rejection next to it, and note the root-only delivery in the
ops kerneldoc. The ecaps notifier, in contrast, is delivered per
sub-sched; if per-sub hotplug delivery is wanted later, this rejection
is the piece to relax.

Fixes: 337ec00b1d9c ("sched_ext: Implement cgroup sub-sched enabling and disabling")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c      | 9 +++++++++
 kernel/sched/ext/internal.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 063b2964099a..792cf0c1d582 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8630,6 +8630,15 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		}
 	}
 
+	/*
+	 * Hotplug callbacks are delivered to the root scheduler only, so a
+	 * sub-sched's ops.cid_online()/cid_offline() would never run.
+	 */
+	if (scx_parent(sch) && (ops->cpu_online || ops->cpu_offline)) {
+		scx_error(sch, "cpu_online/cpu_offline are root-scheduler callbacks");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index d79a48afbff0..64d87d03e112 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1000,6 +1000,9 @@ struct sched_ext_ops {
 	 * @cpu just came online. @cpu will not call ops.enqueue() or
 	 * ops.dispatch(), nor run tasks associated with other CPUs beforehand.
 	 * ops.sub_child_ecaps_updated() runs for @cpu only after this op.
+	 *
+	 * Root schedulers only: hotplug callbacks are delivered to the root
+	 * scheduler and are never invoked on sub-scheds.
 	 */
 	void (*cpu_online)(s32 cpu);
 
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
