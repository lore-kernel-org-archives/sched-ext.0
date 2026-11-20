Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795153919;
	b=dPrZl+/t7My91p4AImN3Kk4vm0Cs+UMjKFLYCV2RNyOPJv2AWUPy/v+cYKAgXvtRbSHp
	 EBOsEPhX/psMbg1K45U8yfnc1N6rYLlx0nQjzu+oziI6mBBdDh+iERyEVWcG0IYVQmRnH
	 q9uVSKzZX1VnoOSoZaMYmW1ghdVqK3SiKjFSy9k33u7B8gUTn+uIMNMm7SD4X6MAAFp/7
	 EYuvT9pvzfJ+1Oj3Qn9/jTJaOkSFQkZZkAkIdckpAXQLHQqRIXxQbIMglocXe7Mm4OwsF
	 QQ4ZSNs+5vu+TRn9S3dHNfYGLMUCwf9yoy73IPgj8/zSaaLY8EoPsZfB+1qfUN9X6Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795153919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OBFWFQ3yvSvM14Hz5XmTfrlvvKw/w87tsoZwb4IBO4M=;
	b=c6/pafrVh2WN5+jSUEdz4tdNtXDb77kQOqt5wVHsXGPDwk/NHWgOwT0nJ2gtOR7R+M2m
	 ul09BKHnZo/QCFjFrH+2B1SKYy/lfvsERMhYQEDOVQeTHDENLmdMKsHm6gNQL8SuEv32L
	 kfDhvfKG7yVY8IoYBCDA91buVLvL2Z7h+CQtkfklrQkVz3fWB7Bjx5dBFcYZLP4mEmX1s
	 bYnVX2KSWrqtGtJb/3Bj4xH96+DsaIGjwXHrylfGzpKKmKA+Ze35R0WjzMeUmc9GUgoCd
	 ZXTCWumoUkgYLD8KJMPnDZKd+15HCEovVQ8DPboqDs/CCGfluKaj6zOAuRL9QBQgdog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BxnoogF6;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F9606A325
	for <sched-ext@lists.linux.dev>; Fri, 20 Nov 2026 05:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A5F9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BxnoogF6
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b3fb193c03so286835a91.2
        for <sched-ext@lists.linux.dev>; Thu, 19 Nov 2026 21:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795153918; x=1795758718; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OBFWFQ3yvSvM14Hz5XmTfrlvvKw/w87tsoZwb4IBO4M=;
        b=BxnoogF6U3bkgO9x6cr4YrpCHsDDXnE9xl7ZpOp1Ek/grvQeazH5mdKc/utRDBMXGh
         BcF2snevSHuoB1zCQXJPJTlGCgSIC+jGwnl3kBVkGD4MS6qIV6tOlEBVb4J51My1cuyn
         hR8gXKLr59Cfawo52XSf8N3zTAoHUw7xenN4vmufl7GNUPemfJTcHex9caIjyTRsmDE0
         E77MaGWkQvadLW8FEBaf3ZdJYTl9HLTUFcQfFF6v8Z0rWAHUE5CbyzSzZq4fgAcLaqIA
         eh/8HTRQ0dZ6KyjVk9UeWQKDG1cKe14hUQei6K1nb5/oS8esk9dxzwnVpJnGksdrnh6x
         +VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795153918; x=1795758718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBFWFQ3yvSvM14Hz5XmTfrlvvKw/w87tsoZwb4IBO4M=;
        b=Z/Hr52SzHj4fDOA3x8kbycScFRdPcvUWVLAVQJKybL/zEb3P4sjltRJCdl7Uhc5lHo
         +ftgX0vF4SnVA8uSqJ+jf3fiMNDivfp2JsvupewpfvKFexOtM9P7ZeWSq7/w6uyjnX1R
         XAWvpmz/YG3UjC1dCO5BVTinP+SeoId2SE7bmKLB5EizAo3vrrxvtUrSw9xzIGcCUuNb
         r2kHmeotJn9IX422NpdfKesF7X2c+nS3gLace45JemER54NcSRM6RPOVtyMvnot/vwon
         hwaJo1Hb3NzwlY+x7Gw7JgsY55P4BaGeoEpgD2SY0+Vkp7DNtmCfP6zFTxLoovUL7u1u
         h3NQ==
X-Gm-Message-State: APuU4Z96PngpD5p/4CT17jikW87K1ZQEofgQEFcJmaPt3w26YAYOHqdJ
	6nPR09yMOGNnqrkonYmqVq7mFw2dbv1dfthcLyVIHJxZg6lhnYWYwxNilL5RjQ==
X-Gm-Gg: AZFdTZdUAVOwZBH9Nw/7yhcKVaSQDOdHGZN11CJYRQWTm2b2aYcEBUCVN5dCPXPQw+q
	BVXdf9zSSp4jS3PVhc7J8biaNicMuBuVyjxzXe5TLi67nN0aZ1UBLpO3j2iBWJQ3DWqyfxpLSZR
	9QPpzeAvCM1sRcsCrCNjNptQzuCbMOW6mv1o7q/AO/q7IZ+qAIJPodM8INvRwSUo/fukyw+Zg4R
	770GiPPu8A68VcUp0PpUFCed91tL8fwlc0oGp/fj+XKS1KfkPlqXWYTcuuLsA2VJcXqVgcZskz1
	P+wL5NwBl0rq4rO4uwfCkT13pg9HjpkRJuAk9haexJ+/Z0USfRaGMWsunwa9vYHcciybw1iCpJi
	fo2RigWBEruGURmbHhoDqANyqMfd3V6SK4YpJ5+c1PXdDuMQStRhOXoyRvpxcQvd0ZOkI+ad5/l
	Ft0mEzQWxtt4OFZs8bpxk/3ERVzUXI2kxjXz7gFEquu9aW1TSeTglQmjNpbsfcVgP6X88VAF9HT
	fjLDp1PICYk34sRNugBDl4eEi91WFxInbvqzP8l30g+vbuTatGKkGdW1Ig5Tshwj77JA9VZ6wWq
	D7t/qE2D5sEMUgDRmORBiu0/RXD6O/nQqCdHbPm6RdBhsb5KSETLffu1WClDGfh/
X-Received: by 2002:a17:90b:380f:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3b41cb0cae0mr1572880a91.51.1795153918487;
        Thu, 19 Nov 2026 21:51:58 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40a878d50sm5104045a91.11.2026.11.19.21.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 21:51:58 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	haoluo@google.com,
	brho@google.com,
	joshdon@google.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] sched_ext: reject oversized dispatch_max_batch
Date: Fri, 20 Nov 2026 05:49:08 +0000
Message-ID: <20261120054913.3795562-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

bpf_scx_init_member() accepts dispatch_max_batch values up to INT_MAX.
The value determines the size of the per-CPU dispatch buffer, but
__alloc_percpu() rejects allocations larger than PCPU_MIN_UNIT_SIZE.
With BPF_F_LINK, an oversized value passes the struct_ops map update
and triggers an illegal-size warning during link creation before the
allocation fails with -ENOMEM.

Calculate the buffer size using the effective batch count, including
the default used when dispatch_max_batch is zero. Reject values above
the per-CPU allocation limit with -E2BIG during the map update, before
the allocator is called.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/sched/ext/ext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..93128da6b126 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9197,9 +9197,14 @@ static int bpf_scx_init_member(const struct btf_type *t,
 
 	switch (moff) {
 	case offsetof(struct sched_ext_ops, dispatch_max_batch):
-		if (*(u32 *)(udata + moff) > INT_MAX)
+		u32 batch = *(u32 *)(udata + moff);
+		u32 nr = batch ?: SCX_DSP_DFL_MAX_BATCH;
+
+		if (struct_size_t(struct scx_sched_pcpu, dsp_ctx.buf, nr) >
+				PCPU_MIN_UNIT_SIZE)
 			return -E2BIG;
-		ops->dispatch_max_batch = *(u32 *)(udata + moff);
+
+		ops->dispatch_max_batch = batch;
 		return 1;
 	case offsetof(struct sched_ext_ops, flags):
 		if (*(u64 *)(udata + moff) & ~SCX_OPS_ALL_FLAGS)
-- 
2.56.1

