Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABDF4E3779
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621707; cv=none; b=AiGfRaO/XGLDKB6wfQ6UTO1iH8mzev/Ud+kuSZ8PdP7g/ilS6FmcZOCxG2idJeOIQM+nloUHQiDz8juwcX+YwMzCSgwzA1Q5GhVZK1QhCdYEfAdNGtmr/KKKojLaCWXtv2OLpRdDxR8fu9W0Zs2bConKdXf9NYkK/zoM3/UKlcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621707; c=relaxed/simple;
	bh=cm9Hkdl3WFkDJnA1AsTgeTscfG8x5kzG5lh/+WKqjVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MKYXgdfwQqfN3t1oP5cU2zz4rPLut9A2jUqwg7nKlriAumv6JbzgoWOsWSbTBpgHEBxOSiH2SHHuTzL0S7iuxKHs0a141bSxNL7/hKlFdYL+swNOyV9MEfc10+V8RFBYZNu15v7qjhvNkKZQl8QGPbZeUMk36zO2J4j3iTFPkdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myVbWohk; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myVbWohk"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bdc96b0714so45507e0c.2
        for <sched-ext@lists.linux.dev>; Thu, 09 Jul 2026 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621703; x=1784226503; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yNB4FibH3WaX2Q0O//EnQ4OgaudAbxCSfAgXrsx/kaU=;
        b=myVbWohk50VQ6Sl0p1OUCN61zvihIJbfPJ9F9y8bl0yvlfh7XJKEYfPFA79Owumkb+
         NBCgm3KkgpFun6kKvYD/9m6hTEugsuVwzyD7tNl3QRycplkz5L8uCCcFIQag8P+s8MLG
         mVzJyX1jRywE+m2SewwDlSV9k+amECSAMKTff1YRofDJvsCcWZDqpcTgrd99qhaA72r6
         2q54JE+HhQF8EkDlbT8HWvJtJNKDBf1gkb4ggnUcAg8Dgo/OFC1nU/Hy5Il3WDcpsa0B
         irxwGzRSuUiQzeyrtPYDnAMJ3CQcRcl/MlZsaSdBmsndfSbVlWUvRGgTRzKuGJu/fSCh
         u+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621703; x=1784226503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yNB4FibH3WaX2Q0O//EnQ4OgaudAbxCSfAgXrsx/kaU=;
        b=JuJdnI1tOmHLBDULSSZvKH0JZ0NUxOAnclSS4hq6QjlgBGYSEkPxlRhv0FL7kGeSce
         vKNikgVdq6+MRIHt4EK8S0oKd75xwnMUsHTYB+jM+y9P3VWSj6bWKEd4022eSb3Mmmyg
         rxj0VMgbWCVmOmibEpgm0slqC13wmJZpVvG5EEKA1A09mvg4DHw0O73qtYojjEA08JTP
         jnN3f7B2NM2JtMmagXtKynXH/yHlQu2CCdPK3PMMx57VsRPevhCJ0tZn4RM7wJAXU8Pi
         SRHaqo1OhQfqubZ15C6UFWRUibwpawf335wmaQ7bpPnkOHOAZz12qI9NJDyhQAmf3HEg
         j71g==
X-Forwarded-Encrypted: i=1; AHgh+RoDg95Nc26AgxXcyGIJzQGVp5qYSm6lRP3SewqpL4MJnGrdc85ocqMT2m+vmdlc9dyIxJfp9Xu9/7Y=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4r8XObEf6Ov8RBOM35eHllgq8SpmrjuUYe0x2lZABhdCkXFSu
	behmLWgjGZWV++8gkuj0g3u19hIybK/DAFGUm7CuSi46ZZyyb0YwVvGDqRyg6to3
X-Gm-Gg: AfdE7cnvE5uZYJ4t4JDPEtOc/QwBarpgRBm+nmIWQVdlk+1PxGC6LiZvYSkYF+JY5nb
	4oLcGgeD4QBRlF8H6qfVB0D+b+NpG9V1S+tK8xl+/g5otFicws4ndsE/wNsl5mjrsA62xQIcEmV
	lXocvQWDe7gCXpdGAJTMaWr6PR4vaYlqT1mG+84z+p0pDx1wV+rWu3WR1oL5v/92eDQU+jZ8Ovx
	OcFP6/qMQQP9vjnn5JxmtxDy6Bn+UIA2vtrDMUvKUPUUXPnDRQMiy7ZczYClnqQf+sxuZhYLRYU
	S0eg9WS0G63OSqiAhWF4gBQAL9682k/UM81ez5IR2WxVDJ0dQ2dKf1WyiJP7EyUl/SQJJuBG6Vt
	DMELQ2yIp4BK3IdtfE4pHx4Q9cyswVUag03NR8dmFQ3TcunfTtW6+ZdAmzhIqqu3Ce3IURTDzvf
	/7Wzhs7inW7l08gE7Lt7Y=
X-Received: by 2002:a05:6102:50a1:b0:738:1ef6:51b9 with SMTP id ada2fe7eead31-744dfd068demr5800740137.5.1783621702549;
        Thu, 09 Jul 2026 11:28:22 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed258bb75sm3437743241.1.2026.07.09.11.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:28:22 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for bpf_cpumask_populate()
Date: Thu,  9 Jul 2026 14:27:59 -0400
Message-Id: <20260709182800.2037938-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709182800.2037938-1-main.kalliope@gmail.com>
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cpumask_populate() writes to its destination with bitmap_copy(), but
the destination is typed as struct cpumask *. That allows the verifier to
accept borrowed cpumask pointers returned by read-only kfuncs, such as
scx_bpf_get_online_cpumask(), as a writable destination.

Make the destination a struct bpf_cpumask * so populate follows the same
ownership rule as the other mutating cpumask kfuncs. Query kfuncs continue
to accept const struct cpumask * inputs.

Fixes: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 kernel/bpf/cpumask.c                     | 6 +++---
 tools/sched_ext/include/scx/compat.bpf.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index b8c805b4b06a..1336a4efa755 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -449,12 +449,12 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
  * @src__sz: Length of the BPF memory region in bytes.
  *
  * Return:
- * * 0 if the struct cpumask * instance was populated successfully.
+ * * 0 if the struct bpf_cpumask * instance was populated successfully.
  * * -EACCES if the memory region is too small to populate the cpumask.
  * * -EINVAL if the memory region is not aligned to the size of a long
  *   and the architecture does not support efficient unaligned accesses.
  */
-__bpf_kfunc int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t src__sz)
+__bpf_kfunc int bpf_cpumask_populate(struct bpf_cpumask *cpumask, void *src, size_t src__sz)
 {
 	unsigned long source = (unsigned long)src;
 
@@ -467,7 +467,7 @@ __bpf_kfunc int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t
 		!IS_ALIGNED(source, sizeof(long)))
 		return -EINVAL;
 
-	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
+	bitmap_copy(cpumask_bits(&cpumask->cpumask), src, nr_cpu_ids);
 
 	return 0;
 }
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 87f15f296234..3f74d522f7e7 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -84,7 +84,7 @@ bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, st
  *
  * Compat macro will be dropped on v6.19 release.
  */
-int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
+int bpf_cpumask_populate(struct bpf_cpumask *dst, void *src, size_t src__sz) __ksym __weak;
 
 #define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
 	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
-- 
2.34.1

