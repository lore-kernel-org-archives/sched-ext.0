Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795157777;
	b=f9r+UI5X/KYMJVzPvyX3D9TNbrXUUSop0Xa8yHNSwHgZCMm9fV5sZC3ZDRkN33GONkm1
	 vF+KKPnjnrS5c78tem60GTqFK5oXB3SGw1ipmd0wR6ohFIfokp4TDa+VTLp0oOMk164hZ
	 7QRQR8gpByKxyqbfzZ0zIVc/duh19Oq5VMg78XvTmY8zzjEssmc3BCTBEt0vqU8V3iIQl
	 vVimwhymp9Xw4RvjFj1zJ+MhIle1YQ76fKuU+BlPhZL7xn8URAy2tGMGzwru7f70ajIsd
	 Yz6Hyc3Kupt8ESCYSrKwDgxVfEclnpTUe01vT/5bDXEALH/bcVCn7JHOugBWyPBcf6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JSpsy0UKa4DIFK4RDl3FsapGjP10wN6PK5z9B1SUUFk=;
	b=C0BP0HZkecTJg8W1hooO4+Uzbr9pia5igRNdaRAASzV1SktdDEPFlDqQdoWapPO3Jmj4
	 ZyznHuFUqGBO5OR+RQK7ULV5QEeud/amAlslmtM0eElMYCuOaeipS7j4wszoWAdu9eePh
	 Q1gYq/O0g/gz8RbboZul9/WCBxtZV7AKFdc1860AnM3wLV4H708gzuwbvDzt3/JERs8PR
	 ZeOzrngDlCeRN2IxUwT3hPjwl5AOXhc+mRoKjrZC91zd+wkxuWZtVMFJpGNrHn2dzb8d6
	 HcdDPHyJT1daI4U2fe0k8X+U/nvoJJXTZPsQsO3Cv64+/rRDeF/YHZZLzMmkNIb6tlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4DTrecY;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9A606A325
	for <sched-ext@lists.linux.dev>; Fri, 20 Nov 2026 06:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C9A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4DTrecY
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso407873a91.0
        for <sched-ext@lists.linux.dev>; Thu, 19 Nov 2026 22:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795157776; x=1795762576; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JSpsy0UKa4DIFK4RDl3FsapGjP10wN6PK5z9B1SUUFk=;
        b=P4DTrecYs9I6urL35WOwv6B1UN0TO1mYj+U4xMe1eoTyTCaT4AYLf+Gv3tos/rL10E
         DBTLPE9VQNu6CCBIAiAWzVw38zWNvFZit+jT4nmI84DmUyWaEBYA49Pwq9/YHh3/q1h0
         Z9624/AcMqZzwihrXTPN57j5HJqg9yyz1FeTYdK8PJKboxdheHFjzMLHnEza7z1fKOEa
         PyWSdJUd1UfXXWfxyhEMRdlssiJU4YcKcNva/6GITHZm8ljg7TsxZX1yBVhe9O98fxFM
         hTZ1MECnjPRvxMBImhb3BoSvdbtbJT6BbsqGcCwnrPE2RLRHy5XhKb45qIjnDLweCjxG
         ze+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157776; x=1795762576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JSpsy0UKa4DIFK4RDl3FsapGjP10wN6PK5z9B1SUUFk=;
        b=K4K61wtoJH+EK6y8qioWyogkIbWxb3GQZAmg/ZfNwkXJq79mBxLqlOYG5EMs5ceTdX
         L8r3CvN6zL7Kc3l45qDSmx/qdVcNTUey0si6Nff62YtF9jPcpkoKSYj2EeV60h0hM3Wj
         RWmndWFHp5AGt2T8VubxVpkBrqnk2assaBPp7cejxScZHlApHtzqFXTTgZ7r1TOFCW8p
         ZoX6Mqt1hMeRP4pimzysVm8gmG4pHyG1OtUOJeEEXBFNKJe+nlSyklpMwkQYt4llOnOe
         gn0MyIaEojKUBBNXS5znHLhzHsACGoz9umbbekQs58QW92HYJzu1RKiiHAaieCBo7xYe
         s+Uw==
X-Gm-Message-State: APuU4Z+y1JLcFG+qZ5muSeUsl3fvhtueVbndL8jKiWnPK4iJsqlrNrpZ
	nAOc2zF6mQ36cLbgEY/gkWL0NSGMaVcOp3qA0VmHVEqqsZAaSuXXfHE4Xdm2Jg==
X-Gm-Gg: AZFdTZeXk/fo+1j47yDkUlNtl69QaskG3OspgFFtm9iYniz4SD9r50INFwEvXBQvTKA
	tfUghSakkeaY+Lph4ujJQvr1W3ooPeWwr6SawwZtkIf6QTtcwtkq3xbT1fHEwnBKQNuDjrIzUsR
	oyyzYb+IssnI78eNzs1o6BmhiFXgbbk/NV7Xz2VuWwu1avVCumspVhDLg2mUfHKWOWGtz+9+YgA
	Bw2sTPIDuYxmI+ErkJwk1H5E/J1cxdW8wVoX7j7iYO5wU7NtswKOOYezo2UBWxPM1IfBug/TnfE
	GO9ziMqcRCvh5Gv+clKI/b2l1Ffus58dGNTcThQD0D5RuEprxcyhIdxBi847vMC9SZkL1TYXHGy
	FXPM3WoLbJfLFF2thmL6bvS6mvKW9+LePL+blwP9zYfJfZ/9vV7j2BF4DwdvhOU/8brRImAe/m8
	11vofztcdsjBpD+PHHDEjrPfbaFHK28ISKxDfnotCJosTzfpTgr58SCoyHIorTxntVWkspsSitq
	I7A+VmbsmhgVrvN9hes4cxZK/zRhHL6XcUNqC7mcOTzsSrguPAJ2U7lCaE+87hKuK+f80IKCSW/
	dKn7TuDTD3SChyxXE/NoNs9u9NZnl0eaL+IqUEwCsPExaBvZFcQSaoJSGsMQ1z3h
X-Received: by 2002:a17:90b:4a47:b0:3b3:fc1f:a5c4 with SMTP id 98e67ed59e1d1-3b41c8dc821mr1899005a91.20.1795157775908;
        Thu, 19 Nov 2026 22:56:15 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm1952926a91.7.2026.11.19.22.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:56:15 -0800 (PST)
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
Subject: [PATCH v2] sched_ext: reject oversized dispatch_max_batch
Date: Fri, 20 Nov 2026 06:55:54 +0000
Message-ID: <20261120065559.3979434-1-rhkrqnwk98@gmail.com>
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
the allocator is called. This also covers registration without a link.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - add braces (Andrea Righi)

v1:
 - https://lore.kernel.org/sched-ext/20261120054913.3795562-1-rhkrqnwk98@gmail.com/T/#u


 kernel/sched/ext/ext.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..56d75d179822 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9196,11 +9196,17 @@ static int bpf_scx_init_member(const struct btf_type *t,
 	int ret;
 
 	switch (moff) {
-	case offsetof(struct sched_ext_ops, dispatch_max_batch):
-		if (*(u32 *)(udata + moff) > INT_MAX)
+	case offsetof(struct sched_ext_ops, dispatch_max_batch): {
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
+	}
 	case offsetof(struct sched_ext_ops, flags):
 		if (*(u64 *)(udata + moff) & ~SCX_OPS_ALL_FLAGS)
 			return -EINVAL;
-- 
2.56.1

