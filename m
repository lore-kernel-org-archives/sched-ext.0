Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514722;
	b=gUUi8VgeIzTj7YEeZGt8TNXH+Fypak3JZM6Fg14SPyNCg42suz9c3lsGlEuYx3C8yqfp
	 l0rjKVqLQISCs/RyJ7mhZknVWN8hy0iwT0oRkCy6IKwWBdF8N4F6+LcZNa4nDYlcKQAty
	 Ws63ynX/IHr0XXsVvKboTLm7QBvrfhuiWqRjlZ6MGATwk+RB5bvMLhr6WvCP8KkZdipj1
	 BVYACeQQwyb5iob9OHUK5u4TS0GwObflDqLSMp/D2IAsL1kRZjNrOPcw8Vm+qOJJj6Gdp
	 x721RdvfsLLkjox9X7DyBDYMEJca/s+wv+ibSLb0MgK0i613e3e9bXpilvJwUPAv85A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=h8PsPIoWLmVL975tN402YNrehaZsdtj3RGMKgtoV45I=;
	b=QuxOxLDSZ8KfwNs5UBr/iElCu1hs9lDSEbGr+AfWcuTJLUQh7mRUc8i+JEOxmPv24IhE
	 jj3+zh8uoNjBv+un17xZolyCrXr4wGJzy0OAyncO+v3Jf4LCVP6z6gJZET40OG1EA9wei
	 j296+c95Okie7m3v/Hr+P+22JbFALTTGnBbwt0K/Q2ogmPXKSqP5m4NE7GcaptXlACMpj
	 cAiIcz+CrrSFLj/bWAXlHoiRNmo+qkejN7m6tDFqLLgF97d5Qr9KWnc/tQJOyXbNE/iy1
	 upoumubkmH1MMzIuDngPtFz7ibAEu8Oc8BQbgTAeIxHzIBZ94PV0bEXSb8/H8YK5ZUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XQsm0/gN";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7CC606A326
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 10:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B7CC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XQsm0/gN
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38692f62b22so3976342eec.0
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 02:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795514721; x=1796119521; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h8PsPIoWLmVL975tN402YNrehaZsdtj3RGMKgtoV45I=;
        b=XQsm0/gNvQOrG0KBt2pbdLhdBQICGv6MmBGCLhTB1wpXbARrvbzJR0Cyj18LeehigJ
         vr/umCSVRvJrrnNMXVXyJKcZMeWhQxLbZH3qzHEZr0Tw4VCc1BLDL9AIVBOPtZliAX4H
         QZ3XsOdCN/9fVFfQteiHyaHoluqbD9wEw7nr439srGdEPDsyCEEq/PFgZt/kBN9Qzp1X
         03dR4r10xwWNvrPnyS+CMCDgayj/xQlP1TM7sUX9zXPRg2C65hbZoR4CaFKmbtQwo2rw
         S5EOIY743/OTithPkXDCK8defHUgZfxCYq2o9ywrtB4s4ac17HQSImBEC1AhUn8F5wiu
         61zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795514721; x=1796119521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h8PsPIoWLmVL975tN402YNrehaZsdtj3RGMKgtoV45I=;
        b=AjkCzhAWY14q+aXId2+222Inlmz6xTe7TR14YY4ZkMt7v9AzGQ2quLe7MeLHIFnKLV
         F/mw0i7pPG/+r49Lj31fNmHuAyaaIovQOtvMmyQCPy4zNpHBQKdftzqMj3ukOFbScRQl
         xQosWXi4dvuvz8fwCEqqN2BvgCOoHqufELodJyBkg1MV5sGBJ0hDaYVBHJSgcu/QaoR/
         VGYXO6aWAbjYqmSFD/RHyY4NEImYYvSLx7593W4rHIxjLBGqvZRLcM/AjbM+G9iam5AV
         8931lSKreX68zsQj2Do20l0S8oY7r4tc2bnWKyME6Urcy0eMmm4hvqSSMnctyg3NS/4h
         p3gA==
X-Gm-Message-State: APuU4Z8KQSlvVDSzr5aqmHQmHdC/GrL6wtimX4jUWPd3JlwnRlqlMO/P
	sJH5gDVkJ9qILlbKpaCyLgEHfcwKUDqExRZ9dONVcsjKs8PM8fzfMV56
X-Gm-Gg: AZFdTZemDi3JCdoays2pEbq/IwLgYUXu2FquEUAM75fg1VXvVxZiaHHygvLEt5NFy8A
	XWfc9CcQqeAUbm+ZHTLdWQbXjcZPgkrV9QIAIREOsGmj1xuPDNjmWjuK74+fSXn5YpjYqky2JTu
	gh7fibCyr1LJYzcJuQbeVzK5wrE/T/tDZ5iBdJGoTo2ASHLTYCgWIiz57ZJgkJkf39Z2aBvxG2d
	7gRI1e/p9AofM7Z0FE0PAHlGo5lzUrPTgvPvHebZTpf/lHCfxuerQZw3ucrZiFkeXH2HP7WKS3N
	hbx5ReDY+FTa9ZVk45w3+61b9DuDeLKoAls4YL6cHYxwBI0Di4YfSoMyyb1Us+4/miuSD+rL8Eq
	o3ZGU4YTY+EkE860nq0J47G/iAzPd91no3GUQk1acFD3tluCG+4frf1akv5jHR/SH4BwIz5e1b4
	0+EtiiUDb/sXya8Mv4u24baKkCvZJEmnClTq7PermCTrKQVRYo1GfeMFxQWAlldZFye7C30reP6
	66r72xheG94ejplSYNUGo2IMOPfTqJOAs9bws6S7oDOT5tSvR1K0MXaoT8wdgPU+7Leg2vDhnNT
	HdfGPBdls2xM0xwSTb5Tu+VVM0XlPadSN9NCtAFb+DX4LfWSHmDhvL7kSXKNwvDP
X-Received: by 2002:a05:7301:3a82:b0:374:ea35:9069 with SMTP id 5a478bee46e88-3856fb67380mr13583566eec.39.1795514720624;
        Tue, 24 Nov 2026 02:05:20 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm19080284eec.18.2026.11.24.02.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:05:20 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: reject oversized exit_dump_len
Date: Tue, 24 Nov 2026 10:05:03 +0000
Message-ID: <20261124100508.1060692-1-rhkrqnwk98@gmail.com>
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

When a BPF scheduler is enabled, alloc_exit_info() allocates the exit
dump buffer with kvzalloc(ops->exit_dump_len). bpf_scx_init_member()
stores exit_dump_len from the struct_ops map value without an upper
bound, so a length above INT_MAX reaches kvzalloc(), which warns and
fails, and the enable fails with -ENOMEM.

bpf_scx_init_member() already rejects oversized dispatch_max_batch and
timeout_ms values with -E2BIG. Reject an exit_dump_len above INT_MAX in
the same way, so that the map update fails before the value is used.

Fixes: 07814a9439a3 ("sched_ext: Print debug dump after an error exit")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/sched/ext/ext.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..6dfe70249a7d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9221,6 +9221,8 @@ static int bpf_scx_init_member(const struct btf_type *t,
 		ops->timeout_ms = *(u32 *)(udata + moff);
 		return 1;
 	case offsetof(struct sched_ext_ops, exit_dump_len):
+		if (*(u32 *)(udata + moff) > INT_MAX)
+			return -E2BIG;
 		ops->exit_dump_len =
 			*(u32 *)(udata + moff) ?: SCX_EXIT_DUMP_DFL_LEN;
 		return 1;
-- 
2.56.1

