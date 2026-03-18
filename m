Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A636AB6E
	for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824050; cv=none; b=gM70S4Y4oQpL3cZj8Ent0QWD63VtFRf056foWrBoJ0RA5yaDZl7B08bFD42cGsKoZGS83R2pi//BlSYDiY4x7lKe8/0PwMHptv40Gv4z4cuwpixzJ8QXusadT8XNj2K263JD6Do4dtmZGT/EpKvR1QOAH04E+Z5W6pm0uPvqAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824050; c=relaxed/simple;
	bh=772FT91vOzTy79kAR1e12rWztA2xnFttMlcdGMjdOJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5RRZbIExMzlJES5ohJKnTGK8ETj3C0xFSBBFdfjgo6h0i82EwhvLkFxr3b+Z3jhBvyo0evlfqzjuFjMdlzm2sA5lYpfNAUCa1FW2ZUdAaQ3cCwrZPMtZNcxquNYfsrEFubi4F6h/y4w0sjyXJ2cxdXk1DMKobG7NkUzHlI9D2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpgU0Q+4; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpgU0Q+4"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ab232cc803so31725655ad.3
        for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773824048; x=1774428848; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDCiBlD0RMPPvZvuirG6UUNdN1vYcUIKgUuyd+p2/z0=;
        b=QpgU0Q+4nabT6qImnlfCSeDOdh5JR/iScoOhR2BFL++4s9cl3EYgW5iQbayfAPniSp
         vkbglgUqFRsk/VEu1l/DVGkaBDh1rh0P+D9Wp5ZzOFuPkP1Kl/sfZpsp6ACuD3dUrLMn
         i6UuEjcoKFKEQQiVfptjK7I5asGLHHt+vlD7+M9fwXC00rOVB9RBnEytH+7w0jWs+HnE
         RsLZPTjuRy/YZtaigCMz7CY6YcykVAExxO483h2Xk00Mpt24nTacRYS1braXbD8jo+5t
         727DjhN0HZj8rHKrFnWU9lrS8ARyIEGvNKFuGqLyu2F4z15yIklzSFLkvJ/GxepiELf8
         1zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773824048; x=1774428848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDCiBlD0RMPPvZvuirG6UUNdN1vYcUIKgUuyd+p2/z0=;
        b=L9FddAcCa9sQNTBX9EYgmVgWxrz/SFxf5K+kBc97uBDusWSOx2Y+KcfQPla4DOqUBO
         UeXCG1XlT8uZi1h5Q1zjHircS1S4wU/tr1EcM58ZVFJrAfLu0oM9jPgMRALW40g6prr2
         INBmOsjf3lG9ofoFVXwtKfobJpgdavfemr2NecBRaYh46u9FEdXrYOIJ8+q34I8YhDyT
         PU4UmGPaxWzqnBpNfpg2fW86Pn+Ec9bXillXW2aDA26L/H04sqFRuTwm6dRewpdT30qU
         KsaQCnfXwePKH/sfDT3R9/0Y2vSOWPfYXEdIrNFp4ZlEsXJE1DXzFqOHlJ0PBvQ/F0JL
         8JZw==
X-Gm-Message-State: AOJu0Yz5rN/V2ByzuXjbpoStQ9EiXqAIqoOJOT6yCoh0o6jqmeeXjLzf
	nGAeNFwbRR29eBlcd7Hw5fucbi6D8XmkZWbD11DAWoKw2IcSVCfzjKQO
X-Gm-Gg: ATEYQzwVDVXfTnOl8LgaWeNqqavzP02UTPJDOiIYuor4Dp4CgwfNrmCkyNffeCHXKcI
	CgRfmLkv4NiJ0X4d2Jmia+CIfNXlpBz2YmIpYpBNaIpxRO1aDje6X06JULa67DXsE5Vw/HMqEIz
	gyA61wx4u5PWcl/GYavQecGxoQ1J3jNTx8lgUo3wNGCqNa0axiUXj7n4P0GrRIA4GEYhibhHT0N
	NFHxJQmXKlRZJ9YreD0004L89lsejnEDU5j886m54yg2TzkGql4GelyaIxYrTroug83hGOp/IN6
	hgaMbq4X9mN3eifCQ8cF+UB/1+qlgdflVhg9cpawuJbCZSMjud86STAcLMu1+0l7PPHTfFRKHIH
	A6c1DAuw4UQ5/JFD28Ul5+nsBnnJdW5b+2xwGpFWTeo26jqPzuYgu4OGI5LoMlNiwDTsW4YPahy
	JhdR/TVM6gcqOM6NoVVdK30WTlqb+9QmAwIbRILAnh
X-Received: by 2002:a17:902:d545:b0:2b0:52f1:e343 with SMTP id d9443c01a7336-2b06e3bc795mr27113205ad.35.1773824047687;
        Wed, 18 Mar 2026 01:54:07 -0700 (PDT)
Received: from SH-PF5NDYD6.Hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e61cacbsm18927455ad.72.2026.03.18.01.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 01:54:07 -0700 (PDT)
From: Ke Zhao <ke.zhao.kernel@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ke.zhao.kernel@gmail.com,
	yphbchou0911@gmail.com
Subject: [PATCH v3] tools/sched_ext: Update stale scx_ops_error() comment in fcg_cgroup_move()
Date: Wed, 18 Mar 2026 16:53:49 +0800
Message-ID: <20260318085349.78063-1-ke.zhao.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function scx_ops_error() was dropped, but the
comment here is left pointing to the old name.
Update to be consistent with current API.

Signed-off-by: Ke Zhao <ke.zhao.kernel@gmail.com>
---
v3:
 - Fix commit message suggested by Cheng-yang Chou

v2:
 - Corrected the new function name to scx_bpf_error instead of scx_error.

 tools/sched_ext/scx_flatcg.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0e785cff0f24..c0574ff416c7 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -919,7 +919,7 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
 	s64 delta;
 
-	/* find_cgrp_ctx() triggers scx_ops_error() on lookup failures */
+	/* find_cgrp_ctx() triggers scx_bpf_error() on lookup failures */
 	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
 		return;
 
-- 
2.43.0

