Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29D35D615
	for <sched-ext@lists.linux.dev>; Wed,  4 Mar 2026 05:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772602657; cv=none; b=AoyUFBP6Gg4f1WcWMv2LJ2xv+NjdIl6wPd+l9+ibh0gEaATyhyt+Jy5JVRdYwcu9L4qs4AXxJ1XptfU4oSTO1bRax257KqwFGRGau5CA/EPNzTWxlJMGDUQ+4N9Xl9DLQft3KNBz62i3SWQKuAr3dOjf5TZELSubEb0ASUmafKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772602657; c=relaxed/simple;
	bh=/uoLEWePp0ARLfd/KH35rK3IxnzFW8NVcj4sJHWD9mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzU1NL+KEYzOijPn7keWVED7iUGSECOILXYkJk6H4pjMOaR/4EHyjlU2AUx3hxar8f7PwrFXhydBfz3NAml846FiBGxJ3dmVHc2HEf4QvE//OYTIiLyK+ewKyB+HY5HG5nEL0TcFPsDOy34Ax4XpsA2zJCqK6fhiJvcIy3pmZ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2JyjrmL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2JyjrmL"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824ac5d28f9so6540755b3a.0
        for <sched-ext@lists.linux.dev>; Tue, 03 Mar 2026 21:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602656; x=1773207456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqzppm2nTsO1aV0gLTqfvQz1+uYtyuSrrfXq7ggJT8g=;
        b=a2JyjrmLqm3Ok/vTMa3ACCwybWTOGVN/Thq4IzZc5cEH0qsvlpUbXcfcvtpSEEpxOi
         xsmAdK3D607wdRiE9TbcUdp9+yCMCNrbw7JTsV161txsPumK0WXxd3cAkJSYTkXPL93x
         ZvICwfGoB0sjwR+AQ7USs1mSHNCAo9Q5OQIVJKdog2lCTwTCczKV8sfFjLZWPwKSXr7B
         vUiXgiGSodnjY/rfr6ItKvrvSaD2QX1hJv3URAzgohPvnoVAPJAwfmEauAAEWxjSHfV1
         MQ2JKip7+FhgFcuYdlie/km/ejXh3UBDFakofZ4znxfQ1GbzM+YMCD6Vy/bHTFW1i39S
         gczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602656; x=1773207456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cqzppm2nTsO1aV0gLTqfvQz1+uYtyuSrrfXq7ggJT8g=;
        b=aVVjD7YOmC/DijwBb+QzzOZBV1Fkmw6bCOvkkNpqbc4420yIW4yHBT4zN8xh+KqDsI
         MAxpI4a/Hvh4PJ9Xjyl3svyNCMZ+i3kPQ0VULSl0KzjoWOp0E1MoN31Qb6qfcjVVQQS7
         J/ss0t0T5/6wxFctPkYcxtoJT2rexxYN5hrrZW+z6PI8yRRELfztqu/7st3CbxXN+b7F
         Nw1AFnHcTCr63OTRvwrxx0W+w6elOFQXbXjQUIgIrM/5vOB1D9UQoBINrq45Nz1+6oXu
         uE94fZDzvricvRt1w8iENQ1Y4QClrUJyTXa8luyqNA8YPrqyHrM3lxk5ne/MtC23hccD
         Y2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlE3SZJCeKGaYfIctLV3MIFab4b4BvhpB+iNkp0+arplChm6VrUTGh/p1TaNP6L8RA2jdIpFmlR+c=@lists.linux.dev
X-Gm-Message-State: AOJu0YyWtMpptiBWBAAAOP+DXEd5BViw9tyqfnRnKDQaAHJEU5IbJAQB
	U2qYmSMjBrkgpV6dyYTfUcx3A/N0k9vmeWZ9/vCxa9582pbqh6+sUQMH
X-Gm-Gg: ATEYQzzcYgEMltjv7k/PaOoqRBUBeShffjx+ck9QosDn8YS1vkSzd+z+a/H69zDsoc3
	uQpf60Gb3Y7esvic+BVcQqKx0d4SZNu1bBF4KPkaOL7A+WVceSSOwfIh1WFfRn8ZQ7+01jolxUN
	TQEu3fAhiWM8ofMWJdavPRtcmpyGefvfwDoeXBIMZ+3qKNEXu9gfNgzp34gaYSM31CFPP71IX38
	PFuRXMg7llMWuavhLEvvM/8aPmm1MGmk0g3IzBdWXq8whybJJF18hsa1YMzaX9MOF/GZ6BJFtOy
	cyOMUVNA/nBUdUhwmtsiN1wFvmtSOJR1RT2lMmiR8julYdOp1QfgC3l+8BZ8DxONIPB467yq1R7
	vIxHlDpA7uq5ixf4rBybV57lBvovgWPiikR/jh+fG/pNTU0QyDcu/NBwoTWG9Up+VQ8VnYwm5Yh
	zZRdFkkuktFeBRDlB0o8viwrXUWwIF4BzAxqQcOeVbnIDK1A0fvYemDGSMBOXLYsU8O9ar+rGCX
	fI=
X-Received: by 2002:a05:6a00:3e16:b0:81f:3cac:38a1 with SMTP id d2e1a72fcca58-829729093fcmr852331b3a.6.1772602655946;
        Tue, 03 Mar 2026 21:37:35 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db3ab8sm17496964b3a.27.2026.03.03.21.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:37:35 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched_ext: Use WRITE_ONCE() for the write side of dsq->seq update
Date: Wed,  4 Mar 2026 13:37:30 +0800
Message-ID: <20260304053730.557800-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_iter_scx_dsq_new() reads dsq->seq via READ_ONCE() without holding
any lock, making dsq->seq a lock-free concurrently accessed variable.
However, dispatch_enqueue(), the sole writer of dsq->seq, uses a plain
increment without the matching WRITE_ONCE() on the write side:

    dsq->seq++;
    ^^^^^^^^^^^
    plain write -- KCSAN data race

The KCSAN documentation requires that if one accessor uses READ_ONCE()
or WRITE_ONCE() on a variable to annotate lock-free access, all other
accesses must also use the appropriate accessor. A plain write leaves
the pair incomplete and will trigger KCSAN warnings.

Fix by using WRITE_ONCE() for the write side of the update:

    WRITE_ONCE(dsq->seq, dsq->seq + 1);

This is consistent with bpf_iter_scx_dsq_new() and makes the
concurrent access annotation complete and KCSAN-clean.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 576a9b13eabf..49af85a697a5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1137,7 +1137,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	}
 
 	/* seq records the order tasks are queued, used by BPF DSQ iterator */
-	dsq->seq++;
+	WRITE_ONCE(dsq->seq, dsq->seq + 1);
 	p->scx.dsq_seq = dsq->seq;
 
 	dsq_mod_nr(dsq, 1);
-- 
2.43.0

