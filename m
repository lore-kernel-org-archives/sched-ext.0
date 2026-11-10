Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315076;
	b=GnPabPeEv0iPOu1EkCSHeRL/WEnCxw21TpHVEFU3hAPmofayGElaYMBTz9VgHENUYjsh
	 HzHGxoHL9jnJc309yNl524ueMYLEvam762dwlGT9FzBJmGio/HwJk4d+dmwhlWIT4phfg
	 kw26ZYMfc2iHd3q/8OOLbhK2S2BsixguZXM1nitz1c/R61nUBsPE4LdM9SZ3QEGYEvAOa
	 CP+3MgZRIAr5Tcz6usi8A7lzeLUJWyimSFa+4He1UD2//YonCGBlDJfw5RLYh6BGi5KcP
	 86fnLoDtKHkBmUP+tM/dFj1sZ1bqjf9cMWpICRT+jX5BSGAxGhcuL/n8x8ljQGBpGMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315076;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FiB0bnzAL+9fgSIngeKjFdkrDvMzajw+BHFiWWLpUJY=;
	b=KRXusrmaXos2mLh/co6tu2d3OrATDCJndSvetbJgfjgRAm+kqYXZ3rAQuO6MLNfI8AoV
	 iqViIJa/41IrvpqFN2O/GNIUk8BsLaXOatoMN4NQiaU6dd2iPmK7uujVzxuIjqRUmF4wM
	 x1/TGKATjmd8qqBCwxW9tmBfgoPqe/z1Kk9K3mSvxx5xw9aLHY64hIEq3hUqHu7GvAR1e
	 NNPZWDOrvm88p7J/oigRPuxJzumv7YAlot+7zRwjK7vGvW2g2y3vdqq9rIh2j6BJRoqn7
	 x3lji92n43TDUE/vZr+k+lMqDEt9zbEyQf9AP3AvVyvPL4WLn/5PjSj1NRkHKxt2psQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Fp/FGpJB";
	arc=none smtp.remote-ip=91.218.175.141
Received: from mta0.migadu.com (out-141.mta0.migadu.com [91.218.175.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16A606A332
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 12:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC16A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Fp/FGpJB
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=0pr4lLJKwhi9QGw9XNdz55Gz73CE7vplIUdOveywHIQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315073; v=1; x=1794919873;
 b=Fp/FGpJBhkSpHAlvqqnYhMXs0wp8VpdPn1FGT9Os3jDNzhHpEz0N2KAid77bHndLQIZhM8TT
 UNI1iqn1O4993mBffjBcIBEe/ZhUFX/cJ76p8SDcXxkEHCJYwsX1OqHOwn+jfL5wnAvj00vJVSn
 ukkYywhX8DB4HLYQITlf85mI=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4d15d57ac6eb10cd;
	Tue, 10 Nov 2026 12:51:13 +0000
X-Mizu-Trace-ID: 4d15d57ac6eb10cd
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	devnexen@gmail.com,
	zhaomengmeng@kylinos.cn,
	emil@etsalapatis.com,
	yphbchou0911@gmail.com,
	mingo@redhat.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 5/9] tools/sched_ext: scx_pair: Reset pair_id on restart
Date: Tue, 10 Nov 2026 20:49:57 +0800
Message-ID: <20261110125001.4167503-6-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125001.4167503-1-cui.tao@linux.dev>
References: <20261110125001.4167503-1-cui.tao@linux.dev>
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

pair_id is initialized to 0 before the restart: label, so a reload
triggered by an ops restart (e.g. a hotplug event with the scheduler
providing no cpu_online/cpu_offline callbacks) jumps back to the label
with pair_id still holding the previous run's counter. Since f546c77038ab
("tools/sched_ext: scx_pair: fix pair_ctx indexing for CPU pairs")
pair_id is a dense index into the pair_ctx array, so the second load
starts pairing CPUs past the end of the array and the scheduler can
never come up again.

Initialize pair_id after the label so every reload starts from a clean
counter.

Fixes: f546c77038ab ("tools/sched_ext: scx_pair: fix pair_ctx indexing for CPU pairs")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_pair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_pair.c b/tools/sched_ext/scx_pair.c
index 35c8a1a07f56..f15093e002f0 100644
--- a/tools/sched_ext/scx_pair.c
+++ b/tools/sched_ext/scx_pair.c
@@ -48,12 +48,13 @@ int main(int argc, char **argv)
 	struct bpf_link *link;
 	__u64 seq = 0, ecode;
 	__s32 stride, i, opt, outer_fd;
-	__u32 pair_id = 0;
+	__u32 pair_id;
 
 	libbpf_set_print(libbpf_print_fn);
 	signal(SIGINT, sigint_handler);
 	signal(SIGTERM, sigint_handler);
 restart:
+	pair_id = 0;
 	optind = 1;
 	skel = SCX_OPS_OPEN(pair_ops, scx_pair);
 
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
